import 'package:chart_sample/presentation/widgets/title_widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:chart_sample/presentation/resources/app_colors.dart';
import 'package:chart_sample/domain/models/chart_data.dart';

class LineChartWithZoom extends StatefulWidget {
  final ChartData chartData;
  final TransformationController transformationController;
  final bool isMarkerActive;
  final bool handleBuiltInTouches;

  const LineChartWithZoom({
    super.key,
    required this.chartData,
    required this.transformationController,
    required this.isMarkerActive,
    required this.handleBuiltInTouches,
  });

  @override
  LineChartWithZoomState createState() => LineChartWithZoomState();
}

class LineChartWithZoomState extends State<LineChartWithZoom> {
  FlSpot? _selectedSpot;
  List<VerticalLine> _verticalLines = [];
  VerticalLine? _tempLine;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapUp: widget.isMarkerActive ? _onTapUp : null,
          child: InteractiveViewer(
            transformationController: widget.transformationController,
            panEnabled: true,
            scaleEnabled: true,
            minScale: 1.0,
            maxScale: 3.0,
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: LineChart(_buildLineChartData(constraints)),
            ),
          ),
        );
      },
    );
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      final tapPosition = details.localPosition;
      final chartX = _calculateChartX(tapPosition.dx, context.size!.width);

      _tempLine = VerticalLine(
        x: chartX,
        color: Colors.blueAccent,
        strokeWidth: 2,
      );

      _verticalLines.add(_tempLine!);
      print('Marker added at x: ${_tempLine!.x}');
      _tempLine = null;
    });
  }

  double _calculateChartX(double tapX, double chartWidth) {
    double minX = widget.chartData.minX;
    double maxX = widget.chartData.maxX;
    return minX + (tapX / chartWidth) * (maxX - minX);
  }

  LineChartData _buildLineChartData(BoxConstraints constraints) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        handleBuiltInTouches: widget.handleBuiltInTouches,
        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
          if (response != null && response.lineBarSpots != null) {
            setState(() {
              _selectedSpot = response.lineBarSpots!.first;
            });
          }
        },
      ),
      lineBarsData: [
        LineChartBarData(
          color: AppColors.contentColorred,
          spots: widget.chartData.spots,
          isCurved: true,
          isStrokeCapRound: true,
          barWidth: 0.5,
          belowBarData: BarAreaData(show: false),
          dotData: FlDotData(show: false),
        ),
      ],
      minX: widget.chartData.minX,
      maxX: widget.chartData.maxX,
      minY: widget.chartData.minY,
      maxY: widget.chartData.maxY,
      titlesData: _buildTitlesData(constraints.maxWidth),
      gridData: _buildGridData(),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(color: Colors.black, width: 1),
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      extraLinesData: _buildExtraLinesData(),
    );
  }

  ExtraLinesData _buildExtraLinesData() {
    List<VerticalLine> lines = List.from(_verticalLines);
    if (_tempLine != null) {
      lines.add(_tempLine!);
    }
    return ExtraLinesData(
      verticalLines: lines,
    );
  }

  FlTitlesData _buildTitlesData(double chartWidth) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) =>
              leftTitleWidgets(value, meta, chartWidth),
          reservedSize: 50,
          interval: 5,
        ),
        drawBelowEverything: true,
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) =>
              bottomTitleWidgets(value, meta, chartWidth),
          reservedSize: 50,
          interval: 0.5,
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
      verticalInterval: 1,
      checkToShowHorizontalLine: (value) => value.toInt() % 10 == 0,
      checkToShowVerticalLine: (value) => value.toInt() % 1 == 0,
      getDrawingHorizontalLine: (_) => FlLine(
        color: AppColors.contentColorBlack.withOpacity(1),
        strokeWidth: 0.8,
      ),
      getDrawingVerticalLine: (_) => FlLine(
        color: AppColors.contentColorBlack.withOpacity(1),
        strokeWidth: 0.8,
      ),
    );
  }
}
