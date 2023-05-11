import 'package:advanced_markdown_toolbar/src/enums/enums.dart';
import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:flutter/material.dart';

const int _defaultOrder = 5;
const IconData _defaultIcon = Icons.image;
const String _defaultTooltip = 'Image';
const ToolbarFormatOption _defaultFormatOption = ToolbarFormatOption.template;
const bool _defaultNewLine = true;
const String _defaultText = 'Example image';
const String _defaultUri = 'https://picsum.photos/200';

class ToolbarItemImage extends ToolbarItemButton
    implements ToolbarItemFormatTemplate {
  const ToolbarItemImage({
    required super.order,
    required super.enabled,
    required super.icon,
    required super.formatOption,
    required this.preFormatTemplate,
    required this.template,
    super.newLine,
    super.tooltip,
  });

  factory ToolbarItemImage.withDefaultValues({
    int? order,
    bool? enabled,
    IconData? icon,
    String? tooltip,
    ToolbarFormatOption? formatOption,
    bool? newLine,
    Future<ItemImage?> Function(String text, int? index)? preFormatTemplate,
    String Function(dynamic item)? template,
  }) {
    return ToolbarItemImage(
      order: order ?? _defaultOrder,
      enabled: enabled ?? true,
      icon: icon ?? _defaultIcon,
      tooltip: tooltip ?? _defaultTooltip,
      formatOption: formatOption ?? _defaultFormatOption,
      newLine: newLine ?? _defaultNewLine,
      preFormatTemplate: preFormatTemplate ??
          (text, _) async => ItemImage(
                alt: text.isEmpty ? _defaultText : text,
                uri: _defaultUri,
              ),
      template: template ??
          (item) =>
              '![${(item as ItemImage).alt}](${item.uri}${item.title != null ? ' "${item.title}"' : ''})',
    );
  }

  @override
  final Future<ItemImage?> Function(String text, int? index) preFormatTemplate;

  @override
  final String Function(dynamic item) template;
}
