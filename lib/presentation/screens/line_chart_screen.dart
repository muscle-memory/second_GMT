import 'package:flutter/material.dart';
import 'package:chart_sample/presentation/widgets/line_chart_with_zoom.dart';
import '../widgets/zoom_controls.dart';
import 'package:chart_sample/domain/models/chart_data.dart';

class LineChartScreen extends StatelessWidget {
  final TransformationController transformationController;
  final ChartData chartData;

  const LineChartScreen({
    super.key,
    required this.transformationController,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart Example'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: LineChartWithZoom(
                    chartData: chartData,
                    transformationController: transformationController,
                  ),
                ),
                const SizedBox(width: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomControls(controller: transformationController),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
