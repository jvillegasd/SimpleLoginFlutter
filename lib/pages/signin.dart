import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = new TextEditingController();
  final controllerPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Expanded(
            child: TextFormField(
                controller: controllerEmail,
                validator: (value) {
                  if (value.isEmpty) return 'Please, enter an email!';
                  return null;
                }),
          ),
          Expanded(
            child: TextFormField(
              controller: controllerPass,
              validator: (value) {
                if (value.isEmpty) return 'Please, enter a password!';
                return null;
              },
            ),
          ),
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  String email = controllerEmail.text;
                  String password = controllerPass.text.toString();
                  controllerPass.clear();
                  controllerEmail.clear();
                  _saveNewUser(email, password);
                }
              },
              child: Text('Submit'))
        ]));
  }

  void _saveNewUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setBool('isLogged', true);
    Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
  }
}