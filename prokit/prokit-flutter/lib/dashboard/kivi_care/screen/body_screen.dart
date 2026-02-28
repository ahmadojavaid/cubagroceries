import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_care/component/appointment_component.dart';
import 'package:prokit_flutter/dashboard/kivi_care/component/categoty_cards_component.dart';
import 'package:prokit_flutter/dashboard/kivi_care/component/offer_card_component.dart';
import 'package:prokit_flutter/dashboard/kivi_care/component/popular_service_component.dart';
import 'package:prokit_flutter/dashboard/kivi_care/component/search_bar_component.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';


class BodyContainer extends StatefulWidget {
  const BodyContainer({super.key});

  @override
  State<BodyContainer> createState() => _BodyContainerState();
}

class _BodyContainerState extends State<BodyContainer> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            color: kiviCareAppColor.containerColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ServiceSearchBar(),
                SizedBox(height: 40),
                CategotyCards(),
                SizedBox(height: 40),
                OfferCard(),
                SizedBox(height: 40),
                AppointmentCard(),
                SizedBox(height: 40),
                PopularService(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
