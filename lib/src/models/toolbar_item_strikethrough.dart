import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 3;
const IconData _defaultIcon = Icons.format_strikethrough;
const String _defaultTooltip = 'Strikethrough';
const ToolbarFormatOption _defaultFormatOption =
    ToolbarFormatOption.characterStartEnd;
const bool _defaultNewLine = false;
const String _defaultCharacter = '~~';
const String _defaultPlaceholder = 'strikethrough text';

class ToolbarItemStrikethrough extends ToolbarItemButton
    implements ToolbarItemFormatCharacter {
  ToolbarItemStrikethrough({
    super.order = _defaultOrder,
    super.enabled = true,
    super.icon = _defaultIcon,
    super.tooltip = _defaultTooltip,
    super.formatOption = _defaultFormatOption,
    super.newLine = _defaultNewLine,
    this.character = _defaultCharacter,
    this.placeholder = _defaultPlaceholder,
  });

  @override
  final String character;

  @override
  final String placeholder;
}
