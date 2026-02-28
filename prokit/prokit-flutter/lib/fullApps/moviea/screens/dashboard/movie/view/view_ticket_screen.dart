import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_bar_code/qr/qr.dart';

class ViewTicketScreen extends StatefulWidget {
  const ViewTicketScreen({super.key});

  @override
  State<ViewTicketScreen> createState() => _ViewTicketScreenState();
}

class _ViewTicketScreenState extends State<ViewTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: Text("View Ticket", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: ClipPath(
        clipper: SideCurveWidget(),
        child: Container(
          decoration: boxDecorationDefault(
            color: context.cardColor,
            boxShadow: [
              const BoxShadow(color: Colors.transparent),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Scan This QR", style: boldTextStyle(size: 18, color: Colors.black)).paddingOnly(top: 16),
              const Text("Point this qr to the scan place").paddingOnly(top: 10),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: QRCode(data: "Congratulations successfully your Booking"),
                ),
              ),
              const SizedBox(height: 55),
              Center(
                child: Row(
                  children: List.generate(
                    350 ~/ 10,
                    (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.grey.shade300 : Colors.transparent,
                        height: 2,
                      ),
                    ),
                  ),
                ).paddingSymmetric(horizontal: 16),
              ),
              const SizedBox(height: 30),
              Text("Move X980IU6543", style: boldTextStyle(size: 18, color: Colors.black)),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Full Name"),
                  Text("Time"),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mark Willions", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("9:30 AM", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date"),
                  Text("Seat"),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("May02,2024", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("F15,F16", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ).paddingOnly(top: 16, left: 16, right: 16),
            ],
          ).paddingOnly(top: 16),
        ).paddingAll(16),
      ),
    );
  }
}

class SideCurveWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 50;

    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, (size.height - curveHeight) / 2);
    path.quadraticBezierTo(size.width * 0.2, size.height / 2, 0, (size.height + curveHeight) / 2);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, (size.height + curveHeight) / 2);
    path.quadraticBezierTo(size.width * 0.8, size.height / 2, size.width, (size.height - curveHeight) / 2);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
