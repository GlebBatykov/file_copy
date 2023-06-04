<div align="center">

[![pub package](https://img.shields.io/pub/v/file_copy.svg?label=file_copy&color=blue)](https://pub.dev/packages/file_copy)

**Языки:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

Пример копирования файла:

```dart
  final file = File.fromUri(Uri.file('path_to_file'));

  await FileCopy.copyFile(file, 'path_to_copied_file');
```

Пример копирования каталога:

```dart
  final directory = Directory.fromUri(Uri.directory('path_to_directory'));

  await FileCopy.copyDirectory(directory, 'path_to_copied_directory');
```

Пример наблюдения за прогрессом копирования при помощи обратного вызова:

```dart
  final file = File.fromUri(Uri.file('path_to_file'));

  await FileCopy.copyFile(
    file,
    'path_to_copied_file',
    onChangeProgress: (progress) {
      print(progress.progress);
    },
  );
```

Пример наблюдения за прогрессом копирования при помощи потока:

```dart
  final directory = Directory.fromUri(Uri.directory('path_to_directory'));

  final observable = FileCopy.watchCopyDirectory(
    directory,
    'path_to_copied_directory',
  );

  observable.progressStream.listen((event) {
    print(event.progress);
  });
```
