import 'dart:core';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/integrations/utils/data_provider.dart';
import 'package:prokit_flutter/main/model/ExpenseData.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedChart1Screen extends StatefulWidget {
  @override
  StackedChart1ScreenState createState() => StackedChart1ScreenState();
}

class StackedChart1ScreenState extends State<StackedChart1Screen> {
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
      appBar: appBar(context, 'Stacked Chart 1'),
      body: Container(
        height: 500,
        width: context.width(),
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enablePanning: true),
          tooltipBehavior: tooltipBehavior,
          series: <CartesianSeries>[
            StackedLineSeries<ExpenseData, String>(
              name: 'Father',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.father,
            ),
            StackedLineSeries<ExpenseData, String>(
              name: 'Mother',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.mother,
            ),
            StackedLineSeries<ExpenseData, String>(
              name: 'Son',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.son,
            ),
            StackedLineSeries<ExpenseData, String>(
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
//
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/integrations/utils/data_provider.dart';
// import 'package:prokit_flutter/main/model/ExpenseData.dart';
// import 'package:prokit_flutter/main/utils/AppWidget.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class StackedChart1Screen extends StatefulWidget {
//   @override
//   StackedChart1ScreenState createState() => StackedChart1ScreenState();
// }
//
// class StackedChart1ScreenState extends State<StackedChart1Screen> {
//   late List<ExpenseData> chartData;
//   late TooltipBehavior tooltipBehavior;
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   Future<void> init() async {
//     chartData = getChartData();
//     setState(() {});
//   }
//
//   // Helper function to generate FlSpot list
//   List<FlSpot> getLineSpots(List<ExpenseData> data, double Function(ExpenseData) yValueMapper) {
//     return data.asMap().entries.map((entry) {
//       return FlSpot(entry.key.toDouble(), yValueMapper(entry.value));
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context, 'Stacked Chart 1'),
//       body: Container(
//         padding: EdgeInsets.only(left: 16,right: 30),
//         height: 500,
//         width: context.width(),
//         child: LineChart(
//           LineChartData(
//             lineTouchData: LineTouchData(enabled: true),
//             gridData: FlGridData(
//               show: false, // Removed grid lines
//             ),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   interval: 1,
//                   getTitlesWidget: (value, _) {
//                     if (value.toInt() < chartData.length) {
//                       return Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: Text(
//                           chartData[value.toInt()].expanseCategory ?? '',
//                           style: TextStyle(fontSize: 12, color: Colors.black),
//                         ),
//                       );
//                     }
//                     return Text('');
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   interval: 20,
//                   getTitlesWidget: (value, _) {
//                     return Text(
//                       value.toInt().toString(),
//                       style: TextStyle(fontSize: 12, color: Colors.black),
//                     );
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
//             borderData: FlBorderData(
//               show: true,
//               border: Border(
//                 left: BorderSide(color: Colors.black12),
//                 bottom: BorderSide(color: Colors.black12),
//                 right: BorderSide(color: Colors.transparent),
//                 top: BorderSide(color: Colors.transparent),
//               ),
//             ),
//             minX: 0,
//             maxX: (chartData.length - 1).toDouble(),
//             minY: 0,
//             maxY: 100,
//             lineBarsData: [
//               _buildLineChartBarData(
//                 spots: getLineSpots(chartData, (exp) => exp.father?.toDouble() ?? 0.0),
//                 color: Colors.orange,
//               ),
//               _buildLineChartBarData(
//                 spots: getLineSpots(chartData, (exp) => exp.mother?.toDouble() ?? 0.0),
//                 color: Colors.blue,
//               ),
//               _buildLineChartBarData(
//                 spots: getLineSpots(chartData, (exp) => exp.son?.toDouble() ?? 0.0),
//                 color: Colors.purple,
//               ),
//               _buildLineChartBarData(
//                 spots: getLineSpots(chartData, (exp) => exp.daughter?.toDouble() ?? 0.0),
//                 color: Colors.cyan,
//               ),
//             ],
//           ),
//         ),
//       ).center(),
//     );
//   }
//
//   LineChartBarData _buildLineChartBarData({required List<FlSpot> spots, required Color color}) {
//     return LineChartBarData(
//       isStrokeCapRound: true,
//       spots: spots,
//       barWidth: 3,
//       belowBarData: BarAreaData(show: false),
//       dotData: FlDotData(show: true),
//       color: color,
//     );
//   }
// }
