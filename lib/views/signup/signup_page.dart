import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/encryption/rsa_pem.dart';
import 'package:flutter_app/models/key_store.dart';
import 'package:flutter_app/ui_elements/app_button_async.dart';
import 'package:flutter_app/ui_elements/app_input.dart';
import 'package:flutter_app/encryption/aes_key_generator.dart';
import 'package:flutter_app/encryption/save_key.dart';
import 'package:flutter_app/views/signup/signup_items.dart';
import 'package:pointycastle/api.dart' as dart_api;
import 'package:pointycastle/asymmetric/api.dart';

class SignUpView extends StatefulWidget {
  final VoidCallback closeThis;
  SignUpView({this.closeThis});
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<String> key;
  RsaKeyHelper helper;

  Map<String, AppInputArgs> update = <String, AppInputArgs>{
    "team_name": AppInputArgs(
      controller: TextEditingController(),
      hintText: "Name of the team",
      type: TextInputType.text,
      focusNode: FocusNode(),
      label: "Team Name",
      icon: Icons.short_text,
    ),
    "head_count": AppInputArgs(
      controller: TextEditingController(),
      hintText: "Size of the Team",
      type: TextInputType.number,
      focusNode: FocusNode(),
      label: "Head Count",
      icon: Icons.short_text,
    )
  };

  @override
  void initState() {
    super.initState();
    key = <String>["NO-KEY"];
    helper = RsaKeyHelper();
  }

  Future<void> signUpClicked() async {
    Uint8List l = generateKey();
    List<String> words = await keyToWords(l);
    setState(() {
      key = words;
    });
  }

  Future<void> registerUserKey() async {
    //TODO: Why is this stupid function running;
    dart_api.AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> keyPair = await generateRSAKeyPairAsync();
    TeamData d = TeamData(privateKey: await helper.encryptPrivateKey(keyPair.privateKey, key), publicKey: helper.encodePublicKeyToPem(keyPair.publicKey));
    d.teamName = update["team_name"].controller.text.isEmpty ? "NULL" : update["team_name"].controller.text;
    d.teamCount = update["head_count"].controller.text.isEmpty ? 0 : int.parse(update["head_count"].controller.text);
    TeamDataProvider.insert(d);
  }

  Future<void> continueClicked() async {
    Map<String, Future<void>> loadFunctions = {};
    loadFunctions.putIfAbsent("Generating RSA Private and Public keys...", registerUserKey);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      TeamData main = await TeamDataProvider.getMain();
      if (main.id != -1) {
        showDialog(context: context, builder: (_) => deletePreviousUserDialog());
      }
    });
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
            height: 30,
          ),
          buildKeyDisplay(),
          buildAddDetails(),
          SizedBox(
            height: 10,
          ),
          buildActionButtons(),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: widget.closeThis,
            child: Text("Enter existing key."),
          ),
        ],
      ),
    );
  }

  Row buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButtonAsync(label: "Generate Key", onPressed: signUpClicked),
        SizedBox(
          width: 10,
        ),
        AppButtonAsync(
          label: "Continue",
          onPressed: key.length < 2 ? null : continueClicked,
        ),
      ],
    );
  }

  Wrap buildKeyDisplay() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        ...getWords(key),
      ],
    );
  }

  Container buildTitle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(18),
        // boxShadow: <BoxShadow>[BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(1,1))],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Generate Key",
            style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 3, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Iterable<Widget> getWords(Iterable<dynamic> items) {
    return items.map(
      (value) => SingleWord(
        text: value,
      ),
    );
  }

  ExpansionTile buildAddDetails() {
    return ExpansionTile(
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Text(
          "Add Details",
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

  CupertinoAlertDialog deletePreviousUserDialog() {
    return CupertinoAlertDialog(
      title: Text("A user already exists on this device,\nDo you want to overrite this user?"),
      actions: [
        CupertinoDialogAction(
          child: Text("Yes"),
          onPressed: () {
            TeamDataProvider.deleteMain();
          },
          isDestructiveAction: true,
        ),
        CupertinoDialogAction(
          child: Text("No"),
          onPressed: widget.closeThis,
          isDestructiveAction: true,
        ),
      ],
    );
  }
}
