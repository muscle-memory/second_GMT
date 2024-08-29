import 'package:fl_chart/fl_chart.dart';

class ChartData {
  final List<FlSpot> spots;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  ChartData({
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required List<Map<String, double>> traceData,
  }) : spots = traceData.isNotEmpty
      ? traceData.map((data) {
    final double x = data['x']!;
    final double y = data['y']!;
    return FlSpot(x, y);
  }).toList()
      : [];
}
