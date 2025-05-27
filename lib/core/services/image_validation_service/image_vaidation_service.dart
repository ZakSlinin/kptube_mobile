import 'dart:io';

bool isValidSvgFile(File file) {
  if (!file.path.toLowerCase().endsWith('.svg')) {
    return false;
  }

  try {
    final content = file.readAsStringSync();

    if (!content.trim().toLowerCase().startsWith('<?xml')) {
      return false;
    }

    if (!content.contains('<svg')) {
      return false;
    }

    if (!content.contains('</svg>')) {
      return false;
    }

    return true;
  } catch (e) {
    return false;
  }
}