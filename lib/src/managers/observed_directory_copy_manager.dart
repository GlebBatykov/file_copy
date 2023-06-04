import 'dart:async';
import 'dart:io';

import '../extensions/directory_extension.dart';
import '../copy_progress.dart';
import '../types.dart';
import 'observable_copy.dart';

class ObservedDirectoryCopyManager {
  final List<Future<void>> _futures = [];

  late final ProgressNotifyCallback _notifyCallback;

  ObservableCopy copy(Directory directory, String path) {
    final controller = StreamController<CopyProgress>();

    final completer = Completer<void>();

    _recursivelyCopyDirectory(
      directory: directory,
      path: path,
      controller: controller,
      completer: completer,
    );

    return ObservableCopy(controller.stream, completer.future);
  }

  Future<void> _recursivelyCopyDirectory({
    required Directory directory,
    required String path,
    required StreamController<CopyProgress> controller,
    required Completer<void> completer,
  }) async {
    final fromPath = directory.path.substring(0, directory.path.length - 1);

    final total = await directory.length();
    var remains = total;

    _notifyCallback = (length) {
      remains -= length;

      controller.sink.add(CopyProgress(total, remains));
    };

    await _copyDirectory(
      directory: directory,
      fromPath: fromPath,
      toPath: path,
    );

    await Future.wait(_futures);

    completer.complete();

    _futures.clear();
  }

  Future<void> _copyDirectory({
    required Directory directory,
    required String fromPath,
    required String toPath,
  }) async {
    final entities = await directory.list().toList();

    for (final entity in entities) {
      if (entity is Directory) {
        _futures.add(_copyDirectory(
          directory: entity,
          fromPath: fromPath,
          toPath: toPath,
        ));
      } else if (entity is File) {
        _futures.add(_copyFile(
          file: entity,
          fromPath: fromPath,
          toPath: toPath,
        ));
      }
    }
  }

  Future<void> _copyFile({
    required File file,
    required String fromPath,
    required String toPath,
  }) async {
    final path = file.absolute.path.replaceFirst(fromPath, toPath);

    final newPath = file.absolute.path.replaceFirst(file.path, path);

    final newFile = File.fromUri(Uri.file(newPath));

    if (!await newFile.exists()) {
      await newFile.create(recursive: true);
    }

    final stream = file.openRead();

    final sink = newFile.openWrite();

    await for (final bytes in stream) {
      sink.add(bytes);

      _notifyCallback(bytes.length);
    }

    await sink.close();
  }
}
