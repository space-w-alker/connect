import 'package:firebase_core/firebase_core.dart';

class FbApp{
  dynamic getApp()async{
    return Firebase.initializeApp();
  }
}