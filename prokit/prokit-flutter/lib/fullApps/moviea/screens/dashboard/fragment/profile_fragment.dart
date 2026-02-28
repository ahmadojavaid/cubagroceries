import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/images.dart';
import '../../auth/view/edit_profile_screen.dart';
import '../../auth/view/privacy_policy.dart';
import '../../auth/view/sign_in.dart';
import '../../auth/view/terms_condition.dart';
import '../movie/view/view_ticket_screen.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                  ),
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        userImg,
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          const EditProfileScreen().launch(context);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(top: 16),
                const Text('Mark Willions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)).paddingOnly(top: 10),
                const Text(
                  '(405) 555-0128',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ).paddingOnly(top: 10),
                ListTile(
                  leading: const Icon(Icons.airplane_ticket_outlined),
                  title: const Text("My Tickets"),
                  trailing: IconButton(
                    onPressed: () {
                      const ViewTicketScreen().launch(context);
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                ).paddingSymmetric(horizontal: 16),
                ListTile(
                  leading: const Icon(Icons.lock_open_outlined),
                  title: const Text("change password"),
                  trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.navigate_next)),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                ).paddingSymmetric(horizontal: 16),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text("Privacy Policy"),
                  trailing: IconButton(
                    onPressed: () {
                      const PrivacyAndPolicyScreen().launch(context);
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ),
                const Divider(
                  height: 1,
                  color: Colors.black12,
                ).paddingSymmetric(horizontal: 16),
                ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: const Text("Terms & Conditions"),
                  trailing: IconButton(
                    onPressed: () {
                      const TermAndConditionScreen().launch(context);
                    },
                    icon: const Icon(Icons.navigate_next),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: AppButton(
                width: context.width(),
                color: Colors.red,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onTap: () async {
                  const SignInPageScreen().launch(
                    context,
                    pageRouteAnimation: PageRouteAnimation.Fade,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: NetworkImage(logoutIcon),
                      color: Colors.white,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Logout",
                        style: boldTextStyle(size: 18, color: Colors.white),
                        textAlign: TextAlign.start,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
