import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamorrah/i18n/strings.g.dart';
import 'package:gamorrah/models/games_view/games_view.dart';
import 'package:gamorrah/models/optional.dart';
import 'package:gamorrah/widgets/game/game_personal_beaten_input.dart';
import 'package:gamorrah/widgets/game/game_platforms_input.dart';
import 'package:gamorrah/widgets/ui/spacer.dart';

class GamesPageFilterDialog extends StatefulWidget {
  const GamesPageFilterDialog({
    this.filter,
    this.onChanged,
  });

  final GamesFilter? filter;
  final void Function(GamesFilter)? onChanged;

  @override
  State<GamesPageFilterDialog> createState() => _GamesPageFilterDialogState();
}

class _GamesPageFilterDialogState extends State<GamesPageFilterDialog> {
  late GamesFilterBeatenPredicate? _beaten;
  late GamesFilterPlatformsPredicate? _platforms;
  late GamesFilterHowLongToBeatPredicate? _howLongToBeat;
  
  @override
  void initState() {
    super.initState();

    _beaten = widget.filter?.beaten;
    _platforms = widget.filter?.platforms;
    _howLongToBeat = widget.filter?.howLongToBeat;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.ui.gamesPage.filterDialogTitle),
      content: _buildContent(context),
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
                    platforms: Optional(_platforms)
                  )
                : GamesFilter(
                  beaten: _beaten, 
                  platforms: _platforms
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

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 400,
        child: Column(
          children: [
            _buildContentFilterPlatforms(context),
            VSpacer(),
            _buildContentFilterBeaten(context),
            VSpacer(),
            _buildContentFilterHowLongToBeat(context),
            VSpacer(),
         ],
        ),
      )
    );
  }

  Widget _buildContentFilterPlatforms(BuildContext context) {
    final operatorDropDownMenu = DropdownMenu<GamesFilterPlatformsOperator?>(
      label: Text("Platforms Filter"),
      expandedInsets: EdgeInsets.zero,
      initialSelection: _platforms?.operator,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null,
          label: "Off",
        ),
        ...GamesFilterPlatformsOperator.values.map((operator) => DropdownMenuEntry(
          value: operator,
          label: operator.name
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
      Expanded(flex: 2, child: GamePlatformsInput(
        value: _platforms!.value,
        onChanged: (value) {
          setState(() {
            _platforms = _platforms!.copyWith(value: Optional(value));
          });
        },
      )),
    ]);
  }

  Widget _buildContentFilterBeaten(BuildContext context) {
    final operatorDropDownMenu = DropdownMenu<GamesFilterBeatenOperator?>(
      label: Text("Beaten Filter"),
      expandedInsets: EdgeInsets.zero,
      initialSelection: _beaten?.operator,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null,
          label: "Off",
        ),
        ...GamesFilterBeatenOperator.values.map((operator) => DropdownMenuEntry(
          value: operator,
          label: operator.name
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
      Expanded(flex: 2, child: GamePersonalBeatenInput(
        value: _beaten?.value,
        onChanged: (value) {
          setState(() { 
            _beaten = _beaten!.copyWith(value: Optional(value));
          });
        },
      )),
    ]);
  }

  Widget _buildContentFilterHowLongToBeat(BuildContext context) {
    final operatorDropDownMenu = DropdownMenu<GamesFilterHowLongToBeatOperator?>(
      label: Text("HowLongToBeat Filter"),
      expandedInsets: EdgeInsets.zero,
      initialSelection: _howLongToBeat?.operator,
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: null,
          label: "Off",
        ),
        ...GamesFilterHowLongToBeatOperator.values.map((operator) => DropdownMenuEntry(
          value: operator,
          label: operator.name
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

    return Row(children: [
      Expanded(flex: 1, child: operatorDropDownMenu),
      HSpacer(),
      Expanded(flex: 1, child: DropdownMenu<GamesFilterHowLongToBeatField>(
        label: Text("Field"),
        expandedInsets: EdgeInsets.zero,
        initialSelection: _howLongToBeat!.field,
        dropdownMenuEntries: GamesFilterHowLongToBeatField.values.map((field) => DropdownMenuEntry(
          value: field,
          label: field.name
        )).toList(), 
        onSelected: (value) {
          setState(() {
            _howLongToBeat = _howLongToBeat!.copyWith(field: Optional(value!));
          });
        }
      )),
      HSpacer(),
      Expanded(flex: 2, child: TextField(
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
          labelText: t.types.gameHowLongToBeat.storySides,
        ),
      )),
    ]);
  }
}