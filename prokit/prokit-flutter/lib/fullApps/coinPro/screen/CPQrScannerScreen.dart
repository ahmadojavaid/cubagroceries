import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/coinPro/utils/CPColors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CPQrScannerScreen extends StatefulWidget {
  @override
  CPQrScannerScreenState createState() => CPQrScannerScreenState();
}

class CPQrScannerScreenState extends State<CPQrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
              }
            },
          ),
      Column(
        children: [
          30.height,
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ).onTap(() {
              finish(context);
            }).paddingOnly(top: 8, right: 16),
          ),
          30.height,
          Text('Hold your Card inside the frame', style: boldTextStyle(color: Colors.white, size: 18)),
        ],
      ),
      Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green.shade400, width: 2),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(borderRadius: radius(30), backgroundColor: Colors.white),
          child: Icon(Icons.close, color: CPPrimaryColor),
        ).onTap(() {
          finish(context);
        }),
      ).paddingBottom(60),
        ],
      ),
    );
  }
}
