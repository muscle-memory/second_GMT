import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:chart_sample/presentation/resources/app_colors.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
  String label = meta.formattedValue;

  final style = TextStyle(
    color: AppColors.contentColorBlack,
    fontWeight: FontWeight.bold,
    fontSize: min(18, 18 * chartWidth / 300),
  );

  if (value % 1 != 0) {
    if (value == 10.5) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 12,
        child: Text("km", style: style),
      );
    }
    return Container();
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 12,
    child: Text(meta.formattedValue, style: style),
  );
}



Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
  String label = meta.formattedValue;

  final style = TextStyle(
    color: AppColors.contentColorBlack,
    fontWeight: FontWeight.bold,
    fontSize: min(18, 18 * chartWidth / 300),
  );

  if (value % 10 != 0) {
    if (value == 45) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 12,
        child: Text("db", style: style),
      );
    }
    return Container();
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 12,
    child: Text(meta.formattedValue, style: style),
  );
}
