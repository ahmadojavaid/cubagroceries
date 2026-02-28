import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountListComponent extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const AccountListComponent({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTap, // Call the onTap callback
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(image, width: 20, height: 20),
                // Image.asset(image,width: 20,height: 20,),
                const SizedBox(width: 15),
                Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 15),
          ],
        ),
      ),
    );
  }
}
