import 'package:flutter/material.dart';

class AppInput extends StatefulWidget {
  final AppInputArgs inputArgs;

  AppInput({@required this.inputArgs});
  @override
  _AppInputState createState() => _AppInputState();
}

class _AppInputState extends State<AppInput>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Animation offset;
  FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutSine);
    offset = Tween(begin: Offset(0, 5), end: Offset(0, 0)).animate(animation);
    controller.forward();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        focusNode.requestFocus();
      },
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
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
                // height: 40,
                // width: 400,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 2)),
                  ],
                ),
                child: buildRow(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Container(
                color: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Center(child: Icon(widget.inputArgs.icon, color: Colors.white)),
                ),
              ),
            ],
          ),
          SizedBox(width: 4,),
          Expanded(
            child: TextFormField(
              controller: widget.inputArgs.controller,
              decoration: InputDecoration.collapsed(
                hintText: widget.inputArgs.hintText,
                hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[400],
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
              style: TextStyle(fontSize: 18),
              focusNode: focusNode,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

typedef String IsError(String text);

class AppInputArgs {
  String label;
  TextEditingController controller;
  String hintText;
  FocusNode focusNode;
  IconData icon;
  List<IsError> errors;

  AppInputArgs(
      {this.controller,
      this.hintText,
      this.focusNode,
      this.label,
      this.icon,
      this.errors = const <IsError>[]});
}
