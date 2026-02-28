import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/integrations/utils/data_provider.dart';
import 'package:prokit_flutter/main/model/ExpenseData.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedChart5Screen extends StatefulWidget {
  static String tag = '/stacked_chart_screen5';
  final bool isDirect;

  StackedChart5Screen({this.isDirect = false});

  @override
  StackedChart5ScreenState createState() => StackedChart5ScreenState();
}

class StackedChart5ScreenState extends State<StackedChart5Screen> {
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
      appBar: appBar(context, 'Stacked Area Chart 5', isDashboard: widget.isDirect),
      body: Container(
        height: 500,
        width: context.width(),
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enableDoubleTapZooming: true, enablePanning: true),
          tooltipBehavior: tooltipBehavior,
          series: <CartesianSeries>[
            StackedAreaSeries<ExpenseData, String>(
              name: 'Father',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.father,
            ),
            StackedAreaSeries<ExpenseData, String>(
              name: 'Mother',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.mother,
            ),
            StackedAreaSeries<ExpenseData, String>(
              name: 'Son',
              markerSettings: MarkerSettings(isVisible: true),
              dataSource: chartData,
              xValueMapper: (ExpenseData exp, _) => exp.expanseCategory,
              yValueMapper: (ExpenseData exp, _) => exp.son,
            ),
            StackedAreaSeries<ExpenseData, String>(
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


// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/integrations/utils/data_provider.dart';
// import 'package:prokit_flutter/main/model/ExpenseData.dart';
// import 'package:prokit_flutter/main/utils/AppWidget.dart';
//
// class StackedChart5Screen extends StatefulWidget {
//   static String tag = '/stacked_chart_screen5';
//   final bool isDirect;
//
//   StackedChart5Screen({this.isDirect = false});
//
//   @override
//   StackedChart5ScreenState createState() => StackedChart5ScreenState();
// }
//
// class StackedChart5ScreenState extends State<StackedChart5Screen> {
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context, 'Stacked Area Chart 5', isDashboard: widget.isDirect),
//       body: Container(
//         padding: EdgeInsets.only(right: 24),
//         height: 500,
//         width: context.width(),
//         child: LineChart(
//           LineChartData(
//             lineBarsData: [
//               LineChartBarData(
//                 spots: chartData
//                     .asMap()
//                     .entries
//                     .map((entry) => FlSpot(
//                   entry.key.toDouble(),
//                   (entry.value.father ?? 0.0).toDouble(),
//                 ))
//                     .toList(),
//                 isCurved: false,
//                 color: Colors.blue,
//                 dotData: FlDotData(show: true),
//                 belowBarData: BarAreaData(show: false),
//               ),
//               LineChartBarData(
//                 spots: chartData
//                     .asMap()
//                     .entries
//                     .map((entry) => FlSpot(
//                   entry.key.toDouble(),
//                   (entry.value.mother ?? 0.0).toDouble(),
//                 ))
//                     .toList(),
//                 isCurved: false,
//                 color: Colors.red,
//                 dotData: FlDotData(show: true),
//                 belowBarData: BarAreaData(show: false),
//               ),
//               LineChartBarData(
//                 spots: chartData
//                     .asMap()
//                     .entries
//                     .map((entry) => FlSpot(
//                   entry.key.toDouble(),
//                   (entry.value.son ?? 0.0).toDouble(),
//                 ))
//                     .toList(),
//                 isCurved: false,
//                 color: Colors.green,
//                 dotData: FlDotData(show: true),
//                 belowBarData: BarAreaData(show: false),
//               ),
//               LineChartBarData(
//                 spots: chartData
//                     .asMap()
//                     .entries
//                     .map((entry) => FlSpot(
//                   entry.key.toDouble(),
//                   (entry.value.daughter ?? 0.0).toDouble(),
//                 ))
//                     .toList(),
//                 isCurved: false,
//                 color: Colors.orange,
//                 dotData: FlDotData(show: true),
//                 belowBarData: BarAreaData(show: false),
//               ),
//             ],
//             minY: 0,
//             maxY: 100,
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 60, // Increased to accommodate rotated labels
//                   getTitlesWidget: (value, meta) {
//                     final index = value.toInt();
//                     if (index >= 0 && index < chartData.length) {
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         space: 10,
//                         child: Text(
//                           chartData[index].expanseCategory ?? '',
//                           style: TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       );
//                     }
//                     return Container();
//                   },
//                   interval: 1,
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 50,
//                   interval: 10,
//                   getTitlesWidget: (value, meta) {
//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       child: Text(
//                         '${value.toInt()}',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
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
//             gridData: FlGridData(
//               show: false,
//               drawHorizontalLine: true,
//               drawVerticalLine: false,
//               getDrawingHorizontalLine: (value) {
//                 return FlLine(
//                   color: Colors.black12,
//                   strokeWidth: 1,
//                 );
//               },
//             ),
//             borderData: FlBorderData(
//               show: true,
//               border: Border(
//                 bottom: BorderSide(color: Colors.black, width: 1),
//                 left: BorderSide(color: Colors.black, width: 1),
//                 top: BorderSide.none,
//                 right: BorderSide.none,
//               ),
//             ),
//             lineTouchData: LineTouchData(
//               touchTooltipData: LineTouchTooltipData(
//                 getTooltipColor: (touchedSpot) => Colors.blueAccent,
//               ),
//               touchCallback: (p0, p1) {},
//               handleBuiltInTouches: true,
//             ),
//           ),
//         ),
//       ).center(),
//     );
//   }
// }