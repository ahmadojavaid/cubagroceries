import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../../main.dart';
import '../../../utils/colors.dart';
import 'customer_service_screen.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> with TickerProviderStateMixin {
  late TabController _tabController;
  List<String> listFAQ = [
    'General',
    'Account',
    'Service',
    'Payment',
    'Privacy',
    'Favorites'
  ];
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  final List<Map<String, dynamic>> supportOptions = [
    {'title': 'Customer Service', 'icon': Icons.headset_mic},
    {'title': 'WhatsApp', 'icon': FontAwesomeIcons.whatsapp},
    {'title': 'Website', 'icon': Icons.language},
    {'title': 'Facebook', 'icon': Icons.facebook},
    {'title': 'Twitter', 'icon': FontAwesomeIcons.twitter},
    {
      'title': 'Instagram',
      'icon': Icons.camera_alt
    }, // Use real Instagram icon if available
  ];

  List<Map<String, dynamic>> faqs = [
    {
      "question": "What is Reasa?",
      "answer":
          "Reasa is a mobile real estate application that helps users search, filter, and explore property listings such as houses, villas, and apartments. It offers a modern UI and powerful features to enhance the property browsing experience",
      "expanded": true,
    },
    {
      "question": "How to make a payment?",
      "answer":
          "To make a payment in a real estate app like Reasa, you'd typically follow these general steps. Since your app is custom, I'll outline a Flutter-based payment flow, and then suggest what to include in the UI and backend",
      "expanded": true
    },
    {
      "question": "How do I can cancel booking?",
      "answer": "",
      "expanded": false
    },
    {
      "question": "How do I can delete my account?",
      "answer": "",
      "expanded": false
    },
    {"question": "How do I exit the app?", "answer": "", "expanded": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: AppBar(
        title: Text('Help Center'),
        leading: GestureDetector(
            onTap: () => finish(context),
            child: Icon(
              Icons.arrow_back,
              color: appStore.isDarkModeOn ? lightColor : darkColor,
            )),
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
        bottom: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide:
                BorderSide(width: 3, color: primaryBlueColor, strokeAlign: 50),
            insets: EdgeInsets.symmetric(horizontal: 100),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          labelColor: primaryBlueColor,
          unselectedLabelColor: appStore.isDarkModeOn ? lightColor : darkColor,
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: 'FAQ'),
            Tab(text: 'Contact us'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            children: [
              20.height,
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listFAQ.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedIndex = index;
                      }),
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: primaryBlueColor),
                          ),
                          elevation: 0,
                          color: selectedIndex == index
                              ? primaryBlueColor
                              : appStore.isDarkModeOn
                                  ? darkColor
                                  : lightColor,
                          child: Center(
                            child: Text(
                              listFAQ[index],
                              style: TextStyle(
                                color: selectedIndex == index
                                    ? lightColor
                                    : primaryBlueColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ).paddingOnly(
                        left: index == 0 ? 16 : 0,
                        right: index == listFAQ.length - 1 ? 16 : 0);
                  },
                ),
              ),
              16.height,
              AppTextField(
                controller: searchController,
                keyboardType: TextInputType.text,
                textFieldType: TextFieldType.OTHER,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.sort),
                  ),
                  suffixIconColor: hintTextColor,
                  hintText: "Search",
                  filled: true,
                  fillColor: appStore.isDarkModeOn
                      ? inputFillColorDart
                      : inputFillColorlight,
                  hintStyle: const TextStyle(color: hintTextColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ).paddingSymmetric(horizontal: 16),
              5.height,
              Expanded(child: SizedBox(child: faqTab())),
            ],
          ),
          AnimatedListView(
            itemCount: supportOptions.length,
            itemBuilder: (context, index) {
              var data = supportOptions[index];
              return Card(
                elevation: 0,
                color: appStore.isDarkModeOn
                    ? inputFillColorDart
                    : inputFillColorlight,
                child: ListTile(
                  onTap: index == 0
                      ? () => CustomerServiceScreen().launch(
                            context,
                          )
                      : () {},
                  leading: Icon(
                    data['icon'],
                    color: primaryBlueColor,
                  ),
                  title: Text(data['title']),
                ).paddingAll(8),
              ).paddingOnly(
                  top: index == 0 ? 16 : 8, left: 16, right: 16, bottom: 8);
            },
          )
        ],
      ),
    );
  }

  Widget faqTab() {
    return AnimatedListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        var data = faqs[index];
        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            unselectedWidgetColor: Colors.white,
          ),
          child: Card(
            color: appStore.isDarkModeOn
                ? inputFillColorDart
                : inputFillColorlight,
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              initiallyExpanded: data["expanded"],
              onExpansionChanged: (val) {
                setState(() {
                  data["expanded"] = val;
                });
              },
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              collapsedIconColor: Theme.of(context).primaryColor,
              iconColor: Theme.of(context).primaryColor,
              title: Text(
                data["question"],
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              children: [
                if (data["answer"].toString().isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      data["answer"],
                    ),
                  )
              ],
            ),
          ),
        ).paddingOnly(bottom: index == faqs.length - 1 ? 50 : 0);
      },
    );
  }
}
