import 'package:flutter/material.dart';
import 'package:chart_sample/presentation/widgets/line_chart_sample.dart';

class LineChartScreen extends StatelessWidget {
  const LineChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart Example'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: const LineChartSample(),
          )
        ),
      ),
    );
  }
}

