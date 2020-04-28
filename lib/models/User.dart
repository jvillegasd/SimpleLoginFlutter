import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String _email;
  String _password;
  bool _isLogged = false;
  User();

  void changeData(String email, String password) {
    this._email = email;
    this._password = password;
    notifyListeners();
  }

  void changeLoggedStatus(bool isLogged) {
    this._isLogged = isLogged;
    notifyListeners();
  }

  bool userExists(String email, String password) {
    return this._email == email && this._password == password;
  }

  bool get isLogged => _isLogged;
  
  String get email => _email;
  
  String get password => _password;
}