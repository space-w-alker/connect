import 'package:flutter/material.dart';

class AnimInOut extends StatefulWidget {
  final Widget child;
  final VoidCallback finishClose;
  AnimInOut({@required this.child, @required this.finishClose});
  @override
  _AnimInOutState createState() => _AnimInOutState();
}

class _AnimInOutState extends State<AnimInOut>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: widget.child,
      ),
    );
  }
}
