import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class GenderCard extends StatelessWidget {
  final String imagePath;
  final String gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    required this.imagePath,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: width * 0.35,
                height: height * 0.24,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : null,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[400]!,
                    width: 2,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                //TODO:
                child: Image.network(
                  imagePath,
                  width: width * 0.38,
                  height: height * 0.24,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.05),
          Text(
            gender,
            style: boldTextStyle(color: isSelected ? Colors.white : grey, size: 20),
          ),
        ],
      ),
    );
  }
}
