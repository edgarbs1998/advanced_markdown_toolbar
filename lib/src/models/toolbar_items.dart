import 'package:advanced_markdown_toolbar/src/models/models.dart';

class ToolbarItems {
  ToolbarItems({
    ToolbarItemHeading? heading,
    ToolbarItemBold? bold,
    ToolbarItemItalic? italic,
    ToolbarItemStrikethrough? strikethrough,
    ToolbarItemLink? link,
    ToolbarItemImage? image,
    ToolbarItemCode? code,
    ToolbarItemUnorderedList? unorderedList,
    ToolbarItemOrderedList? orderedList,
    ToolbarItemCheckbox? checkbox,
    ToolbarItemQuote? quote,
    ToolbarItemHorizontalRule? horizontalRule,
    this.customItems = const [],
  })  : heading = heading ?? ToolbarItemHeading.withDefaultValues(),
        bold = bold ?? ToolbarItemBold(),
        italic = italic ?? ToolbarItemItalic(),
        strikethrough = strikethrough ?? ToolbarItemStrikethrough(),
        link = link ?? ToolbarItemLink.withDefaultValues(),
        image = image ?? ToolbarItemImage.withDefaultValues(),
        code = code ?? ToolbarItemCode(),
        unorderedList = unorderedList ?? ToolbarItemUnorderedList(),
        orderedList = orderedList ?? ToolbarItemOrderedList.withDefaultValues(),
        checkbox = checkbox ?? ToolbarItemCheckbox.withDefaultValues(),
        quote = quote ?? ToolbarItemQuote(),
        horizontalRule = horizontalRule ?? ToolbarItemHorizontalRule();

  final ToolbarItemHeading heading;
  final ToolbarItemBold bold;
  final ToolbarItemItalic italic;
  final ToolbarItemStrikethrough strikethrough;
  final ToolbarItemLink link;
  final ToolbarItemImage image;
  final ToolbarItemCode code;
  final ToolbarItemUnorderedList unorderedList;
  final ToolbarItemOrderedList orderedList;
  final ToolbarItemCheckbox checkbox;
  final ToolbarItemQuote quote;
  final ToolbarItemHorizontalRule horizontalRule;
  final List<ToolbarItem> customItems;
}
