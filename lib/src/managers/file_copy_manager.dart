import 'dart:io';

import '../copy_progress.dart';
import '../types.dart';

abstract class FileCopyManager {
  static Future<void> copy(
    File file,
    String path, {
    OnCopyProgressChangeCallback? onChangeProgress,
  }) async {
    final newPath = file.absolute.path.replaceFirst(file.path, path);

    final newFile = File.fromUri(Uri.file(newPath));

    if (!await newFile.exists()) {
      await newFile.create(recursive: true);
    }

    final total = onChangeProgress != null ? await file.length() : null;
    var remains = total;

    final stream = file.openRead();

    final sink = newFile.openWrite();

    await for (final bytes in stream) {
      sink.add(bytes);

      await sink.flush();

      if (onChangeProgress != null && total != null && remains != null) {
        remains -= bytes.length;
        onChangeProgress(CopyProgress(total, remains));
      }
    }

    await sink.close();
  }
}
