import 'package:flutter/material.dart';
import 'package:flutter_app/ui_elements/app_input.dart';
import 'package:flutter_app/ui_elements/app_button_async.dart';
import 'package:flutter_app/models/key_store.dart';

class TestDataBase extends StatefulWidget {
  @override
  _TestDataBaseState createState() => _TestDataBaseState();
}

class _TestDataBaseState extends State<TestDataBase> {
  AppInputArgs privateKeyInput;
  AppInputArgs publicKeyInput;
  KeyStoreProvider provider;
  List<KeyStore> keys;
  @override
  void initState() {
    super.initState();
    privateKeyInput = AppInputArgs(
        controller: TextEditingController(),
        hintText: "Enter the private key",
        label: "Private Key");
    publicKeyInput = AppInputArgs(
        controller: TextEditingController(),
        hintText: "Enter the public key",
        label: "Public Key");
    keys = [];
    provider = KeyStoreProvider();
    //provider.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              ...keys.map(
                (e) => ListTile(
                  title: Text("Private Key: ${e.privateKey}"),
                  subtitle: Text("Public Key: ${e.publicKey}"),
                  leading: Text("ID: ${e.id}"),
                ),
              )
            ],
          )),
          AppInput(inputArgs: privateKeyInput),
          AppInput(inputArgs: publicKeyInput),
          Row(
            children: [
              AppButton(
                  label: "Add To Table",
                  onPressed: () async {
                    if (provider.db.isOpen) {
                      await provider.insert(KeyStore(
                          privateKey: privateKeyInput.controller.text,
                          publicKey: publicKeyInput.controller.text));
                    }
                  }),
              AppButton(label: "Get All", onPressed: () async {
                if(provider.db.isOpen){
                  var l = await provider.getAll();
                  setState(() {
                    keys = l;
                  });
                }
              })
            ],
          )
        ],
      ),
    );
  }
}
