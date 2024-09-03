import 'package:flutter/material.dart';
import 'package:chart_sample/presentation/widgets/line_chart_with_zoom.dart';
import '../widgets/zoom_controls.dart';
import 'package:chart_sample/domain/models/chart_data.dart';

class LineChartScreen extends StatefulWidget {
  final TransformationController transformationController;
  final ChartData chartData;

  const LineChartScreen({
    super.key,
    required this.transformationController,
    required this.chartData,
  });

  @override
  State<LineChartScreen> createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  final GlobalKey<LineChartWithZoomState> _chartKey = GlobalKey<LineChartWithZoomState>();

  bool _isMarkerActive = false;
  bool _handleBuiltInTouches = false;

  void _onMarkerPressed() {
    setState(() {
      _isMarkerActive = !_isMarkerActive;
    });
  }

  void updateHandleBuiltInTouches(bool value) {
    setState(() {
      _handleBuiltInTouches = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart Example'),
        centerTitle: true,
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
                    key: _chartKey,
                    chartData: widget.chartData,
                    transformationController: widget.transformationController,
                    isMarkerActive: _isMarkerActive,
                    handleBuiltInTouches: _handleBuiltInTouches,
                  ),
                ),
                const SizedBox(width: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomControls(
                      controller: widget.transformationController,
                      onMarkerPressed: _onMarkerPressed,
                      onTouchChange: updateHandleBuiltInTouches,
                      isHandlingTouches: _handleBuiltInTouches,
                    ),
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
