import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class StepsChart extends StatelessWidget {
  const StepsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Steps",
            style: TextStyle(color: limeColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          12.height,
          AspectRatio(
            aspectRatio: 1.4,
            child: BarChart(
              BarChartData(
                backgroundColor: buttonColor,
                barGroups: _getBarGroups(),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (value % 5 == 0) {
                          return Text('${value.toInt()}', style: TextStyle(color: limeColor, fontSize: 12));
                        }
                        return Container();
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        List<String> labels = ['Jan', 'Feb', 'Mar', 'Apr'];
                        return Text(labels[value.toInt()], style: TextStyle(color: limeColor, fontSize: 12));
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    List<double> totalSteps = [170, 170, 170, 170];
    List<double> completedSteps = [155, 165, 155, 155];

    return List.generate(4, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: totalSteps[index],
            color: limeColor,
            width: 18,
            borderRadius: BorderRadius.circular(8),
            rodStackItems: [
              BarChartRodStackItem(500, completedSteps[index], grey),
            ],
          ),
        ],
      );
    });
  }
}
