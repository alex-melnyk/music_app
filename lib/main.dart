import 'package:flutter/material.dart';
import 'package:music_app/screens/screens.dart';

void main() {
  runApp(MaterialApp(
    title: 'Music App Sample',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      canvasColor: Color.fromARGB(255, 13, 13, 13),
      appBarTheme: AppBarTheme(
        color: Color.fromARGB(255, 13, 13, 13),
      ),
    ),
    home: HomeScreen(),
  ));
}
