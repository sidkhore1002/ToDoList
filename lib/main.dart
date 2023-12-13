import 'package:flutter/material.dart';
import 'package:todo/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget defaultScreen = Home();

  runApp(MaterialApp(
    theme: ThemeData(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => defaultScreen,
      '/home': (context) => Home(),
    },
  ));
}
