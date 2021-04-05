import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier{
  bool _accepted;
  bool get accepted{
    return _accepted;
  }
  set accepted(bool value){
    if(_accepted != value){
      _accepted = value;
      saveAll();
      notifyListeners();
    }
  }
  
  String _name;
  String get name{
    return _name;
  }
  set name(String value){
    if(_name != value){
      _name = value;
      saveAll();
      notifyListeners();
    }
  }

  int _number;
  int get number{
    return _number;
  }
  set number(int value){
    if(_number != value){
      _number = value;
      saveAll();
      notifyListeners();
    }
  }
  

  AppData(){
    _accepted = false;
    loadAll();
  }

  void loadAll() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accepted = prefs.getBool("accepted") ?? false;
    if(_accepted){
      notifyListeners();
    }
  }

  void saveAll() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("accepted", _accepted);
  }
}