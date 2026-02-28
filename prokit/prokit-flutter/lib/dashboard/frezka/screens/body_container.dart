import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/frezka/components/book_now_btn_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/categories_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/date_picker_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/expert_list_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/makup_list_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/membership_card_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/nail_list_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/near_shop_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/packages_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/service_picker_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/slider_page_component.dart';
import 'package:prokit_flutter/dashboard/frezka/components/time_pick_component.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class BodyContainer extends StatefulWidget {
  const BodyContainer({super.key});

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}
class _BodyContainerState extends State<BodyContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        MembershipCard(),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: txtWidget(
            "Quick Book appointment",
            18,
            FontWeight.w500,
            frezlaAppColor.headLineColor,
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(child: DatePickerContainer()),
              SizedBox(width: 16),
              Expanded(child: TimePickerField()),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SelectServiceSection(),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BookNowBtn(),
        ),
        SizedBox(height: 40),
        PackageCards(),
        SizedBox(height: 40),
        Categories(),
        SizedBox(height: 40),
        FancyImageCarousel(),
        SizedBox(height: 40),
        ExpertsTabs(),
        SizedBox(height: 40),
        BestOfNails(),
        SizedBox(height: 40),
        MakupList(),
        SizedBox(height: 40),
        NearShop(),
        SizedBox(height: 40),
      ],
    );
  }
}
