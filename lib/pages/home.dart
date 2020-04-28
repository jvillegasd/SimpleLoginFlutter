import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_login/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('Email: ${Provider.of<User>(context, listen: false).email}'),
          FlatButton(
              onPressed: () {
                _logout();
              },
              child: Text('Logout'))
        ],
      ),
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('isLogged', false);
    Provider.of<User>(context, listen: false).changeLoggedStatus(false);
    Navigator.pushReplacementNamed(context, "/");
  }
}
