import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import 'choosetopup_method_screen.dart';

class TopupAmount extends StatelessWidget {
  const TopupAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Automatically resizes when keyboard opens
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Top Up Amount",
          style: TextStyle(color: PickColor.whiteColor),
        ),
        centerTitle: true,
        backgroundColor: PickColor.brownColor,
      ),
      body: Container(
        decoration: const BoxDecoration(color: PickColor.brownColor),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  cursorColor: PickColor.whiteColor,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: PickColor.whiteColor, fontSize: 35),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '100.00',
                    hintStyle: TextStyle(color: Colors.white60),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Available balance \$948.50",
                style: TextStyle(color: PickColor.whiteColor),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: BottomButton(
          btnText: "Continue",
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChooseTopUpMethod()),
            ),
          },
        ),
      ),
    );
  }
}
