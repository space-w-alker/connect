import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/encryption/save_key.dart';
import 'package:flutter_app/pages/authentication/app_input.dart';
import '../../ui_elements/app_button.dart';
import '../../encryption/key_pair_generator.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback closeSelf;
  SignUpPage({this.closeSelf});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  BigInt privateExponent;
  BigInt p;
  BigInt q;
  BigInt publicExponent;
  String private;

  @override
  void initState(){
    super.initState();
  }


  Future<void> signUpClicked() async{
    var pair = await compute(generateRSAKeyPair, "message");
    setState(() {
      privateExponent = pair.privateKey.privateExponent;
      p = pair.privateKey.p;
      q = pair.privateKey.q;
      publicExponent = pair.privateKey.publicExponent;
    });
  }

  @override
  Widget build(BuildContext context) {
    var b;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(privateExponent==null?"Null":privateExponent.toRadixString(2),),
        AppButton(label: "Generate RSA Key", onPressed: signUpClicked),
        SizedBox(height: 30,),
        MaterialButton(onPressed: (){}, child: Text("Enter existing RSA key"),)
      ],
    );
  }
}
