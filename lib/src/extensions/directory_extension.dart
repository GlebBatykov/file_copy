import 'dart:io';

extension DirectoryExtension on Directory {
  Future<int> length() async {
    final entities = await list().toList();

    var length = 0;

    for (final entity in entities) {
      if (entity is Directory) {
        length += await entity.length();
      } else if (entity is File) {
        length += await entity.length();
      }
    }

    return length;
  }
}
