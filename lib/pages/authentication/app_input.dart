import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final AppInputArgs inputArgs;

  AppInput({@required this.inputArgs});
  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration:Duration(milliseconds: 200), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.inputArgs.label,
            style: TextStyle(
                fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12, blurRadius: 6, offset: Offset(2, 2)),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: TextFormField(
              controller: widget.inputArgs.controller,
              autofocus: true,
              decoration: InputDecoration.collapsed(
                hintText: widget.inputArgs.hintText,
                hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[400],
                  letterSpacing: 2,
                ),
              ),
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}

class AppInputArgs {
  String label;
  TextEditingController controller;
  String hintText;
  FocusNode focusNode;

  AppInputArgs({this.controller, this.hintText, this.focusNode, this.label});
}
