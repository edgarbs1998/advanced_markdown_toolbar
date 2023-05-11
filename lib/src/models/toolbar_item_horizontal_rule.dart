import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 11;
const IconData _defaultIcon = Icons.horizontal_rule;
const String _defaultTooltip = 'Horizontal Rule';
const ToolbarFormatOption _defaultFormatOption = ToolbarFormatOption.character;
const bool _defaultNewLine = true;
const String _defaultCharacter = '---';

class ToolbarItemHorizontalRule extends ToolbarItemButton
    implements ToolbarItemFormatCharacter {
  ToolbarItemHorizontalRule({
    super.order = _defaultOrder,
    super.enabled = true,
    super.icon = _defaultIcon,
    super.tooltip = _defaultTooltip,
    super.formatOption = _defaultFormatOption,
    super.newLine = _defaultNewLine,
    this.character = _defaultCharacter,
  }) : placeholder = '';

  @override
  final String character;

  @override
  final String placeholder;
}
