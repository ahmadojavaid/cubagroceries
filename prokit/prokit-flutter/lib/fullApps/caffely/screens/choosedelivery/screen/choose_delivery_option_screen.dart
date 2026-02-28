import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../model/choose_delivery_option_model.dart';

class ChooseDeliveryOptionScreen extends StatefulWidget {
  const ChooseDeliveryOptionScreen({super.key});

  @override
  State<ChooseDeliveryOptionScreen> createState() => _ChooseDeliveryOptionScreenState();
}

class _ChooseDeliveryOptionScreenState extends State<ChooseDeliveryOptionScreen> {
  // List of delivery options
  List<ChooseDeliveryModel> chooseDeliveryData = chooseDeliveryList();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose Delivery Option",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: ListView.builder(
          itemCount: chooseDeliveryData.length,
          itemBuilder: (context, index) {
            final option = chooseDeliveryData[index];
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: isSelected ? PickColor.brownColor : PickColor.borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              option.image,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                option.name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text('\$${option.price}'),
                            ],
                          ),
                        ],
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          color: PickColor.brownColor,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomButton(
          btnText: "Ok",
          onTap: () => {
            Navigator.pop(context, {"name": "DoorDash Drive"})
          },
        ),
      ),
    );
  }
}
