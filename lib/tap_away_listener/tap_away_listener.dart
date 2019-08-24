import 'package:flutter/widgets.dart';
import 'package:flutter_zero/global_gesture/global_gesture.dart';

Rect fromPointAndSize(Offset point, Size size) {
  return Rect.fromLTWH(point.dx, point.dy, size.width, size.height);
}

class TapAwayListener extends StatefulWidget {
  final Widget child;
  final VoidCallback onTapUp;
  final VoidCallback onPointerDown;

  TapAwayListener({@required this.child, this.onTapUp, this.onPointerDown});

  State<StatefulWidget> createState() => TapAwayListenerState();
}

class TapAwayListenerState extends State<TapAwayListener> {
  GlobalGestureInherited _globalGestureInherited;

  void handlePointerDown() {
    final state = GlobalGesture.of(context);
    handle(state.pointerDown.value.position, widget.onPointerDown);
  }

  void handleTapUp() {
    final state = GlobalGesture.of(context);
    handle(state.pointerDown.value.position, widget.onTapUp);
  }

  void handle(Offset offset, VoidCallback callback) {
    if (callback == null) {
      return;
    }
    //    final ancestor = state.context.findRenderObject();
    final ancestor = null;
    final box = context?.findRenderObject();
    if (box is RenderBox) {
      final pos = box.localToGlobal(Offset.zero, ancestor: ancestor);
      final rect = fromPointAndSize(pos, box.size);
      if (!rect.contains(offset)) {
        callback();
      }
    }
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    _globalGestureInherited =
        context.inheritFromWidgetOfExactType(GlobalGestureInherited);
  }

  void initState() {
    super.initState();
    final globalState = GlobalGesture.of(context);
    globalState.pointerDown.addListener(handlePointerDown);
    globalState.tapUp.addListener(handleTapUp);
  }

  void dispose() {
    super.dispose();
    _globalGestureInherited.state.pointerDown.removeListener(handlePointerDown);
    _globalGestureInherited.state.tapUp.removeListener(handleTapUp);
  }

  Widget build(BuildContext context) {
    return widget.child;
  }
}
