import 'package:flutter/material.dart';
import 'api method1/cat1.dart';
import 'nifo.dart';

void main() {
  String strNumber = "66ceb4f87641445e94a4e59f";
  int number = int.parse(strNumber); // This will work
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Page1()
    );
  }
}
