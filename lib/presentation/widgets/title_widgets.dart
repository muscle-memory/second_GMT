import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:chart_sample/presentation/resources/app_resources.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
  if (value % 10 != 0) {
    return Container();
  }

  final style = TextStyle(
    color: AppColors.contentColorBlue,
    fontWeight: FontWeight.bold,
    fontSize: min(18, 18 * chartWidth / 300),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 12,
    child: Text(meta.formattedValue, style: style),
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
  if (value % 10 != 0) {
    return Container();
  }

  final style = TextStyle(
    color: AppColors.contentColorBlack,
    fontWeight: FontWeight.bold,
    fontSize: min(18, 18 * chartWidth / 300),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 12,
    child: Text(meta.formattedValue, style: style),
  );
}
