

import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';

class NearLabsModel {
  String labName;
  String labAddress;
  String labLogo;
  String email;
  String labeType;
  String contact;

  NearLabsModel({
    required this.labName,
    required this.labAddress,
    required this.labLogo,
    required this.email,
    required this.labeType,
    required this.contact,
  });
}

List<NearLabsModel> nearLabs = [
  NearLabsModel(
    labName: "HealthQuest Diagnostics",
    labAddress: "Sydney, Australia",
    labLogo: kiviLabAppImages.logo1,
    email: "info@healthquestdiagnostics.com",
    labeType: "Biochemistry",
    contact: "+127 555 0199 891",
  ),
  NearLabsModel(
    labName: "VitalCheck Labs",
    labAddress: "Sydney, Australia",
    labLogo: kiviLabAppImages.logo2,
    email: "info@healthquestdiagnostics.com",
    labeType: "Immunology",
    contact: "+128 666 0200 892",
  ),
];
