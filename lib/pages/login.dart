import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_login/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = new TextEditingController();
  final controllerPass = new TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _authentication("", "", false));
  }

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
                  String password = controllerPass.text;
                  controllerPass.clear();
                  controllerEmail.clear();
                  _authentication(email, password, true);
                }
              },
              child: Text('Sign up')),
          FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: Text('Sign in'))
        ]));
  }

  void _authentication(String email, String password, bool wantLog) async {
    if (Provider.of<User>(context, listen: false).userExists(email, password)) { //If the process is not killed
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('isLogged', true);
      Provider.of<User>(context, listen: false).changeLoggedStatus(true);
      Navigator.pushReplacementNamed(context, "/");
    } else {
      final prefs = await SharedPreferences.getInstance();

      final emailShared = prefs.getString('email') ?? null;
      final passwordShared = prefs.getString('password') ?? null;
      final isLogged = prefs.getBool('isLogged') ?? false;
      if (emailShared.isEmpty || passwordShared.isEmpty) return;
      if (isLogged || wantLog) { //If logged in or the process was killed
        Provider.of<User>(context, listen: false).changeLoggedStatus(true);
        Provider.of<User>(context, listen: false).changeData(emailShared, passwordShared);
        Navigator.pushReplacementNamed(context, "/");
      }
    }
  }
}
