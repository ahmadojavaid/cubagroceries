import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          NotificationText.notificationHeader,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SizedBox(
              child: SvgPicture.asset(Images.ic_setting),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    NotificationText.today,
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Divider(color: PickColor.borderColor, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: PickColor.whiteColor,
                            border: Border.all(color: PickColor.greyColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(Icons.check_box_outlined, size: 20),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NotificationText.newUpdates,
                                maxLines: 4,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                NotificationText.notificationQuotes,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 8),
                              Text(
                                NotificationText.time,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: PickColor.brownColor,
                      ),
                      SizedBox(width: 15),
                      Icon(Icons.arrow_forward_ios, size: 20),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 212, 211, 211),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(3, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    Images.img_coffeCup,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NotificationText.secondHeading,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(NotificationText.secondTime, style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, size: 10, color: PickColor.brownColor),
                          SizedBox(width: 15),
                          Icon(Icons.arrow_forward_ios, size: 20),
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    NotificationText.yesterday,
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Divider(
                      color: PickColor.borderColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: PickColor.whiteColor,
                            border: Border.all(color: PickColor.greyColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(Icons.security_rounded, size: 20),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NotificationText.enableHeading,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                NotificationText.enabledes,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 8),
                              Text(
                                NotificationText.enableTime,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 212, 211, 211),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(3, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      Images.img_coffeCup,
                                      height: 40,
                                      width: 40,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NotificationText.mintyFresh,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(NotificationText.mintyFreshTime, style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    NotificationText.decDate,
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Divider(color: PickColor.borderColor, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: PickColor.whiteColor,
                            border: Border.all(color: PickColor.greyColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(Icons.payment_rounded, size: 20),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NotificationText.multiPay,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              Text(
                                NotificationText.multiPayDes,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 8),
                              Text(NotificationText.multiPayTime, style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: PickColor.whiteColor,
                            border: Border.all(color: PickColor.greyColor),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Icon(Icons.local_offer_outlined, size: 20),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NotificationText.cristmasHead,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                NotificationText.critsmasDes,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 8),
                              Text(NotificationText.critsmasTime, style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 20)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 212, 211, 211),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(3, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    Images.img_coffeCup,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                NotificationText.secondHeading,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(NotificationText.secondTime, style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, size: 10, color: PickColor.brownColor),
                          SizedBox(width: 15),
                          Icon(Icons.arrow_forward_ios, size: 20),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
