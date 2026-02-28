import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class Service {
  final String name;
  final double price;
  bool selected;

  Service({required this.name, required this.price, this.selected = false});
}

class SelectServiceSection extends StatefulWidget {
  const SelectServiceSection({super.key});

  @override
  State<SelectServiceSection> createState() => _SelectServiceSectionState();
}

class _SelectServiceSectionState extends State<SelectServiceSection> {
  bool isExpanded = false;

  List<Service> services = [
    Service(name: 'Beard Trim', price: 50.0),
    Service(name: 'Men\'s Haircut', price: 400.0),
    Service(name: 'Buzz Cut', price: 2000.0),
    Service(name: 'Fade Cut', price: 100.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: frezlaAppColor.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: frezlaAppColor.black.withAlpha((0.05 * 255).toInt()),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                txtWidget(
                  "Service",
                  12,
                  FontWeight.w500,
                  frezlaAppColor.dateTxtColor,
                ),
                iconWidget(
                  isExpanded
                      ? frezkaAppImages.upArrow
                      : frezkaAppImages.downArrow,
                  16,
                  frezlaAppColor.dateTxtColor,
                ),
              ],
            ),
          ),
          if (isExpanded) const SizedBox(height: 10),
          if (isExpanded)
            Column(
              children: services.map((service) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: service.selected,
                          onChanged: (val) {
                            setState(() {
                              service.selected = val ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: txtWidget(
                            service.name,
                            14,
                            FontWeight.w500,
                            frezlaAppColor.headLineColor,
                          ),
                        ),
                        txtWidget(
                          '\$${service.price.toStringAsFixed(2)}',
                          16,
                          FontWeight.w500,
                          frezlaAppColor.priceTxtColor,
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          if (isExpanded)
            Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: frezlaAppColor.priceTxtColor,
                  side: BorderSide(color: frezlaAppColor.priceTxtColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("View All"),
              ),
            ),
        ],
      ),
    );
  }
}
