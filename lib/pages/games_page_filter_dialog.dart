import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/games_view/games_view.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_dropdown.dart';
import 'package:gamorrah/widgets/game/game_platforms_choice.dart';
import 'package:gamorrah/widgets/game/game_tags_choice.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GamesPageFilterDialog extends StatefulWidget {
  const GamesPageFilterDialog({
    this.filter,
    this.tags = const {},
    this.onChanged,
  });

  final GamesFilter? filter;
  final Set<String> tags;
  final void Function(GamesFilter)? onChanged;

  @override
  State<GamesPageFilterDialog> createState() => _GamesPageFilterDialogState();
}

class _GamesPageFilterDialogState extends State<GamesPageFilterDialog> {
  late GamesFilterBeatenPredicate? _beaten;
  late GamesFilterPlatformsPredicate? _platforms;
  late GamesFilterHowLongToBeatPredicate? _howLongToBeat;
  late GamesFilterTagsPredicate? _tags;
  
  @override
  void initState() {
    super.initState();

    _beaten = widget.filter?.beaten;
    _platforms = widget.filter?.platforms;
    _howLongToBeat = widget.filter?.howLongToBeat;
    _tags = widget.filter?.tags;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.ui.gamesPage.filterDialogTitle),
      content: _contentBuilder(context),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.ui.general.cancelButton),
        ),
        TextButton(
          onPressed: () {
            final onChanged = widget.onChanged;

            if (onChanged != null) {
              final newFilter = widget.filter != null
                ? widget.filter!.copyWith(
                    beaten: Optional(_beaten),
                    platforms: Optional(_platforms),
                    howLongToBeat: Optional(_howLongToBeat),
                    tags: Optional(_tags),
                  )
                : GamesFilter(
                  beaten: _beaten, 
                  platforms: _platforms,
                  howLongToBeat: _howLongToBeat,
                  tags: _tags,
                );

              onChanged(newFilter);
            }

            Navigator.pop(context);
          },
          child: Text(t.ui.general.okButton),
        ),
      ],
    );
  }

  Widget _contentBuilder(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 520,
        child: Column(
          children: [
            _contentFilterPlatformsBuilder(context),
            VSpacer(),
            _contentFilterBeatenBuilder(context),
            VSpacer(),
            _contentFilterHowLongToBeatBuilder(context),
            VSpacer(),
            _contentFilterTagsBuilder(context),
         ],
        ),
      )
    );
  }

  Widget _contentFilterPlatformsBuilder(BuildContext context) {
    final operatorDropDownMenu = DropdownMenu<GamesFilterPlatformsOperator?>(
      label: Text(t.ui.gamesPage.filterPlatformsOperatorLabel),
      expandedInsets: EdgeInsets.zero,
      initialSelection: _platforms?.operator,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null,
          label: t.ui.general.offText,
        ),
        ...GamesFilterPlatformsOperator.values.map((operator) => DropdownMenuEntry(
          value: operator,
          label: t.types.gamesFilterPlatformsOperator.values[operator.name]!
        ))
      ], 
      onSelected: (value) {
        setState(() {
          if (value == null) {
            _platforms = null;
          } else {
            _platforms = GamesFilterPlatformsPredicate(operator: value);
          }
        });
      }
    );

    if (_platforms == null) {
      return Row(
        children: [Expanded(child: operatorDropDownMenu)]
      );
    }

    return Row(children: [
      Expanded(flex: 1, child: operatorDropDownMenu),
      HSpacer(),
      Expanded(flex: 2, child: GamePlatformsChoice(
        value: _platforms!.value,
        compact: true,
        onChanged: (value) {
          setState(() {
            _platforms = _platforms!.copyWith(value: Optional(value));
          });
        },
      )),
    ]);
  }

  Widget _contentFilterBeatenBuilder(BuildContext context) {
    final operatorDropDownMenu = DropdownMenu<GamesFilterBeatenOperator?>(
      label: Text(t.ui.gamesPage.filterBeatenOperatorLabel),
      expandedInsets: EdgeInsets.zero,
      initialSelection: _beaten?.operator,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null,
          label: t.ui.general.offText,
        ),
        ...GamesFilterBeatenOperator.values.map((operator) => DropdownMenuEntry(
          value: operator,
          label: t.types.gamesFilterBeatenOperator.values[operator.name]!,
        ))
      ], 
      onSelected: (value) {
        setState(() {
          if (value == null) {
            _beaten = null;
          } else {
            _beaten = GamesFilterBeatenPredicate(operator: value);
          }
        });
      }
    );

    if (_beaten == null) {
      return Row(
        children: [Expanded(child: operatorDropDownMenu)]
      );
    }

    return Row(children: [
      Expanded(flex: 1, child: operatorDropDownMenu),
      HSpacer(),
      Expanded(flex: 2, child: GamePersonalBeatenDropdown(
        value: _beaten?.value,
        onChanged: (value) {
          setState(() { 
            _beaten = _beaten!.copyWith(value: Optional(value));
          });
        },
      )),
    ]);
  }

  Widget _contentFilterHowLongToBeatBuilder(BuildContext context) {
    final operatorDropDownMenu = DropdownMenu<GamesFilterHowLongToBeatOperator?>(
      label: Text(t.ui.gamesPage.filterHowLongToBeatOperatorLabel),
      expandedInsets: EdgeInsets.zero,
      initialSelection: _howLongToBeat?.operator,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null,
          label: t.ui.general.offText,
        ),
        ...GamesFilterHowLongToBeatOperator.values.map((operator) => DropdownMenuEntry(
          value: operator,
          label: t.types.gamesFilterHowLongToBeatOperator.values[operator.name]!,
        ))
      ], 
      onSelected: (value) {
        setState(() {
          if (value == null) {
            _howLongToBeat = null;
          } else {
            _howLongToBeat = GamesFilterHowLongToBeatPredicate(operator: value);
          }
        });
      }
    );

    if (_howLongToBeat == null) {
      return Row(
        children: [Expanded(child: operatorDropDownMenu)]
      );
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(flex: 1, child: operatorDropDownMenu),
      HSpacer(),
      Expanded(flex: 2, child: Row(
        children: [
          Expanded(flex: 1, child: DropdownMenu<GamesFilterHowLongToBeatField>(
            label: Text(t.ui.gamesPage.filterHowLongToBeatFieldLabel),
            expandedInsets: EdgeInsets.zero,
            initialSelection: _howLongToBeat!.field,
            dropdownMenuEntries: GamesFilterHowLongToBeatField.values.map((field) => DropdownMenuEntry(
              value: field,
              label: t.types.gamesFilterHowLongToBeatField.values[field.name]!,
            )).toList(), 
            onSelected: (value) {
              setState(() {
                _howLongToBeat = _howLongToBeat!.copyWith(field: Optional(value!));
              });
            }
          )),
          HSpacer(),
          Expanded(flex: 1, child: TextFormField(
            initialValue: _howLongToBeat?.value.toString(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
              setState(() {
                _howLongToBeat = _howLongToBeat!.copyWith(value: Optional(double.parse(value)));
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: t.ui.general.hoursText,
            ),
          )),
        ],
      )),      
    ]);
  }

  Widget _contentFilterTagsBuilder(BuildContext context) {
    final operatorDropDownMenu = DropdownMenu<GamesFilterTagsOperator?>(
      label: Text(t.ui.gamesPage.filterTagsOperatorLabel),
      expandedInsets: EdgeInsets.zero,
      initialSelection: _tags?.operator,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null,
          label: t.ui.general.offText,
        ),
        ...GamesFilterTagsOperator.values.map((operator) => DropdownMenuEntry(
          value: operator,
          label: t.types.gamesFilterTagsOperator.values[operator.name]!
        ))
      ], 
      onSelected: (value) {
        setState(() {
          if (value == null) {
            _tags = null;
          } else {
            _tags = GamesFilterTagsPredicate(operator: value);
          }
        });
      }
    );

    if (_tags == null) {
      return Row(
        children: [Expanded(child: operatorDropDownMenu)]
      );
    }

    return Row(children: [
      Expanded(flex: 1, child: operatorDropDownMenu),
      HSpacer(),
      Expanded(flex: 2, child: GameTagsChoice(
        value: _tags!.value,
        tags: widget.tags,
        compact: true,
        onChanged: (value) {
          setState(() {
            _tags = _tags!.copyWith(value: Optional(value));
          });
        },
      )),
    ]);
  }
}