import 'package:flutter/material.dart';
import 'package:chart_sample/presentation/screens/line_chart_screen.dart';
import 'package:chart_sample/presentation/widgets/line_chart_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TransformationController _transformationController = TransformationController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chart Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LineChartContainer(),  // LineChartContainer 사용
    );
  }
}
