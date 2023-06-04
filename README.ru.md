<div align="center">

[![pub package](https://img.shields.io/pub/v/file_copy.svg?label=file_copy&color=blue)](https://pub.dev/packages/file_copy)

**Языки:**
  
[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [Возможности пакета](#возможности-пакета)
- [Использование](#использование)

# Возможности пакета

- копирование файлов;
- рекурсивное копирование директорий;
- следить за прогрессом копирования.

# Использование

Класс `Copier` содержит методы:

- `copyFile` - копирует файл;
- `watchCopyFile` - копирует файл, возвращает поток с прогрессом копирования файла, завершает поток когда копирование завершается;
- `copyDirectory` - рекурсивно копирует директорию;
- `watchCopyDirectory` - копирует директорию, возвращает поток с прогрессом копирования файла, завершает поток когда копирование завершается;
- `copyLink` - копирует ссылку.
