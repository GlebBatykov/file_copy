import 'dart:io';

import '../copy_progress.dart';
import '../extensions/directory_extension.dart';
import '../types.dart';
import 'link_copy_manager.dart';

class DirectoryCopyManager {
  final List<Future<void>> _futures = [];

  ProgressNotifyCallback? _notifyCallback;

  Future<void> copy(
    Directory directory,
    String path, {
    OnCopyProgressChangeCallback? onChangeProgress,
  }) async {
    final fromPath = directory.path.substring(0, directory.path.length - 1);

    final total = onChangeProgress != null ? await directory.length() : null;
    var remains = total;

    _notifyCallback = (length) {
      if (onChangeProgress != null && total != null && remains != null) {
        remains = remains! - length;

        onChangeProgress(CopyProgress(total, remains!));
      }
    };

    await _copyDirectory(
      directory: directory,
      fromPath: fromPath,
      toPath: path,
    );

    await Future.wait(_futures);

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
        await _copyDirectory(
          directory: entity,
          fromPath: fromPath,
          toPath: toPath,
        );
      } else if (entity is File) {
        _futures.add(_copyFile(
          file: entity,
          fromPath: fromPath,
          toPath: toPath,
        ));
      } else if (entity is Link) {
        _futures.add(LinkCopyManager.copy(entity, toPath));
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

      _notifyCallback?.call(bytes.length);
    }

    await sink.close();
  }
}
