import 'package:flutter/material.dart';
import 'package:work_1/screen/homeScreen.dart';
import 'package:work_1/screen/notesScreen.dart';

void main()
{
  runApp(const NasaApp());
}

class NasaApp extends StatelessWidget {
  const NasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes:
      {
        '/': (context) => homeScreen(),
        '/notes': (context) => notesScreen(),
      },
    );
  }
}