import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/weather/screens/home_screeen.dart';
import 'package:prokit_flutter/dashboard/weather/utils/custom_painter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(-30),
                topRight: Radius.circular(-30),
              ),
              child: CustomPaint(
                painter: CustomNavBarPainter(
                  topCurveDepth: 40,
                  topCurveWidthFactor: 1,
                  bottomBumpHeight: 98,
                  bottomBumpWidthFactor: 0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: weatherAppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: weatherAppColors.white60,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.add, size: 32, color: Color(0xFF5F60B9)),
              ),
            ),
          ),
          // Side Icons
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Image.network( weatherAppImages.joystic, height: 24, width: 24,color: weatherAppColors.white,),//TODO: Change it to Image.network
                  Icon(
                    weatherAppImages.menu,
                    color: weatherAppColors.white,
                  ), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
