import 'package:flutter/material.dart';
import 'package:flutter_app/ui_elements/app_input.dart';
import '../../ui_elements/app_button_async.dart';

class LoginView extends StatefulWidget {
  final VoidCallback closeThis;
  LoginView({this.closeThis});
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  Map<String, AppInputArgs> update = <String, AppInputArgs>{
    "team_name": AppInputArgs(
      controller: TextEditingController(),
      hintText: "Name of the team",
      focusNode: FocusNode(),
      label: "Team Name",
      icon: Icons.short_text,
    ),
    "head_count": AppInputArgs(
      controller: TextEditingController(),
      hintText: "Size of the Team",
      focusNode: FocusNode(),
      label: "Head Count",
      icon: Icons.short_text,
    )
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Container()),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: buildColumn(),
        ),
      ],
    );
  }

  Widget buildColumn() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(
            height: 20,
          ),
          AppInput(
            inputArgs: AppInputArgs(
              controller: controller,
              focusNode: focusNode,
              label: "Enter RSA Key",
              hintText: "Enter Key",
              icon: Icons.vpn_key,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          buildUpdateView(),
          SizedBox(
            height: 20,
          ),
          AppButton(label: "Submit", onPressed: () async {}),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: widget.closeThis,
            child: Text("Generate new key."),
          )
        ],
      ),
    );
  }

  Container buildTitle() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(18),
          // boxShadow: <BoxShadow>[
          //   BoxShadow(color: Colors.black, blurRadius: 10)
          // ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Enter Key",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ),
      );
  }

  ExpansionTile buildUpdateView() {
    return ExpansionTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Text(
          "Update Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      children: [
        AppInput(
          inputArgs: update["team_name"],
        ),
        SizedBox(
          height: 30,
        ),
        AppInput(
          inputArgs: update["head_count"],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

}
