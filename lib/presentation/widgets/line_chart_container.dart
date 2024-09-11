import 'package:flutter/material.dart';
import 'package:chart_sample/presentation/screens/line_chart_screen.dart';

class LineChartContainer extends StatefulWidget {
  const LineChartContainer({super.key});

  @override
  LineChartContainerState createState() => LineChartContainerState();
}

class LineChartContainerState extends State<LineChartContainer> {
  final TransformationController _transformationController = TransformationController();
  
  @override
  Widget build(BuildContext context) {
    return LineChartScreen(transformationController: _transformationController,);
  }
}
