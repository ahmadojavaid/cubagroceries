import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/common.dart';


class ServiceSearchBar extends StatelessWidget {
  const ServiceSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 32, right: 20),
      child: Container(
        height: 52,
        width: 380,
        decoration: BoxDecoration(
          color: kiviCareAppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(kiviCareAppImages.searchIcon, size: 16,color: kiviCareAppColor.fadeText),
                      SizedBox(width: 8),
                      txtWidget(
                        "eg. “doctors, service, clinics”",
                        12,
                        FontWeight.w400,
                        kiviCareAppColor.fadeText,
                      ),
                    ],
                  ),
                ),
                Icon(kiviCareAppImages.microphone, size: 16,color: kiviCareAppColor.fadeText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
