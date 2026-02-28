import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/common.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(kiviCareAppImages.userProfile),
                  ),
                ),
              ),
              SizedBox(width: 8),
              SizedBox(
                width: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    useTXTWidget(kiviCareAppString.hello, 18, FontWeight.w600),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(kiviCareAppImages.location, color: kiviCareAppColor.constWhite),
                        useTXTWidget(kiviCareAppString.address, 12, FontWeight.w500),
                        Icon(kiviCareAppImages.downArrow, color: kiviCareAppColor.constWhite),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: kiviCareAppColor.constWhite, width: 1),
            ),
            child: Center(
              child: Image.network(
                kiviCareAppImages.notificaton,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
                color: kiviCareAppColor.constWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
