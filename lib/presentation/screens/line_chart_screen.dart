import 'package:flutter/material.dart';
import 'package:chart_sample/presentation/widgets/line_chart_sample.dart';

import '../widgets/zoom_controls.dart';

class LineChartScreen extends StatelessWidget {
  final TransformationController transformationController;

  const LineChartScreen({
    super.key,
    required this.transformationController,
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
                  child: InteractiveViewer(
                    transformationController: transformationController,
                    child: LineChartSample(),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InteractiveViewer(
                        child: ZoomControls(controller: transformationController),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
