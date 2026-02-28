import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/app_textfilde.dart';
import '../../../components/rounded_text_button.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> methods = [
    {"icon": paypal, "name": "Paypal"},
    {"icon": gPay, "name": "Google Pay"},
    {"icon": aPay, "name": "Apple Pay"},
  ];

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        title: const Text("Payment"),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.sync))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payment Methods",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ).paddingLeft(10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AddNewCardScreen()),
                      );
                    },
                    child: const Text(
                      "Add New Card",
                      style: TextStyle(
                        color: stayNestPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ).paddingAll(10),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(methods.length, (index) {
              final method = methods[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.asset(method['icon'], width: 32),
                    title: Text(method['name']),
                    trailing: Radio<int>(
                      activeColor: stayNestPrimaryColor,
                      value: index,
                      groupValue: selectedIndex,
                      onChanged: (value) {
                        setState(() {
                          selectedIndex = value!;
                        });
                      },
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            RoundedTextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: "Back to profile",
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewCardScreen extends StatefulWidget {
  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();

  String cardName = '';
  String cardNumber = '';
  String cardExpiry = '';

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {
        cardName = nameController.text;
      });
    });
    numberController.addListener(() {
      setState(() {
        cardNumber = numberController.text;
      });
    });
    expiryController.addListener(() {
      setState(() {
        cardExpiry = expiryController.text;
      });
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  String getMaskedCardNumber(String number) {
    if (number.isEmpty) return '•••• •••• •••• ••••';
    return number.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ").trimRight();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Card"),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? Colors.white : Colors.black,
        ),
        backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: stayNestPrimaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 10,
                    left: 0,
                    child: Text(
                      'Mocard',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const Positioned(
                    top: 10,
                    right: 0,
                    child: Text(
                      'amazon',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: Text(
                      getMaskedCardNumber(cardNumber),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const Positioned(
                    bottom: 30,
                    left: 0,
                    child: Text(
                      'Card holder name',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    child: Text(
                      cardName.isEmpty ? '************' : cardName,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Positioned(
                    bottom: 30,
                    right: 0,
                    child: Text(
                      'Expiry date',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: Text(
                      cardExpiry.isEmpty ? '*********' : cardExpiry,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            20.height,
            CustomTextField(
              label: "Card Holder Name",
              hintText: "Daniel Austin",
              controller: nameController,
            ),
            12.height,
            CustomTextField(
              label: "Card Number",
              hintText: "6373 2728 4797 4679",
              controller: numberController,
            ),
            12.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Expiry Date",
                    hintText: "MM/YY",
                    controller: datecontroller,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                12.width,
                Expanded(
                  child: CustomTextField(
                    label: "CVV",
                    hintText: "190",
                    controller: cvvController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            35.height,
            RoundedTextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: "Add New Card",
            ),
            20.height,
          ],
        ),
      ),
    );
  }

// Future<void> _selectExpiryDate() async {
//   DateTime now = DateTime.now();
//   DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: now,
//     firstDate: now,
//     lastDate: DateTime(now.year + 10),
//     helpText: 'Select Expiry Date',
//     builder: (context, child) {
//       return Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: ColorScheme.light(
//             primary: primericalor,
//             onPrimary: Colors.white,
//             onSurface: Colors.black,
//           ),
//         ),
//         child: child!,
//       );
//     },
//   );

//   if (picked != null) {
//     String formatted =
//         "${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().substring(2)}";
//     datecontroller.text = formatted;
//   }
// }
}
