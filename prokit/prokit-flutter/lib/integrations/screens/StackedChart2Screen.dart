import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/integrations/utils/data_provider.dart';
import 'package:prokit_flutter/main/model/ExpenseData.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedChart2Screen extends StatefulWidget {
  @override
  StackedChart2ScreenState createState() => StackedChart2ScreenState();
}

class StackedChart2ScreenState extends State<StackedChart2Screen> {
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
      appBar: appBar(context, 'Stacked Chart 2'),
      body: Container(
        height: 500,
        width: context.width(),
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enableDoubleTapZooming: true, enablePanning: true),
          tooltipBehavior: tooltipBehavior,
          series: <CartesianSeries>[
            StackedArea100Series<ExpenseData, String>(
              name: 'Father',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.father,
            ),
            StackedArea100Series<ExpenseData, String>(
              name: 'Mother',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.mother,
            ),
            StackedArea100Series<ExpenseData, String>(
              name: 'Son',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.son,
            ),
            StackedArea100Series<ExpenseData, String>(
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
// class StackedChart2Screen extends StatefulWidget {
//   @override
//   StackedChart2ScreenState createState() => StackedChart2ScreenState();
// }
//
// class StackedChart2ScreenState extends State<StackedChart2Screen> {
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
//   }
//
//   List<LineChartBarData> _buildChartData() {
//     return [
//       LineChartBarData(
//         spots: chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value.father! / 100) * 100)).toList(),
//         isCurved: false,
//         color: Colors.orange,
//         barWidth: 3,
//         belowBarData: BarAreaData(show: true, color: Colors.orange.withOpacity(0.5)),
//       ),
//       LineChartBarData(
//         spots: chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value.mother! / 100) * 100)).toList(),
//         isCurved: false,
//         color: Colors.blueGrey,
//         barWidth: 3,
//         belowBarData: BarAreaData(show: true, color: Colors.blueGrey.withOpacity(0.5)),
//       ),
//       LineChartBarData(
//         spots: chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value.son! / 100) * 100)).toList(),
//         isCurved: false,
//         color: Colors.purple,
//         barWidth: 3,
//         belowBarData: BarAreaData(show: true, color: Colors.purple.withOpacity(0.5)),
//       ),
//       LineChartBarData(
//         spots: chartData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value.daughter! / 100) * 100)).toList(),
//         isCurved: false,
//         color: Colors.lightBlue,
//         barWidth: 3,
//         belowBarData: BarAreaData(show: true, color: Colors.lightBlue.withOpacity(0.5)),
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context, 'Stacked Chart 2'),
//       body: Container(
//         height: 500,
//         width: context.width(),
//         padding: EdgeInsets.only(left: 16, right: 30),
//         child: LineChart(
//           LineChartData(
//             lineBarsData: _buildChartData(),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 32,
//                   getTitlesWidget: (value, _) {
//                     switch (value.toInt()) {
//                       case 0:
//                         return Text('Food', style: TextStyle(fontSize: 12), textAlign: TextAlign.center);
//                       case 1:
//                         return Text('Transport', style: TextStyle(fontSize: 12), textAlign: TextAlign.center);
//                       case 2:
//                         return Text('Medical', style: TextStyle(fontSize: 12), textAlign: TextAlign.center);
//                       case 3:
//                         return Text('Clothes', style: TextStyle(fontSize: 12), textAlign: TextAlign.center);
//                       case 4:
//                         return Text('Books', style: TextStyle(fontSize: 12), textAlign: TextAlign.center);
//                       case 5:
//                         return Text('Other', style: TextStyle(fontSize: 12), textAlign: TextAlign.center);
//                       default:
//                         return Container();
//                     }
//                   },
//                   interval: 1, // Ensure titles are spaced properly
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   getTitlesWidget: (value, _) {
//                     return Text('${value.toInt()}%', style: TextStyle(fontSize: 12));
//                   },
//                 ),
//               ),
//               topTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//             ),
//             gridData: FlGridData(show: false),
//             // No grid lines
//             borderData: FlBorderData(
//               show: true,
//               border: Border(
//                 left: BorderSide(color: Colors.black),
//                 bottom: BorderSide(color: Colors.black),
//               ),
//             ),
//             minY: 0,
//             maxY: 100,
//             minX: 0,
//             maxX: 5,
//           ),
//         ),
//       ).center(),
//     );
//   }
// }
