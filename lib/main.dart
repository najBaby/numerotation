import 'package:flutter/material.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
  ThemeData get theme => ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.white,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(App());
}
