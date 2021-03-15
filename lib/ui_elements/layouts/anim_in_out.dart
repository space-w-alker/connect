import 'package:flutter/material.dart';
typedef Widget AnimInOutChild(VoidCallback closeView);
class AnimInOut extends StatefulWidget {
  final AnimInOutChild child;
  final VoidCallback closeThis;
  AnimInOut({@required this.child, this.closeThis});
  @override
  _AnimInOutState createState() => _AnimInOutState();
}

class _AnimInOutState extends State<AnimInOut> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    opacityAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOutCirc);
    offsetAnimation = Tween(begin: Offset(0,10), end: Offset(0,0)).animate(opacityAnimation);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: widget.child((){
          controller.reverse();
          controller.addStatusListener((status) {
            if(status == AnimationStatus.dismissed){
              widget.closeThis();
            }
          });
        }),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
