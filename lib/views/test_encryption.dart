import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app/encryption/aes_encrypt_decrypt.dart';
import 'package:flutter_app/encryption/aes_key_generator.dart';
import 'package:flutter_app/ui_elements/app_button_async.dart';

class TestEncryption extends StatefulWidget {
  @override
  _TestEncryptionState createState() => _TestEncryptionState();
}

class _TestEncryptionState extends State<TestEncryption> {
  List<String> key;
  String plainText;
  String cipherText;
  String decryptedText;

  @override
  void initState() {
    super.initState();
    key = [];
    plainText = "This is the text to encrypt";
    cipherText = "";
    decryptedText = "";
  }

  Future<void> signUpClicked() async {
    Uint8List l = generateKey();
    List<String> words = await keyToWords(l);
    setState(() {
      key = words;
    });
  }

  Future<void> encrypt() async {
    Uint8List v = await symmetricEncrypt(key, plainText);
    setState(() {
      cipherText = String.fromCharCodes(v.toList());
    });
  }

  Future<void> decrypt() async {
    Uint8List v = await symmetricDecrypt(key, cipherText);
    setState(() {
      decryptedText = String.fromCharCodes(v.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: Text(plainText),
          ),
          ListTile(
            title: Text(cipherText),
          ),
          ListTile(
            title: Text(decryptedText),
          ),
          Center(
            child: AppButtonAsync(
              label: "Generate Key",
              onPressed: signUpClicked,
            ),
          ),
          Center(
            child: AppButtonAsync(
              label: "Encrypt Text",
              onPressed: encrypt,
            ),
          ),
          Center(
            child: AppButtonAsync(
              label: "Decrypt Text",
              onPressed: decrypt,
            ),
          )
        ],
      ),
    );
  }
}
