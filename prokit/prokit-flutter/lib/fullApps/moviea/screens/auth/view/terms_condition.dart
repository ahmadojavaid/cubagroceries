import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TermAndConditionScreen extends StatefulWidget {
  const TermAndConditionScreen({super.key});

  @override
  State<TermAndConditionScreen> createState() => _TermAndConditionScreenState();
}

class _TermAndConditionScreenState extends State<TermAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: Text("Term & Condition", style: boldTextStyle(size: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Last update: 17/2/2023",
            style: TextStyle(color: Colors.black54),
          ),
          const Text("Please read these terms of service, carefully before using our app operated by us.").paddingOnly(top: 16),
          const Text(
            "Conditions of Uses",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ).paddingOnly(top: 16),
          const Text("Bigtree facilitates booking of Services on the Ticketing Platform on behalf of cinemas and does not control the inventory or its availability and pricing.").paddingOnly(top: 16),
          const Text(
              "Convenience Fee charged on your transactions for the movie tickets booked on our  application is levied by BookMyShow. The said fee is for providing you with a wide range of choices to book movie tickets with convenient modes of payment in advance for the shows desired to be attended by you and thus avoiding you the hassles of travelling to the cinema/venue in advance to book the desired seats for the shows, which prevents disappointment in having to settle for seats which are not preferred."),
          const Text(
              "If you do not receive a confirmation number (in the form of a confirmation page or email) after submitting payment information, or if you experience an error message or service interruption after submitting payment information, it is your responsibility to confirm the same from your booking history on the 'Your orders' tab in your  account, . Please refer to the  terms of service above for further details.")
        ],
      ).paddingAll(16),
    );
  }
}
