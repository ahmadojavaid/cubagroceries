import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/comman.dart';
import '../../../utils/constant.dart';
import '../../home/screen/home_page_screen.dart';
import '../components/show_dialogbox_component.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPasswordScreen> {
  bool passwordVisible = true;
  bool confirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Stack(children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          SignInText.createNewPassword,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        const Text(SignInText.createNewForget),
                        const SizedBox(height: 24),
                        const Text(SignInText.newPassword),
                        const SizedBox(height: 5),
                        TextField(
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, size: 20),
                            fillColor: PickColor.textFeildColor,
                            filled: true,
                            border: InputBorder.none,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: PickColor.blackTransparent),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            suffixIcon: IconButton(
                              iconSize: 20,
                              icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(SignInText.confirmPassword),
                        const SizedBox(height: 5),
                        TextField(
                          obscureText: confirmPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, size: 20),
                            fillColor: PickColor.textFeildColor,
                            filled: true,
                            border: InputBorder.none,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: PickColor.blackTransparent),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: PickColor.blackTransparent),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            suffixIcon: IconButton(
                              iconSize: 20,
                              icon: Icon(confirmPassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  confirmPassword = !confirmPassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: BottomButton(
            btnText: "Continue",
            onTap: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  Future.delayed(const Duration(seconds: 4), () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePageScreen()),
                    );
                  });
                  return const ShowDialogBoxComponent();
                },
              )
            },
          ),
        )
      ]),
    );
  }
}
