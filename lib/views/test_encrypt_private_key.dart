import 'package:flutter/material.dart';
import 'package:flutter_app/encryption/aes_key_generator.dart';
import 'package:flutter_app/encryption/rsa_pem.dart';
import 'package:flutter_app/ui_elements/app_button_async.dart';
import 'package:pointycastle/asymmetric/api.dart';

class TestEncryptPrivateKey extends StatefulWidget {
  @override
  _TestEncryptPrivateKeyState createState() => _TestEncryptPrivateKeyState();
}

class _TestEncryptPrivateKeyState extends State<TestEncryptPrivateKey> {
  String privateKeyPem;
  String decryptedPem;

  @override
  void initState() {
    super.initState();
    privateKeyPem = "#";
    decryptedPem = "#";
  }

  Future<void> encryptDecrypt() async {
    final helper = RsaKeyHelper();
    RSAPrivateKey privateKey = generateKeyPair().privateKey;
    setState(() {
      privateKeyPem = helper.encodePrivateKeyToPem(privateKey);
    });
    List<String> symmKey = await keyToWords(generateKey());
    String encryptedPrivateKey =
        await helper.encryptPrivateKey(privateKey, symmKey);

    RSAPrivateKey decryptedPrivateKey =
        await helper.decryptPrivateKey(encryptedPrivateKey, symmKey);
    setState(() {
      decryptedPem = helper.encodePrivateKeyToPem(decryptedPrivateKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text(privateKeyPem),
          ),
          ListTile(
            title: Text(decryptedPem),
          ),
          AppButton(label: "Submit", onPressed: encryptDecrypt),
        ],
      ),
    );
  }
}
