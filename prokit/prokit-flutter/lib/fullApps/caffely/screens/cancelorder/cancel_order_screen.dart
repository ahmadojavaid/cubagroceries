import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'component/cancel_bottom_sheet_component.dart';

class CancelOrderHomeScreen extends StatefulWidget {
  const CancelOrderHomeScreen({super.key});

  @override
  State<CancelOrderHomeScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderHomeScreen> {
  final List<String> cancelText = [
    "Change of Mind",
    "Long Wait Time",
    "Incorrect Order",
    "Sudden Urgency",
    "Unavailability",
    "Price Concerns",
    "Dietary Restrictions or Allergies",
    "Temperature Preference",
    "Unfavorable Reviews",
    "Inadequate Seating or Environment",
    "Technical Issues",
    "Others"
  ];

  // Create a list to store the selected state for each item
  List<bool>? _isSelectedList;

  @override
  void initState() {
    _isSelectedList = List.generate(cancelText.length, (index) => index == 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cancel Order",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Choose a reason for cancellation:", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: cancelText.length,
                  itemBuilder: (BuildContext context, index) {
                    final cancelItem = cancelText[index];

                    return Row(
                      children: [
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            setState(() {
                              // Toggle the selected state for the current item
                              if (_isSelectedList != null) {
                                _isSelectedList![index] = !_isSelectedList![index];
                              }
                            });
                          },
                          icon: _isSelectedList != null
                              ? _isSelectedList![index]
                                  ? const Icon(Icons.circle, color: PickColor.brownColor)
                                  : const Icon(
                                      Icons.circle_outlined,
                                      color: PickColor.brownColor,
                                    )
                              : const Icon(
                                  Icons.circle_outlined,
                                  color: PickColor.brownColor,
                                ),
                        ),
                        const SizedBox(width: 10),
                        Text(cancelItem, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: CancelBottomSheetComponent(),
          ),
        ],
      ),
    );
  }
}
