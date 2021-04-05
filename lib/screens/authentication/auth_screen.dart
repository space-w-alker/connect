import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui_elements/layouts/anim_in_out.dart';
import 'package:flutter_app/views/login/login_page.dart';
import 'package:flutter_app/views/signup/signup_page.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Visibility(
              visible: isLogin,
              child: AnimInOut(
                child: (close) {
                  return LoginView(
                    closeThis: close,
                  );
                },
                closeThis: () {
                  setState(
                    () {
                      isLogin = !isLogin;
                    },
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: !isLogin,
              child: AnimInOut(
                child: (close) => SignUpView(
                  closeThis: close,
                ),
                closeThis: () {
                  setState(
                    () {
                      isLogin = !isLogin;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
