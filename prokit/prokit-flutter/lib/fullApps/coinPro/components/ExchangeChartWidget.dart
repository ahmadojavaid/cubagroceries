import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/coinPro/utils/CPColors.dart';
import 'package:prokit_flutter/fullApps/coinPro/utils/CPDataProvider.dart';

class ExchangeChartWidget extends StatefulWidget {
  @override
  _ExchangeChartWidgetState createState() => _ExchangeChartWidgetState();
}

class ChartData {
  String? key;
  double? value;

  ChartData(this.key, this.value);
}

class _ExchangeChartWidgetState extends State<ExchangeChartWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  // Convert dataList to a list of FlSpot objects
  List<FlSpot> flSpotList = dataList.map((item) {
    double x = item[0] / 1000; // Convert timestamp from milliseconds to seconds
    double y = double.parse(item[1]); // Parse the string to double
    return FlSpot(x, y);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      height: 320,
      child: LineChart(
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
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: leftTitleWidgets,
                reservedSize: 50,
                interval: 100000,
              ),
            ),
          ),
          borderData: FlBorderData(show: true, border: Border.all(color: CPPrimaryColor)),
          minX: flSpotList.first.x,
          maxX: flSpotList.last.x,
          minY: 0,
          maxY: 500000,
          lineTouchData: LineTouchData(
              enabled: true,
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => CPPrimaryColor.withOpacity(0.8),
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    final textStyle = primaryTextStyle(
                      color: Colors.white,
                      weight: FontWeight.bold,
                      size: 12,
                    );
                    return LineTooltipItem(touchedSpot.y.toStringAsFixed(3), textStyle);
                  }).toList();
                },
              )),
          lineBarsData: [
            LineChartBarData(
              spots: flSpotList,
              isCurved: true,
              color: CPPrimaryColor,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: CPPrimaryColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 100000:
        text = '100000';
        break;
      case 200000:
        text = '200000';
        break;
      case 300000:
        text = '300000';
        break;
      case 400000:
        text = '400000';
        break;
      case 500000:
        text = '500000';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
