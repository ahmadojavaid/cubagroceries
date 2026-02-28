import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/integrations/utils/data_provider.dart';
import 'package:prokit_flutter/main/model/ExpenseData.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedChart4Screen extends StatefulWidget {
  @override
  StackedChart4ScreenState createState() => StackedChart4ScreenState();
}

class StackedChart4ScreenState extends State<StackedChart4Screen> {
  late List<ExpenseData> chartData;
  late TooltipBehavior tooltipBehavior;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    chartData = getChartData();
    tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Stacked Chart 4'),
      body: Container(
        height: 500,
        width: context.width(),
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enableDoubleTapZooming: true, enablePanning: true),
          tooltipBehavior: tooltipBehavior,
          series: <CartesianSeries>[
            StackedColumnSeries<ExpenseData, String>(
              name: 'Father',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.father,
            ),
            StackedColumnSeries<ExpenseData, String>(
              name: 'Mother',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.mother,
            ),
            StackedColumnSeries<ExpenseData, String>(
              name: 'Son',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.son,
            ),
            StackedColumnSeries<ExpenseData, String>(
              name: 'Daughter',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.daughter,
            ),
          ],
          primaryXAxis: CategoryAxis(),
        ),
      ).center(),
    );
  }
}


// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/integrations/utils/data_provider.dart';
// import 'package:prokit_flutter/main/model/ExpenseData.dart';
// import 'package:prokit_flutter/main/utils/AppWidget.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class StackedChart4Screen extends StatefulWidget {
//   @override
//   StackedChart4ScreenState createState() => StackedChart4ScreenState();
// }
//
// class StackedChart4ScreenState extends State<StackedChart4Screen> {
//   late List<ExpenseData> chartData;
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   Future<void> init() async {
//     chartData = getChartData();
//     setState(() {}); // Rebuild the chart after loading data
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context, 'Stacked Chart 4'),
//       body: Container(
//         padding: EdgeInsets.only(right: 30, left: 16),
//         height: 500,
//         width: context.width(),
//         child: BarChart(
//           BarChartData(
//             alignment: BarChartAlignment.spaceBetween,
//             barGroups: getBarGroups(),
//             gridData: FlGridData(show: false),
//             // Remove grid lines
//             borderData: FlBorderData(
//               show: true,
//               border: Border(
//                 left: BorderSide(color: Colors.black), // Left border for axis
//                 bottom: BorderSide(color: Colors.black), // Bottom border for axis
//               ),
//             ),
//             titlesData: FlTitlesData(
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value, meta) {
//                     return Text(
//                       value.toString(),
//                       style: TextStyle(fontSize: 12),
//                     );
//                   },
//                   reservedSize: 40,
//                   interval: 20, // Set interval for left side values
//                 ),
//               ),
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value, meta) {
//                     final int index = value.toInt();
//                     if (index < 0 || index >= chartData.length) return const SizedBox.shrink();
//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       child: Text(
//                         chartData[index].expanseCategory ?? '',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     );
//                   },
//                   reservedSize: 80,
//                 ),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false), // Hide right side titles
//               ),
//               topTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false), // Hide top side titles
//               ),
//             ),
//           ),
//         ),
//       ).center(),
//     );
//   }
//
//   List<BarChartGroupData> getBarGroups() {
//     List<BarChartGroupData> barGroups = [];
//
//     for (var i = 0; i < chartData.length; i++) {
//       final ExpenseData data = chartData[i];
//       barGroups.add(
//         BarChartGroupData(
//           x: i,
//           barRods: [
//             BarChartRodData(toY: (data.father ?? 0).toDouble(), color: Colors.blue, width: 30, borderRadius: BorderRadius.circular(0)),
//             BarChartRodData(toY: (data.mother ?? 0).toDouble(), color: Colors.red, width: 30, borderRadius: BorderRadius.circular(0)),
//             BarChartRodData(toY: (data.son ?? 0).toDouble(), color: Colors.green, width: 30, borderRadius: BorderRadius.circular(0)),
//             BarChartRodData(toY: (data.daughter ?? 0).toDouble(), color: Colors.orange, width: 30, borderRadius: BorderRadius.circular(0)),
//           ],
//           groupVertically: true,
//         ),
//       );
//     }
//     return barGroups;
//   }
// }
