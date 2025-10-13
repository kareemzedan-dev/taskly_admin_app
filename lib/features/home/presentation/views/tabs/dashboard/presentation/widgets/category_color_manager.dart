import 'dart:math';
import 'package:flutter/material.dart';

class CategoryColorManager {
  final Map<String, Color> _categoryColors = {};
  final Random _random = Random();

  Color getColorForCategory(String categoryName) {
    if (_categoryColors.containsKey(categoryName)) {
      return _categoryColors[categoryName]!;
    } else {
      final color = _generateRandomColor();
      _categoryColors[categoryName] = color;
      return color;
    }
  }

  Color _generateRandomColor() {

    return Color.fromARGB(
      255,
      100 + _random.nextInt(156),
      100 + _random.nextInt(156),
      100 + _random.nextInt(156),
    );
  }

  void clearColors() => _categoryColors.clear();
}
