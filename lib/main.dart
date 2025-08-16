import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor:
            Colors.amber, // Global background color for Scaffolds
      ),
      title: 'Todos App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
