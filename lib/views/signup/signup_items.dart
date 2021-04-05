import 'package:flutter/material.dart';

class SingleWord extends StatefulWidget {
  final String text;
  SingleWord({this.text}):super(key: ValueKey(text));
  @override
  _SingleWordState createState() => _SingleWordState();
}

class _SingleWordState extends State<SingleWord> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation scaleAnim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    scaleAnim = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    controller.forward(from: 0.2);
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnim,
      child: FadeTransition(
        opacity: scaleAnim,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Colors.grey[900], Colors.grey[600]],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widget.text.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
