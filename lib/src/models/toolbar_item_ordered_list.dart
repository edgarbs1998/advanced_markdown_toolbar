import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 7;
const IconData _defaultIcon = Icons.format_list_numbered;
const String _defaultTooltip = 'Ordered list';
const ToolbarFormatOption _defaultFormatOption =
    ToolbarFormatOption.templateList;
const bool _defaultNewLine = true;
const String _defaultText = 'Ordered list item';

class ToolbarItemOrderedList extends ToolbarItemButton
    implements ToolbarItemFormatTemplate {
  const ToolbarItemOrderedList({
    required super.order,
    required super.enabled,
    required super.icon,
    required super.formatOption,
    required this.preFormatTemplate,
    required this.template,
    super.newLine,
    super.tooltip,
  });

  factory ToolbarItemOrderedList.withDefaultValues({
    int? order,
    bool? enabled,
    IconData? icon,
    String? tooltip,
    ToolbarFormatOption? formatOption,
    bool? newLine,
    Future<ItemOrderedList?> Function(String text, int? index)?
        preFormatTemplate,
    String Function(dynamic item)? template,
  }) {
    return ToolbarItemOrderedList(
      order: order ?? _defaultOrder,
      enabled: enabled ?? true,
      icon: icon ?? _defaultIcon,
      tooltip: tooltip ?? _defaultTooltip,
      formatOption: formatOption ?? _defaultFormatOption,
      newLine: newLine ?? _defaultNewLine,
      preFormatTemplate: preFormatTemplate ??
          (text, index) async => ItemOrderedList(
                number: (index ?? 0) + 1,
                text: text.isEmpty ? _defaultText : text,
              ),
      template: template ??
          (item) => '${(item as ItemOrderedList).number}. ${item.text}',
    );
  }

  @override
  final Future<ItemOrderedList?> Function(String text, int? index)
      preFormatTemplate;

  @override
  final String Function(dynamic item) template;
}
