import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';

class GamePlatformsInput extends StatelessWidget {
  const GamePlatformsInput({
    super.key,
    required this.value,
    this.onChanged,
    this.emptyState
  });

  final Set<GamePlatform> value;
  final void Function(Set<GamePlatform>)? onChanged;
  final Widget? emptyState;

  @override
  Widget build(BuildContext context) {
    const items = GamePlatform.values;

    return InputDecorator(
      decoration: InputDecoration(
        labelText: t.ui.gamePlatformsControl.title,
        border: OutlineInputBorder(),
      ),
      // child: SizedBox(width: double.maxFinite, height: double.maxFinite, child: InlineChoice<GamePlatform>(
      child: InlineChoice<GamePlatform>(
        multiple: true,
        clearable: true,
        value: value.toList(),
        onChanged: _onChanged,
        itemCount: items.length,
        // itemGroup: (index) {
        //   final brand = items[index].brand;

        //   return brand != null 
        //     ? t.types.gamePlatformBrand.values[brand.name]! 
        //     : t.types.gamePlatform.none;
        // },
        // groupBuilder: ChoiceGroup.createList(shrinkWrap: false),
        itemBuilder: (selection, i) => ChoiceChip(
          selected: selection.selected(items[i]),
          onSelected: selection.onSelected(items[i]),
          label: Text(t.types.gamePlatform.values[items[i].name]!),
        ),
        listBuilder: ChoiceList.createWrapped(
          spacing: 10,
          runSpacing: 10,
        ),
      ),
    // )
    );
  }

  void _onChanged(List<GamePlatform> value) {
    if (onChanged != null) {
      onChanged!(value.toSet());
    }
  }
}