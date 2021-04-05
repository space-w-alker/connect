import 'package:flutter/material.dart';

class NotFoundScreen extends StatefulWidget {
  @override
  _NotFoundScreenState createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Text("404 Error. \nPage not Found", style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
