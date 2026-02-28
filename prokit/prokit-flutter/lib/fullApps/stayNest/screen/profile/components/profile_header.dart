import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onEdit;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: stayNestPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(userImage),
              ).paddingSymmetric(horizontal: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: stayNestPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ), // changed to black for contrast
                ),
              ),
            ],
          ).paddingRight(16),
        ],
      ),
    );
  }
}
