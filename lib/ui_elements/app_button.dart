import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'loading_view.dart';

class AppButton extends StatefulWidget {
  final String label;
  final AsyncCallback onPressed;
  final double width;
  final double height;

  AppButton({@required this.label, @required this.onPressed, this.width = 150, this.height = 50});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isLoading = false;

  Future<void> pressedCallback() async {
    setState(() {
      isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12),
          primary: Colors.grey[800],
        ),
        onPressed: isLoading ? null : pressedCallback,
        child: Center(
          child: isLoading ? LoadingView() : Text(widget.label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),),
        ),
      ),
    );
  }
}
