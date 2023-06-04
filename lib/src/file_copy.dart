import 'dart:async';
import 'dart:io';

import 'managers/directory_copy_manager.dart';
import 'managers/file_copy_manager.dart';
import 'managers/link_copy_manager.dart';
import 'managers/observable_copy.dart';
import 'managers/observed_directory_copy_manager.dart';
import 'managers/observed_file_copy_manager.dart';
import 'types.dart';

///
abstract class FileCopy {
  FileCopy._();

  ///
  static Future<void> copyFile(
    File file,
    String path, {
    OnCopyProgressChangeCallback? onChangeProgress,
  }) =>
      FileCopyManager.copy(
        file,
        path,
        onChangeProgress: onChangeProgress,
      );

  ///
  static ObservableCopy watchCopyFile(
    File file,
    String path,
  ) =>
      ObservedFileCopyManager().copy(file, path);

  ///
  static Future<void> copyDirectory(
    Directory directory,
    String path, {
    OnCopyProgressChangeCallback? onChangeProgress,
  }) =>
      DirectoryCopyManager().copy(
        directory,
        path,
        onChangeProgress: onChangeProgress,
      );

  ///
  static ObservableCopy watchCopyDirectory(
    Directory directory,
    String path,
  ) =>
      ObservedDirectoryCopyManager().copy(directory, path);

  ///
  static Future<void> copyLink(
    Link link,
    String path,
  ) =>
      LinkCopyManager.copy(link, path);
}
