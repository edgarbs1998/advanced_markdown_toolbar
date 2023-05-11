import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 0;
const IconData _defaultIcon = Icons.format_size;
const String _defaultTooltip = 'Heading';
const ToolbarFormatOption _defaultFormatOption =
    ToolbarFormatOption.characterStart;
const bool _defaultNewLine = true;
const List<String> _defaultCharacter = [
  '# ',
  '## ',
  '### ',
  '#### ',
  '##### ',
  '###### ',
];
const String _defaultPlaceholder = 'Header';

class ToolbarItemHeading extends ToolbarItemDropdown {
  const ToolbarItemHeading({
    required super.order,
    required super.enabled,
    required super.icon,
    required super.formatOption,
    required super.dropdownItems,
    super.tooltip,
    super.newLine,
  });

  factory ToolbarItemHeading.withDefaultValues({
    int? order,
    bool? enabled,
    IconData? icon,
    String? tooltip,
    ToolbarFormatOption? formatOption,
    bool? newLine,
    List<ToolbarDropdownItem>? dropdownItems,
  }) {
    return ToolbarItemHeading(
      order: order ?? _defaultOrder,
      enabled: enabled ?? true,
      icon: icon ?? _defaultIcon,
      tooltip: tooltip ?? _defaultTooltip,
      formatOption: formatOption ?? _defaultFormatOption,
      newLine: newLine ?? _defaultNewLine,
      dropdownItems: dropdownItems ??
          [
            ToolbarItemHeading.dropdownItemH1,
            ToolbarItemHeading.dropdownItemH2,
            ToolbarItemHeading.dropdownItemH3,
            ToolbarItemHeading.dropdownItemH4,
            ToolbarItemHeading.dropdownItemH5,
            ToolbarItemHeading.dropdownItemH6,
          ],
    );
  }

  static ToolbarDropdownItem get dropdownItemH1 => ToolbarDropdownItem(
        text: 'H1',
        character: _defaultCharacter[0],
        placeholder: _defaultPlaceholder,
        fontWeight: FontWeight.w500,
        fontSizeDelta: 6,
      );

  static ToolbarDropdownItem get dropdownItemH2 => ToolbarDropdownItem(
        text: 'H2',
        character: _defaultCharacter[1],
        placeholder: _defaultPlaceholder,
        fontWeight: FontWeight.w500,
        fontSizeDelta: 5,
      );

  static ToolbarDropdownItem get dropdownItemH3 => ToolbarDropdownItem(
        text: 'H3',
        character: _defaultCharacter[2],
        placeholder: _defaultPlaceholder,
        fontWeight: FontWeight.w500,
        fontSizeDelta: 4,
      );

  static ToolbarDropdownItem get dropdownItemH4 => ToolbarDropdownItem(
        text: 'H4',
        character: _defaultCharacter[3],
        placeholder: _defaultPlaceholder,
        fontWeight: FontWeight.w500,
        fontSizeDelta: 3,
      );

  static ToolbarDropdownItem get dropdownItemH5 => ToolbarDropdownItem(
        text: 'H5',
        character: _defaultCharacter[4],
        placeholder: _defaultPlaceholder,
        fontWeight: FontWeight.w500,
        fontSizeDelta: 2,
      );

  static ToolbarDropdownItem get dropdownItemH6 => ToolbarDropdownItem(
        text: 'H6',
        character: _defaultCharacter[5],
        placeholder: _defaultPlaceholder,
        fontWeight: FontWeight.w500,
        fontSizeDelta: 1,
      );
}
