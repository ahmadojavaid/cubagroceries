import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/weather/model/temprature_model.dart';
import 'package:prokit_flutter/dashboard/weather/screens/home_screeen.dart';
import 'package:prokit_flutter/dashboard/weather/utils/common.dart';


class ForecastCardList extends StatefulWidget {
  const ForecastCardList({super.key});

  @override
  State<ForecastCardList> createState() => _ForecastCardListState();
}

class _ForecastCardListState extends State<ForecastCardList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 146,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: weatherItems.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = weatherItems[index];
          final isSelected = index == _selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: _buildCard(item, isSelected),
          );
        },
      ),
    );
  }
  Widget _buildCard(WeatherItem item, bool isSelected) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 60,
          height: 146,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: isSelected
                  ? [weatherAppColors.selectedGrad1, weatherAppColors.selectedGrad2]
                  : [
                     weatherAppColors.notSelectedGrad1,
                     weatherAppColors.notSelectedGrad2,
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(
              color: weatherAppColors.white.withAlpha((0.2 * 255).toInt()),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: weatherAppColors.black.withAlpha((0.25 * 255).toInt()),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txtWidget(item.time, 15, FontWeight.w600, weatherAppColors.white),
              Image.network(
                item.icon,
                height: 40,
                width: 40,
              ),
              if (item.rain.isNotEmpty)
                txtWidget(
                  item.rain,
                  13,
                  FontWeight.w600,
                  weatherAppColors.rainPossibility,
                ),
              txtWidget(item.temp, 20, FontWeight.w400, weatherAppColors.white),
            ],
          ),
        ),
      ),
    );
  }
}
