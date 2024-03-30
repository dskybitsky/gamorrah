import 'package:flutter/material.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/game/game.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
    final items = GamePlatform.values
        .map((platform) => MultiSelectItem(platform, platform.title))
        .toList();

    return MultiSelectDialogField<GamePlatform>(
      title: Text(t.ui.gamePlatformsControl.dialogTitle),
      buttonText: Text(t.ui.gamePlatformsControl.placeholder),
      items: items,
      initialValue: value.toList(),
      searchable: true,
      listType: MultiSelectListType.LIST,
      onConfirm: (items) {
        if (onChanged != null) {
          onChanged!(items.toSet());
        }
      },
      chipDisplay: MultiSelectChipDisplay(
        items: items,
        scroll: true,
        onTap: (item) {
          if (onChanged != null) {
            final newValue = value.toSet();
            
            newValue.remove(item);

            onChanged!(newValue);
          }
        },
      ),
    );
  }
}