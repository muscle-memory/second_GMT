import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:chart_sample/presentation/resources/app_resources.dart';
import 'package:chart_sample/domain/models/chart_data.dart';
import 'package:chart_sample/presentation/widgets/zoom_controls.dart';
import 'package:chart_sample/presentation/widgets/title_widgets.dart';

class LineChartWithZoom extends StatelessWidget {
  final ChartData chartData;
  final TransformationController transformationController;

  const LineChartWithZoom({
    super.key,
    required this.chartData,
    required this.transformationController,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            _buildInteractiveChart(constraints),
            Positioned(
              right: 20,
              top: 20,
              child: ZoomControls(controller: transformationController),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInteractiveChart(BoxConstraints constraints) {
    return InteractiveViewer(
      panEnabled: true,
      scaleEnabled: true,
      transformationController: transformationController,
      minScale: 1.0,
      maxScale: 3.0,
      child: SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: LineChart(_buildLineChartData(constraints)),
      ),
    );
  }

  LineChartData _buildLineChartData(BoxConstraints constraints) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: false
      ),
      lineBarsData: [
        LineChartBarData(
          color: AppColors.contentColorBlack,
          spots: chartData.spots,
          isCurved: true,
          isStrokeCapRound: true,
          barWidth: 0.5,
          belowBarData: BarAreaData(show: false),
          dotData: const FlDotData(show: false),
        ),
      ],
      minX: chartData.minX,
      maxX: chartData.maxX,
      minY: chartData.minY,
      maxY: chartData.maxY,
      titlesData: _buildTitlesData(constraints.maxWidth),
      gridData: _buildGridData(),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(color: Colors.black, width: 1),
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
    );
  }

  FlTitlesData _buildTitlesData(double chartWidth) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, chartWidth),
          reservedSize: 50,
        ),
        drawBelowEverything: true,
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, chartWidth),
          reservedSize: 50,
          interval: 10,
        ),
        drawBelowEverything: true,
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      horizontalInterval: 10,
      verticalInterval: 10,
      checkToShowHorizontalLine: (value) => value.toInt() % 10 == 0,
      checkToShowVerticalLine: (value) => value.toInt() % 10 == 0,
      getDrawingHorizontalLine: (_) => FlLine(
        color: AppColors.contentColorBlue.withOpacity(1),
        strokeWidth: 0.8,
      ),
      getDrawingVerticalLine: (_) => FlLine(
        color: AppColors.contentColorBlue.withOpacity(1),
        strokeWidth: 0.8,
      ),
    );
  }
}

