import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/progress_card.dart';
import '../../../component/step_card.dart';
import '../../../component/steps_chart.dart';
import '../../../resources/bottom_navigation.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';

class ProgreesScreen extends StatefulWidget {
  const ProgreesScreen({super.key});

  @override
  State<ProgreesScreen> createState() => _ProgreesScreenState();
}

class _ProgreesScreenState extends State<ProgreesScreen> {
  DateTime _selectedDay = DateTime.now();

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  String selectedMonth = 'January';
  bool showWorkoutLog = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Progress Tracking",
        onBack: () {
          CustomBottomNavigation().launch(context, isNewTask: true);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Madison', style: boldTextStyle(size: 28, color: Colors.white)).paddingOnly(left: 16),
                          4.width,
                          const Icon(Icons.female, color: Colors.yellow, size: 20),
                        ],
                      ),
                      Text('Age: 28', style: secondaryTextStyle(color: Colors.white70, size: 20)).paddingOnly(left: 16),
                      16.height,
                      Row(
                        children: [
                          _buildStatCard('75 Kg', 'Weight'),
                          40.width,
                          _buildStatCard('1.65 CM', 'Height'),
                        ],
                      ).paddingOnly(left: 16),
                    ],
                  ).expand(),
                  const CircleAvatar(
                    radius: 60,
                    //TODO:
                    backgroundImage: AssetImage(profile),
                  ).paddingRight(16),
                ],
              ),
            ),
            16.height,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showWorkoutLog = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: showWorkoutLog ? white : buttonColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text('Workout Log', style: boldTextStyle(color: showWorkoutLog ? purpleColor : Colors.white)),
                      ),
                    ),
                  ),
                ),
                15.width,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showWorkoutLog = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: !showWorkoutLog ? white : buttonColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text('Charts', style: boldTextStyle(color: !showWorkoutLog ? purpleColor : Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
            showWorkoutLog ? buildWorkoutLog() : buildCharts(),
            16.height,
          ],
        ).paddingSymmetric(horizontal: 5),
      ),
    );
  }

  String formatDateWithOrdinal(DateTime date) {
    String day = DateFormat('d').format(date);
    String suffix = 'th';

    if (day.endsWith('1') && day != '11') {
      suffix = 'st';
    } else if (day.endsWith('2') && day != '12') {
      suffix = 'nd';
    } else if (day.endsWith('3') && day != '13') {
      suffix = 'rd';
    }

    return '${DateFormat('MMMM').format(date)} $day$suffix';
  }

  Widget buildCharts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.height,
        Text(
          "My Progress",
          style: boldTextStyle(size: 20, color: limeColor),
        ),
        // 5.height,
        Text(
          formatDateWithOrdinal(_selectedDay),
          style: boldTextStyle(
            size: 22,
            color: Colors.lime,
          ),
        ),
        5.height,
        StepsChart(),
        Column(
          children: [
            StepsCard(day: 'Thu', date: '14', steps: '3,679', duration: '1hr 40m'),
            16.height,
            StepsCard(day: 'Wed', date: '20', steps: '5,789', duration: '1hr 20m'),
            16.height,
            StepsCard(day: 'Sat', date: '22', steps: '1,859', duration: '1hr 10m'),
          ],
        ).paddingOnly(top: 16)
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget buildWorkoutLog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Divider(
          color: white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Choose Date', style: boldTextStyle(color: limeColor, size: 16)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  dropdownColor: Colors.black,
                  value: selectedMonth,
                  items: months
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e, style: primaryTextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value as String;
                      int monthIndex = months.indexOf(selectedMonth) + 1;
                      _selectedDay = DateTime(_selectedDay.year, monthIndex, _selectedDay.day);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: white,
        ),
        16.height,
        Container(
          padding: EdgeInsets.all(15),
          decoration: boxDecorationWithRoundedCorners(backgroundColor: buttonColor, borderRadius: BorderRadius.circular(20)),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            headerVisible: false,
            calendarStyle: CalendarStyle(
              todayTextStyle: primaryTextStyle(color: primaryColor),
              selectedTextStyle: primaryTextStyle(color: Colors.black),
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: primaryColor),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: limeColor,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: primaryTextStyle(color: primaryColor),
              weekendTextStyle: primaryTextStyle(color: primaryColor),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: boldTextStyle(color: primaryColor),
              weekendStyle: boldTextStyle(color: primaryColor),
            ),
          ),
        ),
        12.height,
        Text(
          "Activites",
          style: boldTextStyle(size: 18, color: limeColor),
        ),
        10.height,
        ProgressCard(
          icon: runningIcon,
          kcal: '120 Kcal',
          title: 'Upper Body Workout',
          date: 'June 09',
          duration: '25 Mins',
        ),
        10.height,
        ProgressCard(
          icon: runningIcon,
          kcal: '120 Kcal',
          title: 'Upper Body Workout',
          date: 'June 09',
          duration: '25 Mins',
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  Widget _buildStatCard(String value, String label) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 40,
          decoration: BoxDecoration(
            color: limeColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        6.width,
        Column(
          children: [
            Text(value, style: boldTextStyle(color: Colors.white, size: 16)),
            Text(label, style: secondaryTextStyle(color: Colors.white70, size: 16)),
          ],
        )
      ],
    );
  }
}
