import 'package:fluent_ui/fluent_ui.dart';

enum VSpacerSize { s, m, l, xl }

class VSpacer extends StatelessWidget {
  VSpacer({
    this.size = VSpacerSize.m,
  });

  final VSpacerSize size;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: _getHeight());
  }

  double _getHeight() {
    switch (size) {
      case VSpacerSize.s: return 8;
      case VSpacerSize.m: return 16;
      case VSpacerSize.l: return 24;
      case VSpacerSize.xl: return 32;
    }
  }
}