import 'package:advanced_markdown_toolbar/src/models/models.dart';
import 'package:advanced_markdown_toolbar/src/utils/utils.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  Toolbar({
    required this.controller,
    required this.focusNode,
    super.key,
    ToolbarItems? items,
    this.showTooltips = true,
    this.iconColor,
    this.surfaceColor,
    this.menuItemColor,
    this.iconPadding = const EdgeInsets.all(8),
    this.iconSize,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.itemBuilder,
  }) : items = items ?? ToolbarItems();

  final TextEditingController controller;
  final FocusNode focusNode;
  final ToolbarItems items;
  final bool showTooltips;
  final Color? iconColor;
  final Color? menuItemColor;
  final Color? surfaceColor;
  final EdgeInsets iconPadding;
  final double? iconSize;
  final double spacing;
  final double runSpacing;
  final WrapAlignment alignment;
  final Widget Function({
    IconData icon,
    bool dropdown,
    String? tooltip,
    List<ToolbarDropdownItem>? dropdownItems,
    VoidCallback? onPressed,
    ValueChanged<ToolbarDropdownItem>? onMenuItemSelected,
  })? itemBuilder;

  Widget _buildToolbarItem({
    required IconData icon,
    bool dropdown = false,
    String? tooltip,
    List<ToolbarDropdownItem> dropdownItems = const [],
    VoidCallback? onPressed,
    ValueChanged<ToolbarDropdownItem>? onMenuItemSelected,
  }) {
    return dropdown
        ? PopupMenuButton(
            tooltip: tooltip,
            iconSize: iconSize,
            padding: iconPadding,
            color: surfaceColor,
            icon: Icon(
              icon,
              color: iconColor,
            ),
            itemBuilder: (context) => dropdownItems
                .map(
                  (item) => PopupMenuItem<ToolbarDropdownItem>(
                    value: item,
                    child: item.text != null
                        ? Text(
                            item.text!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: menuItemColor,
                                  fontWeight: item.fontWeight,
                                )
                                .apply(
                                  fontSizeDelta: item.fontSizeDelta ?? 0,
                                ),
                          )
                        : item.icon != null
                            ? Icon(item.icon, color: menuItemColor)
                            : Text(item.character),
                  ),
                )
                .toList(),
            onSelected: onMenuItemSelected,
          )
        : IconButton(
            tooltip: tooltip,
            iconSize: iconSize,
            padding: iconPadding,
            color: surfaceColor,
            icon: Icon(
              icon,
              color: iconColor,
            ),
            onPressed: onPressed,
          );
  }

  List<Widget> _toolbarItems(BuildContext context, ToolbarItems items) {
    final toolbarItems = [
      if (items.heading.enabled) items.heading,
      if (items.bold.enabled) items.bold,
      if (items.italic.enabled) items.italic,
      if (items.strikethrough.enabled) items.strikethrough,
      if (items.link.enabled) items.link,
      if (items.image.enabled) items.image,
      if (items.code.enabled) items.code,
      if (items.unorderedList.enabled) items.unorderedList,
      if (items.orderedList.enabled) items.orderedList,
      if (items.checkbox.enabled) items.checkbox,
      if (items.quote.enabled) items.quote,
      if (items.horizontalRule.enabled) items.horizontalRule,
      ...items.customItems.where((item) => item.enabled),
    ]..sort((a, b) => a.order.compareTo(b.order));

    return toolbarItems.map((item) {
      if (item is ToolbarItemDropdown) {
        return (itemBuilder ?? _buildToolbarItem)(
          icon: item.icon,
          tooltip: item.tooltip,
          dropdown: true,
          dropdownItems: item.dropdownItems,
          onMenuItemSelected: (dropdownItem) =>
              onToolbarItemPressed(item: item, dropdownItem: dropdownItem),
        );
      } else {
        return (itemBuilder ?? _buildToolbarItem)(
          icon: item.icon,
          tooltip: item.tooltip,
          dropdown: false,
          onPressed: () => onToolbarItemPressed(item: item),
        );
      }
    }).toList();
  }

  void onToolbarItemPressed({
    required ToolbarItem item,
    ToolbarDropdownItem? dropdownItem,
  }) {
    focusNode.requestFocus();
    ToolbarFormat.toolbarItemPressed(
      controller: controller,
      selection: controller.selection,
      item: item,
      dropdownItem: dropdownItem,
    ).format();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: spacing,
      runSpacing: runSpacing,
      children: _toolbarItems(context, items),
    );
  }
}
