import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StackedChart6Screen extends StatefulWidget {
  @override
  StackedChart6ScreenState createState() => StackedChart6ScreenState();
}

class StackedChart6ScreenState extends State<StackedChart6Screen> {
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Half yearly Chart'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              height: 300,
              child: SfCartesianChart(
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enableDoubleTapZooming: true,
                  enablePanning: true,
                  enableSelectionZooming: true,
                  enableMouseWheelZooming: true,
                ),
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Half yearly sales analysis'),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                      dataSource: data, xValueMapper: (SalesData sales, _) => sales.year, yValueMapper: (SalesData sales, _) => sales.sales, name: 'Sales', dataLabelSettings: DataLabelSettings())
                ],
              ),
            ),
            SfSparkLineChart.custom(
              axisLineColor: seaGreen,
              color: redColor,
              trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
              marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => data[index].year,
              yValueMapper: (int index) => data[index].sales,
              dataCount: 5,
            ).paddingAll(16)
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}


// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:prokit_flutter/main/utils/AppWidget.dart';
//
// class StackedChart6Screen extends StatefulWidget {
//   @override
//   StackedChart6ScreenState createState() => StackedChart6ScreenState();
// }
//
// class StackedChart6ScreenState extends State<StackedChart6Screen> {
//   List<SalesData> data = [
//     SalesData('Jan', 35),
//     SalesData('Feb', 28),
//     SalesData('Mar', 34),
//     SalesData('Apr', 32),
//     SalesData('May', 40),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   Future<void> init() async {
//     //
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(context, 'Half yearly Chart'),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.all(16),
//               padding: EdgeInsets.only(right: 16),
//               height: 300,
//               child: LineChart(
//                 LineChartData(
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: data
//                           .asMap()
//                           .entries
//                           .map((entry) => FlSpot(
//                         entry.key.toDouble(),
//                         entry.value.sales,
//                       ))
//                           .toList(),
//                       isCurved: false,
//                       color: Colors.blue,
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(show: false),
//                     ),
//                   ],
//                   titlesData: FlTitlesData(
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: (value, meta) {
//                           if (value.toInt() >= 0 && value.toInt() < data.length) {
//                             return Text(data[value.toInt()].year);
//                           }
//                           return Text('');
//                         },
//                         interval: 1,
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         interval: 10,
//                         reservedSize: 30,
//                       ),
//                     ),
//                     topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   minY: 0,
//                   maxY: 50,
//                   gridData: FlGridData(show: false),
//                   borderData: FlBorderData(
//                       show: true,
//                       border: Border(
//                           bottom: BorderSide(color: Colors.black, width: 1),
//                           left: BorderSide(color: Colors.black, width: 1),
//                           top: BorderSide.none,
//                           right: BorderSide.none
//                       )
//                   ),
//                   lineTouchData: LineTouchData(
//                     touchTooltipData: LineTouchTooltipData(
//                       getTooltipColor: (touchedSpot) => Colors.blueAccent,
//                     ),
//                     touchCallback: (p0, p1) {},
//                     handleBuiltInTouches: true,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(16),
//               padding: EdgeInsets.only(right: 16, left: 16),
//               height: 200,
//               child: LineChart(
//                 LineChartData(
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: data
//                           .asMap()
//                           .entries
//                           .map((entry) => FlSpot(
//                         entry.key.toDouble(),
//                         entry.value.sales,
//                       ))
//                           .toList(),
//                       isCurved: false,
//                       color: Colors.red,
//                       dotData: FlDotData(show: false),
//                       belowBarData: BarAreaData(show: false),
//                     ),
//                   ],
//                   titlesData: FlTitlesData(
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: false, // Hide bottom titles
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                   ),
//                   gridData: FlGridData(show: false),
//                   borderData: FlBorderData(
//                     show: true,
//                     border: Border(
//                       bottom: BorderSide(color: Colors.black, width: 1),
//                       left: BorderSide.none,
//                       top: BorderSide.none,
//                       right: BorderSide.none,
//                     ),
//                   ),
//                   lineTouchData: LineTouchData(
//                     touchTooltipData: LineTouchTooltipData(
//                       getTooltipColor: (touchedSpot) => Colors.white,
//                     ),
//                     touchCallback: (p0, p1) {},
//                     handleBuiltInTouches: true,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SalesData {
//   SalesData(this.year, this.sales);
//
//   final String year;
//   final double sales;
// }
