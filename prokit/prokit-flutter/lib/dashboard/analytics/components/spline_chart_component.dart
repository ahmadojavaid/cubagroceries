import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/analytics/model/chart_data_model.dart';
import 'package:prokit_flutter/dashboard/analytics/utils/colors.dart';

class SplineChartComponent extends StatefulWidget {
  @override
  State<SplineChartComponent> createState() => _SplineChartComponentState();
}

class _SplineChartComponentState extends State<SplineChartComponent> {
  final List<ChartDataModel> chartData = [];
  final List<FlSpot> spots = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    for (int i = 1; i <= 30; i++) {
      chartData.add(ChartDataModel(dateMonthYear: (i + 10).toDouble(), visitors: Random().nextInt(16000000).toDouble()));
    }

    // Convert dataList to a list of FlSpot objects
    spots.addAll(chartData.map((data) => FlSpot(data.dateMonthYear.validate(), data.visitors.validate())).toList());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      height: 320,
      child: LineChart(
        duration: Duration(milliseconds: 150), // Optional
        curve: Curves.linear, // Optional
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 50),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: spots.first.x,
          maxX: spots.last.x,
          lineTouchData: LineTouchData(
              enabled: true,
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => chartSplineColor,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final textStyle = primaryTextStyle(
                      color: Colors.white,
                      weight: FontWeight.bold,
                      size: 12,
                    );
                    return LineTooltipItem(touchedSpot.y.toString().formatNumberWithComma().splitBefore('.'), textStyle);
                  }).toList();
                },
              )),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: chartSplineColor,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
              isStrokeCapRound: true,
              preventCurveOverShooting: true,

              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
