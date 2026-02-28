import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final bool? showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {

    return AppBar(
       backgroundColor: Colors.transparent,  systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Use Brightness.dark if needed
    ),
       automaticallyImplyLeading: false,
       elevation: 0,
       leading: showBackButton ?? true
           ? IconButton(
               icon: const Icon(
                 Icons.arrow_back,
                 color: limeColor,
                 size: 25,
               ),
               onPressed: onBack,
             )
           : null,
       title: Text(
         title,
         style: GoogleFonts.poppins(
           fontSize: 22,
           fontWeight: FontWeight.bold,
           color: purpleColor,
         ),
       ),
     );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
