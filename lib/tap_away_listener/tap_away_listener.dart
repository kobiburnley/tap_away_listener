import 'package:flutter/widgets.dart';
import 'package:flutter_zero/global_gesture/global_gesture.dart';

Rect fromPointAndSize(Offset point, Size size) {
  return Rect.fromLTWH(point.dx, point.dy, size.width, size.height);
}

class TapAwayListener extends StatefulWidget {
  final Widget child;
  final VoidCallback listener;

  TapAwayListener(this.child, {@required this.listener});

  State<StatefulWidget> createState() => TapAwayListenerState();
}

class TapAwayListenerState extends State<TapAwayListener> {
  void handleTap() {
    final state = GlobalGesture.of(context);
    final tapUp = state.tapUp;
//    final ancestor = state.context.findRenderObject();
    final box = context?.findRenderObject();
    if (box is RenderBox) {
      final pos = box.localToGlobal(Offset.zero, ancestor: null);
      final rect = fromPointAndSize(pos, box.size);
      if (!rect.contains(tapUp.value.globalPosition)) {
        widget.listener();
      }
    }
  }

  void initState() {
    super.initState();
    GlobalGesture.of(context).tapUp.addListener(handleTap);
  }

  void dispose() {
    super.dispose();
    GlobalGesture.of(context).tapUp.removeListener(handleTap);
  }

  Widget build(BuildContext context) {
    return widget.child;
  }
}
