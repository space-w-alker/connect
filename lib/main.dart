import 'package:flutter/material.dart';
import 'package:flutter_app/pages/signup/signup_page.dart';
import 'package:flutter_app/ui_elements/loading_view.dart';
import './pages/authentication/authentication_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey
      ),
      home: Scaffold(
        body: Center(child: SignUpPage()),
      ),
    );
  }
}
