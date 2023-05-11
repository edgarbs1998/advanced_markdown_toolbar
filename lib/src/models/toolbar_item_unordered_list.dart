import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 6;
const IconData _defaultIcon = Icons.format_list_bulleted;
const String _defaultTooltip = 'Unordered list';
const ToolbarFormatOption _defaultFormatOption =
    ToolbarFormatOption.characterList;
const bool _defaultNewLine = true;
const String _defaultCharacter = '- ';
const String _defaultPlaceholder = 'Unordered list item';

class ToolbarItemUnorderedList extends ToolbarItemButton
    implements ToolbarItemFormatCharacter {
  ToolbarItemUnorderedList({
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
