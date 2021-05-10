import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String label;
  final AsyncCallback onPressed;
  final double width;
  final double height;
  final Color color;

  AppButton({@required this.label, @required this.onPressed, this.width = 120, this.height = 40, this.color});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        width: widget.width,
        height: widget.height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 12),
            primary: widget.color ?? Colors.grey[800],
          ),
          onPressed: widget.onPressed,
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            ),
          ),
        ),
      ),
    );
  }
}
