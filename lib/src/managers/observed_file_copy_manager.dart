import 'dart:async';
import 'dart:io';

import '../copy_progress.dart';
import 'observable_copy.dart';

class ObservedFileCopyManager {
  ObservableCopy copy(File file, String path) {
    final controller = StreamController<CopyProgress>();

    final completer = Completer<void>();

    _copyFile(
      file: file,
      path: path,
      controller: controller,
      completer: completer,
    );

    return ObservableCopy(controller.stream, completer.future);
  }

  Future<void> _copyFile({
    required File file,
    required String path,
    required StreamController<CopyProgress> controller,
    required Completer<void> completer,
  }) async {
    final newPath = file.absolute.path.replaceFirst(file.path, path);

    final newFile = File.fromUri(Uri.file(newPath));

    if (!await newFile.exists()) {
      await newFile.create(recursive: true);
    }

    final total = await file.length();
    var remains = total;

    final stream = file.openRead();

    final sink = newFile.openWrite();

    await for (final bytes in stream) {
      sink.add(bytes);

      remains -= bytes.length;

      await sink.flush();

      controller.sink.add(CopyProgress(total, remains));
    }

    await sink.close();

    completer.complete();

    await controller.close();
  }
}
