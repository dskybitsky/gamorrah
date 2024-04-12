import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:my_game_db/i18n/strings.g.dart';
import 'package:my_game_db/models/game/game.dart';

class GamePlatformsChoice extends StatelessWidget {
  const GamePlatformsChoice({
    super.key,
    required this.value,
    this.compact = false,
    this.onChanged,
  });

  final Set<GamePlatform> value;
  final bool compact;
  final void Function(Set<GamePlatform>)? onChanged;
  
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: t.ui.gamePlatformsControl.title,
        border: OutlineInputBorder(),
      ),
      child: compact
        ? _choiceBuilder()
        : SizedBox(width: double.maxFinite, height: 300, child: _choiceBuilder()),
    );
  }

  Widget _choiceBuilder() {
    const items = GamePlatform.values;

    return InlineChoice<GamePlatform>(
      multiple: true,
      clearable: true,
      value: value.toList(),
      onChanged: _onChanged,
      itemCount: items.length,
      itemGroup: compact ? null : (index) {
        final brand = items[index].brand;

        return brand != null 
          ? t.types.gamePlatformBrand.values[brand.name]! 
          : t.types.gamePlatform.none;
      },
      groupBuilder: compact ? null : ChoiceGroup.createList(padding: EdgeInsets.zero),
      groupHeaderBuilder: compact ? null : ChoiceGroup.createHeader(hideCounter: true),
      itemBuilder: (selection, i) => ChoiceChip(
        selected: selection.selected(items[i]),
        onSelected: selection.onSelected(items[i]),
        label: Text(t.types.gamePlatform.values[items[i].name]!),
      ),
      listBuilder: compact 
        ? ChoiceList.createScrollable(spacing: 10, runSpacing: 10) 
        : _createList()
    );
  }

  static ChoiceListBuilder _createList() {
    return (itemBuilder, itemCount) => SizedBox(width: double.infinity, child: Wrap(
      alignment: WrapAlignment.start ,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 10,
      runSpacing: 10,
      children: List<Widget>.generate(
        itemCount,
        (i) => itemBuilder(i),
      ),
    ));
  }

  void _onChanged(List<GamePlatform> value) {
    if (onChanged != null) {
      onChanged!(value.toSet());
    }
  }
}