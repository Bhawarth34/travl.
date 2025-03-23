import 'package:flutter/material.dart';
import 'package:travl/screens/login.dart';
import 'package:travl/screens/permissionHandler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'travl.',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(102, 86, 135, 100)),
      ),
      home: const permissionHandler(title: 'travl.'),
    );
  }
}

