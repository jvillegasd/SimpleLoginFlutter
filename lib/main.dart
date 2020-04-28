import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_login/models/User.dart';
import 'package:simple_login/pages/login.dart';
import 'package:simple_login/pages/home.dart';
import 'package:simple_login/pages/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Scaffold login =
        new Scaffold(appBar: AppBar(title: Text('Login')), body: Login());
    Scaffold home = Scaffold(appBar: AppBar(title: Text('Home')), body: Home());
    Scaffold signIn =
        new Scaffold(appBar: AppBar(title: Text('Sign in')), body: SignIn());
    return ChangeNotifierProvider<User>(
        create: (context) => User(),
        child: Consumer<User>(builder: (context, currentUser, child) {
          return MaterialApp(title: "Login", initialRoute: '/', routes: {
            '/': (context) => Provider.of<User>(context, listen:false).isLogged? home : login,
            '/home': (context) => home,
            '/signin': (context) => signIn
          });
        }));
  }
}
