import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import 'add_extra_component.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

final List<Map<String, dynamic>> milkCategory = [
  {"name": "Whole Milk", "price": "1.00"},
  {"name": "Skim Milk", "price": "0.50"},
  {"name": "Soy Milk", "price": "0.50"},
  {"name": "Almond Milk", "price": "0.50"},
];

final List<Map<String, dynamic>> syrupCategory = [
  {"name": "Aren", "price": "1.00"},
  {"name": "Caramel", "price": "1.00"},
  {"name": "Hazelnut", "price": "1.00"},
  {"name": "Pandan", "price": "1.00"},
  {"name": "Irish", "price": "1.00"},
  {"name": "Pecan", "price": "1.00"},
  {"name": "Manuka Honey", "price": "1.00"},
  {"name": "Vanilla", "price": "1.00"},
];

final List<Map<String, dynamic>> toppingCategory = [
  {"name": "Cinnamon", "price": "0.50"},
  {"name": "Nutmeg", "price": "0.50"},
  {"name": "Cocoa Powder", "price": "0.50"},
  {"name": "Crumble", "price": "0.50"},
  {"name": "Sea Salt Cream", "price": "0.50"},
  {"name": "Milk Powder", "price": "0.50"},
  {"name": "Caramel Sauce", "price": "0.50"},
];

class _CategoryListScreenState extends State<CategoryListScreen> {
  // Lists to track selected items
  List<bool> selectedMilk = List.generate(milkCategory.length, (_) => false);
  List<bool> selectedSyrup = List.generate(syrupCategory.length, (_) => false);
  List<bool> selectedTopping = List.generate(toppingCategory.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddExtraComponent(category: "Milk"),
        SizedBox(
          height: 150,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: milkCategory.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final milk = milkCategory[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(milk["name"]),
                    Row(
                      children: [
                        Text(
                          "+ \$${milk["price"]}",
                          style: const TextStyle(color: PickColor.greyColor),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedMilk[index] = !selectedMilk[index];
                            });
                          },
                          child: Icon(
                            selectedMilk[index] ? Icons.circle : Icons.circle_outlined,
                            color: PickColor.brownColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(color: PickColor.borderColor),
        const AddExtraComponent(category: "Syrup"),
        SizedBox(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: syrupCategory.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final syrup = syrupCategory[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(syrup["name"]),
                    Row(
                      children: [
                        Text(
                          "+ \$${syrup["price"]}",
                          style: const TextStyle(color: PickColor.greyColor),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSyrup[index] = !selectedSyrup[index];
                            });
                          },
                          child: Icon(
                            selectedSyrup[index] ? Icons.circle : Icons.circle_outlined,
                            color: PickColor.brownColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(color: PickColor.borderColor),
        const AddExtraComponent(category: "Topping"),
        SizedBox(
          height: 150,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: toppingCategory.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final topping = toppingCategory[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(topping["name"]),
                    Row(
                      children: [
                        Text(
                          "+ \$${topping["price"]}",
                          style: const TextStyle(color: PickColor.greyColor),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTopping[index] = !selectedTopping[index];
                            });
                          },
                          child: Icon(
                            selectedTopping[index] ? Icons.circle : Icons.circle_outlined,
                            color: PickColor.brownColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
