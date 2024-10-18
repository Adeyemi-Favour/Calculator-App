import 'package:calculator_app/homePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(calculator());

class calculator extends StatelessWidget {
  const calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
      home: calculatorApp(),
    );
  }
}
