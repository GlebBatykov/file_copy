<div align="center">

[![pub package](https://img.shields.io/pub/v/file_copy.svg?label=file_copy&color=blue)](https://pub.dev/packages/file_copy)

**Languages:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [Package features](#package-features)
- [Using](#using)

# Package features

- copying files;
- recursive copying of directories;
- monitor the progress of copying.

# Using

The `CopyFile` class contains methods:

- `copyFile` - copies the file;
- `watchCopyFile` - copies the file, returns the stream with the progress of copying the file, ends the stream when copying is completed;
- `copyDirectory` - copies the directory recursively;
- `watchCopyDirectory` - copies the directory, returns the stream with the progress of copying the file, ends the stream when copying is completed;
- `copy Link` - copies the link.
