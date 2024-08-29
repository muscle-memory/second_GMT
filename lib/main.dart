import 'package:chart_sample/presentation/screens/line_chart_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LineChartScreen(),
    );
  }
}
