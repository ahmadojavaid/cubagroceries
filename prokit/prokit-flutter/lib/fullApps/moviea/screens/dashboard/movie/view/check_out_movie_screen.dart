import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/moviea/screens/dashboard/movie/view/view_ticket_screen.dart';

import '../../../../utils/images.dart';
import '../../view/dashboard_screen.dart';
import 'add_new_card_screen.dart';

class CheckOutMovieScreen extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String rating;

  const CheckOutMovieScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.rating,
  });

  @override
  State<CheckOutMovieScreen> createState() => _CheckOutMovieScreenState();
}

class _CheckOutMovieScreenState extends State<CheckOutMovieScreen> {
  late String _receivedImage;
  late String _receivedTitle;
  late String _receivedSubtitle;
  late String _receivedRating;

  @override
  void initState() {
    super.initState();
    _receivedImage = widget.image;
    _receivedTitle = widget.title;
    _receivedSubtitle = widget.subtitle;
    _receivedRating = widget.rating;
  }

  void _openIconButtonPressed() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const AddNewCardScreen(),
    );
  }

  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text(" Checkout", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(image: NetworkImage(_receivedImage), fit: BoxFit.cover),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _receivedTitle,
                          style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          _receivedSubtitle,
                          style: secondaryTextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ).paddingOnly(top: 10),
                        Row(
                          children: [
                            const Icon(Icons.star),
                            Text('$_receivedRating(80 Reviews)'),
                          ],
                        ).paddingOnly(top: 8),
                      ],
                    ).paddingOnly(left: 16).expand(),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16),
              Text("Payment method", style: TextStyle(fontWeight: fontWeightBoldGlobal, fontSize: 16)).paddingOnly(top: 16, left: 16),
              Row(
                children: [
                  const Row(
                    children: [
                      CircleAvatar(backgroundColor: Colors.pinkAccent, radius: 8),
                      CircleAvatar(backgroundColor: Colors.orangeAccent, radius: 8),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Master Card',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        5.height,
                        Text(
                          '5689 4700 2589 9658',
                          style: secondaryTextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ).paddingOnly(left: 16),
                  ),
                  Radio(
                    activeColor: Colors.red,
                    value: 1,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                  ),
                ],
              ).paddingOnly(left: 16, right: 16, top: 16),
              AppButton(
                elevation: 0,
                width: context.width(),
                color: Colors.white,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.red),
                ),
                onTap: () async {
                  _openIconButtonPressed();
                },
                child: Text("+ Add New card", style: boldTextStyle(size: 18, color: Colors.red), textAlign: TextAlign.start),
              ).paddingOnly(top: 16, left: 16, right: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Image(
                    image: NetworkImage(payIcon),
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  Expanded(child: const Text("Paypal").paddingOnly(left: 16)),
                  Radio(
                    activeColor: Colors.red,
                    value: 2,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                  ),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
              const Divider(
                color: Colors.black12,
              ).paddingOnly(top: 16, left: 16, right: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item Total"),
                  Text("\$310.70"),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discount"),
                  Text("\$5"),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
              const Divider(
                color: Colors.black12,
              ).paddingOnly(top: 16, left: 16, right: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Grand Total", style: boldTextStyle()),
                  Text("\$305.70", style: boldTextStyle()),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
            ],
          ).paddingOnly(top: 16),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: AppButton(
            elevation: 0,
            width: context.width(),
            color: Colors.red,
            child: Text("Pay now", style: boldTextStyle(size: 18, color: Colors.white), textAlign: TextAlign.start),
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(color: Colors.red),
            ),
            onTap: () async {
              finish(context);
              showDialog(
                context: context,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Dialog(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(fit: StackFit.expand, children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.green,
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.check_rounded, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            10.height,
                            const Text(
                              "Congratulations",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            5.height,
                            const Text(
                              "You have successfully placed order for movie ticket Enjoy the movie!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: context.width(),
                              child: AppButton(
                                elevation: 0,
                                color: Colors.red,
                                shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                onTap: () {
                                  finish(context);
                                  const ViewTicketScreen().launch(context);
                                },
                                child: Text("View E-Ticket", style: boldTextStyle(color: Colors.white)),
                              ),
                            ).paddingOnly(top: 10),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: SizedBox(
                            width: context.width(),
                            child: AppButton(
                              elevation: 0,
                              color: Colors.white,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(color: Colors.red),
                              ),
                              onTap: () {
                                finish(context);
                                const DashboardScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                              },
                              child: Text("Go to Home", style: boldTextStyle(color: Colors.red)),
                            ),
                          ),
                        ),
                      ]).paddingAll(16),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
