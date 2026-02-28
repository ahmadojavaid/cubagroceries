import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/card_detail/view/payment_success_screen.dart';

import '../../../../../main.dart';
import '../../../components/rounded_text_button.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../components/date_select_components/guest_selection_bottom_sheet.dart';
import 'add_to_card_screen.dart';

enum PaymentType { full, partial }

class ConfirmPayScreen extends StatefulWidget {
  final int hotelid;
  final int adults;
  final double? totalprice;
  final int children;
  final int totaldays;

  const ConfirmPayScreen({
    super.key,
    required this.hotelid,
    required this.adults,
    required this.children,
    this.totalprice,
    required this.totaldays,
  });

  @override
  State<ConfirmPayScreen> createState() => _ConfirmPayScreenState();
}

class _ConfirmPayScreenState extends State<ConfirmPayScreen> {
  PaymentType selectedPaymentType = PaymentType.full;
  String paymentMethod = 'Visa';

  double get totalPrice => 360.0 - 50.0 + 10.0;

  void setPaymentType(PaymentType? type) {
    if (type != null) {
      setState(() {
        selectedPaymentType = type;
      });
    }
  }

  void setPaymentMethod(String method) {
    setState(() {
      paymentMethod = method;
    });
  }

  // ignore: non_constant_identifier_names
  bool save = false;

  void savedata() {
    setState(() {
      save = !save;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        title: Text("Confirm & Pay"),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            roomimage1,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        12.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Royale President", style: TextStyle()),
                                ],
                              ),
                              Text("Paris, France", style: TextStyle()),
                              6.height,
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.orange,
                                  ),
                                  4.width,
                                  Text("4.8", style: secondaryTextStyle()),
                                  4.width,
                                  Text(
                                    "(4,981 reviews)",
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        8.width,
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " \$29 ",
                                  style: boldTextStyle(color: stayNestPrimaryColor),
                                ),
                                Text(
                                  "/nigth",
                                  style: boldTextStyle(color: stayNestPrimaryColor),
                                ),
                              ],
                            ),
                            6.height,
                            IconButton(
                              color: save == true ? stayNestPrimaryColor : gray,
                              icon: Icon(
                                save == true ? Icons.bookmark : Icons.bookmark_border,
                              ),
                              onPressed: () => savedata(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                16.height,
                Text("Your Booking Details", style: primaryTextStyle()),
                8.height,
                _detailRow(
                  context,
                  "Dates",
                  "May 06, 2023 - May 08, 2023",
                  Icons.edit,
                  onTap: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDateRange: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(Duration(days: 2)),
                      ),
                      builder: (context, child) {
                        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: stayNestPrimaryColor,
                              onPrimary: Colors.white,
                              onSurface: isDarkMode ? Colors.white : Colors.black,
                              surface: isDarkMode ? Colors.grey[850]! : Colors.white,
                            ),
                            dialogBackgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
                            datePickerTheme: DatePickerThemeData(
                              rangeSelectionBackgroundColor: Colors.blue.withOpacity(0.2),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      toast(
                        "Selected: ${picked.start.toString().split(" ")[0]} - ${picked.end.toString().split(" ")[0]}",
                      );
                    }
                  },
                ),
                _detailRow(
                  context,
                  "Guests",
                  "2 adults | 1 children",
                  Icons.edit,
                  onTap: () async {
                    showGuestSelectionBottomSheet(context, widget.hotelid);
                  },
                ),
                16.height,
                Text("Choose how to pay", style: primaryTextStyle()),
              ],
            ).paddingSymmetric(horizontal: 16),
            Column(
              children: [
                RadioListTile<PaymentType>(
                  activeColor: stayNestPrimaryColor,
                  value: PaymentType.full,
                  groupValue: selectedPaymentType,
                  onChanged: setPaymentType,
                  title: Text("Pay in full", style: primaryTextStyle()),
                  subtitle: Text(
                    "Pay the total now and you're all set.",
                    style: secondaryTextStyle(),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile<PaymentType>(
                  activeColor: stayNestPrimaryColor,
                  value: PaymentType.partial,
                  groupValue: selectedPaymentType,
                  onChanged: setPaymentType,
                  title: Text(
                    "Pay part now, part later",
                    style: primaryTextStyle(),
                  ),
                  subtitle: Text(
                    "Pay part now and you're all set.",
                    style: secondaryTextStyle(),
                  ),
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pay with", style: primaryTextStyle()),
                    ElevatedButton(
                      onPressed: () {
                        showAddCardBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appStore.isDarkModeOn ? const Color.fromARGB(255, 35, 35, 35) : Colors.white,
                        foregroundColor: stayNestPrimaryColor,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        side: BorderSide(
                          color: appStore.isDarkModeOn ? stayNestPrimaryColor : stayNestPrimaryColor,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: stayNestPrimaryColor),
                      ),
                    ),
                  ],
                ),
                Observer(
                  builder: (_) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            _paymentIcon(visa),
                            _paymentIcon(masterCard),
                            _paymentIcon(paypal),
                            _paymentIcon(gPay),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                16.height,
                Divider(color: const Color.fromARGB(255, 222, 221, 221)),
                Text("Price Details", style: primaryTextStyle()),
                _priceRow("120 x 3 nights", "\$360.00"),
                _priceRow("Discount", "-\$50.00", isDiscount: true),
                _priceRow("Occupancy taxes and fees", "\$10.00"),
                Divider(color: const Color.fromARGB(255, 222, 221, 221)),
                Observer(
                  builder: (_) => _priceRow(
                    "Grand Total",
                    "\$${totalPrice.toStringAsFixed(2)}",
                    isTotal: true,
                  ),
                ),
                16.height,
                RoundedTextButton(
                  text: 'Pay Now',
                  onPressed: () {
                    showPaymentSuccessDialog(context);
                  },
                ),
                50.height,
              ],
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }

  void showAddCardBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) => const AddNewCardBottomSheet(),
    );
  }

  Widget _detailRow(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: primaryTextStyle()),
      subtitle: Text(subtitle, style: secondaryTextStyle()),
      trailing: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: stayNestPrimaryColor, width: 1),
        ),
        child: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.edit,
            color: stayNestPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget _paymentIcon(String label) {
    return Card(child: Image.asset(label, height: 35, width: 35).paddingAll(3));
  }

  Widget _priceRow(
    String label,
    String amount, {
    bool isTotal = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal ? primaryTextStyle(weight: FontWeight.bold) : secondaryTextStyle(),
          ),
          Text(
            amount,
            style: isTotal
                ? primaryTextStyle(weight: FontWeight.bold)
                : secondaryTextStyle(
                    color: isDiscount ? stayNestPrimaryColor : null,
                  ),
          ),
        ],
      ),
    );
  }
}
