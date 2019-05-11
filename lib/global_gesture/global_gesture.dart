import 'package:flutter/widgets.dart';

class GlobalGesture extends StatefulWidget {
  static GlobalGestureState of(
    BuildContext context, {
    bool root = false,
  }) {
    GlobalGestureState state = root
        ? context
            .rootAncestorStateOfType(const TypeMatcher<GlobalGestureState>())
        : context.ancestorStateOfType(const TypeMatcher<GlobalGestureState>());

    assert(state != null);

    return state;
  }

  final Widget child;

  GlobalGesture(this.child);

  State<StatefulWidget> createState() => GlobalGestureState();
}

class GlobalGestureState extends State<GlobalGesture> {
  ValueNotifier<TapUpDetails> tapUp = ValueNotifier(TapUpDetails());

  Widget build(BuildContext context) {
    return GlobalGestureInherited(
        state: this,
        child: GestureDetector(
          onTapUp: (details) {
            tapUp.value = details;
          },
          child: widget.child,
        ));
  }
}

class GlobalGestureInherited extends InheritedWidget {
  final GlobalGestureState state;

  const GlobalGestureInherited({
    Key key,
    @required this.state,
    @required Widget child,
  })  : assert(state != null),
        assert(child != null),
        super(key: key, child: child);

  bool updateShouldNotify(GlobalGestureInherited oldWidget) {
    return oldWidget.state != state;
  }
}
