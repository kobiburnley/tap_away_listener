import 'package:flutter/widgets.dart';

class GlobalGesture extends StatefulWidget {
  final Widget child;

  GlobalGesture(this.child);

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

  State<StatefulWidget> createState() => GlobalGestureState();
}

class GlobalGestureState extends State<GlobalGesture> {
  ValueNotifier<TapUpDetails> tapUp = ValueNotifier(TapUpDetails());

  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        tapUp.value = details;
      },
      child: widget.child,
    );
  }
}
