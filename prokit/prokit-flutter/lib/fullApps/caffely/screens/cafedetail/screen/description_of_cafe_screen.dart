import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class DescriptionOfCafeScreen extends StatelessWidget {
  const DescriptionOfCafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              CafeDetailText.caffelyAstoriaAromas,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            const Text(
              CafeDescriptionText.about,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            const Text(
              CafeDescriptionText.descriptionText,
              style: TextStyle(fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 25),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    CafeDescriptionText.firstDay,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        CafeDescriptionText.colon,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        CafeDescriptionText.firstTime,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Expanded(
                  child: Text(
                    CafeDescriptionText.secondDay,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        CafeDescriptionText.colon,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        CafeDescriptionText.secondTime,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              CafeDescriptionText.addressHeader,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.location_on_sharp, color: Color.fromARGB(255, 105, 48, 27)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    CafeDescriptionText.addressDetail,
                    style: TextStyle(color: Color.fromARGB(255, 94, 93, 93)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              width: 600,
              height: 200,
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(Images.img_googleMap, fit: BoxFit.cover),
              ),
            )
          ],
        ),
      ),
    );
  }
}
