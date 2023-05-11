import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 9;
const IconData _defaultIcon = Icons.check_box;
const String _defaultTooltip = 'Checkbox';
const ToolbarFormatOption _defaultFormatOption =
    ToolbarFormatOption.characterStart;
const bool _defaultNewLine = true;
const List<String> _defaultCharacter = [
  '- [ ] ',
  '- [x] ',
];
const String _defaultPlaceholder = 'Checkbox text';

class ToolbarItemCheckbox extends ToolbarItemDropdown {
  const ToolbarItemCheckbox({
    required super.order,
    required super.enabled,
    required super.icon,
    required super.formatOption,
    required super.dropdownItems,
    super.tooltip,
    super.newLine,
  });

  factory ToolbarItemCheckbox.withDefaultValues({
    int? order,
    bool? enabled,
    IconData? icon,
    String? tooltip,
    ToolbarFormatOption? formatOption,
    bool? newLine,
    List<ToolbarDropdownItem>? dropdownItems,
  }) {
    return ToolbarItemCheckbox(
      order: order ?? _defaultOrder,
      enabled: enabled ?? true,
      icon: icon ?? _defaultIcon,
      tooltip: tooltip ?? _defaultTooltip,
      formatOption: formatOption ?? _defaultFormatOption,
      newLine: newLine ?? _defaultNewLine,
      dropdownItems: dropdownItems ??
          [
            ToolbarItemCheckbox.dropdownItemUnchecked,
            ToolbarItemCheckbox.dropdownItemChecked,
          ],
    );
  }

  static ToolbarDropdownItem get dropdownItemUnchecked => ToolbarDropdownItem(
        icon: Icons.check_box_outline_blank,
        character: _defaultCharacter[0],
        placeholder: _defaultPlaceholder,
      );

  static ToolbarDropdownItem get dropdownItemChecked => ToolbarDropdownItem(
        icon: Icons.check_box,
        character: _defaultCharacter[1],
        placeholder: _defaultPlaceholder,
      );
}
