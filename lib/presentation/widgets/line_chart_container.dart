import 'package:flutter/material.dart';
import 'package:chart_sample/domain/models/chart_data.dart';
import 'package:chart_sample/presentation/widgets/line_chart_with_zoom.dart';
import '../resources/value_resources.dart';

class LineChartContainer extends StatefulWidget {
  const LineChartContainer({super.key});

  @override
  LineChartContainerState createState() => LineChartContainerState();
}

class LineChartContainerState extends State<LineChartContainer> {
  late Future<ChartData> _chartDataFuture;
  final TransformationController _transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    _chartDataFuture = loadTraceData().then((traceData) {
      return ChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 44,
        traceData: traceData,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChartData>(
      future: _chartDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final chartData = snapshot.data!;
        return LineChartWithZoom(
          chartData: chartData,
          transformationController: _transformationController,
        );
      },
    );
  }
}
