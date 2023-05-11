import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:flutter/material.dart';

abstract class ToolbarItem {
  const ToolbarItem({
    required this.order,
    required this.enabled,
    required this.icon,
    required this.formatOption,
    this.tooltip,
    this.newLine = false,
  });

  final int order;
  final bool enabled;
  final IconData icon;
  final String? tooltip;
  final ToolbarFormatOption formatOption;
  final bool newLine;
}
