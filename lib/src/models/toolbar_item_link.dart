import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 4;
const IconData _defaultIcon = Icons.link;
const String _defaultTooltip = 'Link';
const ToolbarFormatOption _defaultFormatOption = ToolbarFormatOption.template;
const bool _defaultNewLine = false;
const String _defaultText = 'Example link';
const String _defaultUrl = 'https://example.com';

class ToolbarItemLink extends ToolbarItemButton
    implements ToolbarItemFormatTemplate {
  const ToolbarItemLink({
    required super.order,
    required super.enabled,
    required super.icon,
    required super.formatOption,
    required this.preFormatTemplate,
    required this.template,
    super.newLine,
    super.tooltip,
  });

  factory ToolbarItemLink.withDefaultValues({
    int? order,
    bool? enabled,
    IconData? icon,
    String? tooltip,
    ToolbarFormatOption? formatOption,
    bool? newLine,
    Future<ItemLink?> Function(String text, int? index)? preFormatTemplate,
    String Function(dynamic item)? template,
  }) {
    return ToolbarItemLink(
      order: order ?? _defaultOrder,
      enabled: enabled ?? true,
      icon: icon ?? _defaultIcon,
      tooltip: tooltip ?? _defaultTooltip,
      formatOption: formatOption ?? _defaultFormatOption,
      newLine: newLine ?? _defaultNewLine,
      preFormatTemplate: preFormatTemplate ??
          (text, _) async => ItemLink(
                text: text.isEmpty ? _defaultText : text,
                href: _defaultUrl,
              ),
      template: template ??
          (item) =>
              '[${(item as ItemLink).text}](${item.href}${item.title != null ? ' "${item.title}"' : ''})',
    );
  }

  @override
  final Future<ItemLink?> Function(String text, int? index) preFormatTemplate;

  @override
  final String Function(dynamic item) template;
}
