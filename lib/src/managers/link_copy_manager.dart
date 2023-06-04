import 'dart:io';

abstract class LinkCopyManager {
  LinkCopyManager._();

  static Future<void> copy(Link link, String path) async {
    final newPath = link.absolute.path.replaceFirst(link.path, path);

    final newLink = Link(newPath);

    final target = await link.target();

    if (await newLink.exists()) {
      await newLink.delete();
    }

    await newLink.create(target, recursive: true);
  }
}
