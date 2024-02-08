import 'package:fluent_ui/fluent_ui.dart';

class MainScreenContext extends InheritedWidget {
  const MainScreenContext({
    super.key,
    required this.appBarTitleNotifier,
    required this.appBarActionsNotifier,
    required super.child,
  });

  final ValueNotifier<String?> appBarTitleNotifier;
  final ValueNotifier<Widget?> appBarActionsNotifier;
  
  static MainScreenContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainScreenContext>();
  }

  static MainScreenContext of(BuildContext context) {
    final MainScreenContext? result = maybeOf(context);
    
    assert(result != null, 'No MainScreenContext found in context');
    
    return result!;
  }

  @override
  bool updateShouldNotify(MainScreenContext oldWidget) {
    return true;
  }
}