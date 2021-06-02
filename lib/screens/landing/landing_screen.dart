import 'package:flutter/material.dart';
import 'package:flutter_app/constants/page_names.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SizedBox(
                height: 200,
              ),
            ),
            Text(
              "Do you Agree?",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Before you continue you must agree to the following conditions.\nClick the button below if you have read and agreed.",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            ),
            SizedBox(
              height: 80,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.double_arrow_outlined),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, AUTH_PAGE);
                  },
                  iconSize: 44,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
