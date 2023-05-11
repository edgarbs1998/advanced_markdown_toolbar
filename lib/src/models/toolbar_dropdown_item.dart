import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

class ToolbarDropdownItem implements ToolbarItemFormatCharacter {
  const ToolbarDropdownItem({
    required this.character,
    required this.placeholder,
    this.text,
    this.icon,
    this.fontWeight,
    this.fontSizeDelta,
  });

  final String? text;
  final IconData? icon;
  final FontWeight? fontWeight;
  final double? fontSizeDelta;

  @override
  final String character;

  @override
  final String placeholder;
}
