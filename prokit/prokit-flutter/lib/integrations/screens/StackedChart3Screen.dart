import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/integrations/utils/data_provider.dart';
import 'package:prokit_flutter/main/model/ExpenseData.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedChart3Screen extends StatefulWidget {
  @override
  StackedChart3ScreenState createState() => StackedChart3ScreenState();
}

class StackedChart3ScreenState extends State<StackedChart3Screen> {
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
      appBar: appBar(context, 'Stacked Chart 3'),
      body: Container(
        height: 500,
        width: context.width(),
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enableDoubleTapZooming: true, enablePanning: true),
          tooltipBehavior: tooltipBehavior,
          series: <CartesianSeries>[
            StackedBarSeries<ExpenseData, String>(
              name: 'Father',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.father,
            ),
            StackedBarSeries<ExpenseData, String>(
              name: 'Mother',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.mother,
            ),
            StackedBarSeries<ExpenseData, String>(
              name: 'Son',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.son,
            ),
            StackedBarSeries<ExpenseData, String>(
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


// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/integrations/utils/data_provider.dart';
// import 'package:prokit_flutter/main/model/ExpenseData.dart';
// import 'package:prokit_flutter/main/utils/AppWidget.dart';
//
// class StackedChart3Screen extends StatefulWidget {
//   @override
//   StackedChart3ScreenState createState() => StackedChart3ScreenState();
// }
//
// class StackedChart3ScreenState extends State<StackedChart3Screen> {
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
//     setState(() {}); // Ensure state is updated after data is loaded
//   }
//
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context, 'Stacked Chart 3'),
//       body: Container(
//         height: 500,
//         width: context.width(),
//         padding: const EdgeInsets.all(8.0),
//         child: BarChart(
//           BarChartData(
//             alignment: BarChartAlignment.spaceBetween,
//             maxY: 250,
//             barTouchData: BarTouchData(
//               enabled: true,
//               touchTooltipData: BarTouchTooltipData(
//                 getTooltipColor:(group) =>  Colors.black,
//                 getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                   String category = chartData[group.x.toInt()].expanseCategory ?? '';
//                   return BarTooltipItem(
//                     '$category\n',
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: '${rod.toY.toInt()}',
//                         style: TextStyle(color: rod.color),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             gridData: FlGridData(show: false),
//             borderData: FlBorderData(
//               show: true,
//               border: Border(
//                 left: BorderSide(color: Colors.black),
//                 bottom: BorderSide(color: Colors.black),
//               ),
//             ),
//             groupsSpace: 12,
//             barGroups: getBarGroups(),
//             titlesData: FlTitlesData(
//               topTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   interval: 50,
//                   getTitlesWidget: (value, meta) {
//                     return Text(
//                       '${value.toInt()}',
//                       style: TextStyle(fontSize: 14),
//                     );
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 60,
//                   getTitlesWidget: (value, meta) {
//                     int index = value.toInt();
//                     if (index >= 0 && index < chartData.length) {
//                       return Text(
//                         chartData[index].expanseCategory ?? '',
//                         style: TextStyle(fontSize: 14),
//                       );
//                     }
//                     return SizedBox.shrink();
//                   },
//                 ),
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
//     final List<String> categories = chartData.map((e) => e.expanseCategory ?? '').toSet().toList();
//
//     for (var i = 0; i < categories.length; i++) {
//       final category = categories[i];
//       final data = chartData.firstWhere((e) => e.expanseCategory == category, orElse: () => ExpenseData());
//
//       final value1 = (data.father ?? 0.0).toDouble();
//       final value2 = (data.mother ?? 0.0).toDouble();
//       final value3 = (data.son ?? 0.0).toDouble();
//       final value4 = (data.daughter ?? 0.0).toDouble();
//
//       barGroups.add(
//         BarChartGroupData(
//           x: i,
//           barsSpace: 4,
//           barRods: [
//             BarChartRodData(
//               fromY: 0,
//               toY: value1,
//               color: Colors.cyan,
//               width: 20,
//               borderRadius: BorderRadius.zero,
//             ),
//             BarChartRodData(
//               fromY: value1,
//               toY: value1 + value2,
//               color: Colors.purple,
//               width: 20,
//               borderRadius: BorderRadius.zero,
//             ),
//             BarChartRodData(
//               fromY: value1 + value2,
//               toY: value1 + value2 + value3,
//               color: Colors.indigo,
//               width: 20,
//               borderRadius: BorderRadius.zero,
//             ),
//             BarChartRodData(
//               fromY: value1 + value2 + value3,
//               toY: value1 + value2 + value3 + value4,
//               color: Colors.orange,
//             ),
//           ],
//         ),
//       );
//     }
//     return barGroups;
//   }
// }
