import 'package:fluent_ui/fluent_ui.dart';

enum HSpacerSize { s, m, l, xl }

class HSpacer extends StatelessWidget {
  HSpacer({
    this.size = HSpacerSize.m,
  });

  final HSpacerSize size;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: _getWidth());
  }

  double _getWidth() {
    switch (size) {
      case HSpacerSize.s: return 8;
      case HSpacerSize.m: return 16;
      case HSpacerSize.l: return 24;
      case HSpacerSize.xl: return 32;
    }
  }
}