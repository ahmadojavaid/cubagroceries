import 'package:flutter/material.dart';

import 'globe_of_logos_component.dart';
import 'icon_helper.dart';

class TechStackCloudComponent extends StatelessWidget {
  final List<String> slugs = [
    "typescript",
    "javascript",
    "dart",
    "java",
    "react",
    "flutter",
    "android",
    "html5",
    "css3",
    "nodedotjs",
    "express",
    "nextdotjs",
    "prisma",
    "amazonaws",
    "postgresql",
    "firebase",
    "nginx",
    "vercel",
    "testinglibrary",
    "jest",
    "cypress",
    "docker",
    "git",
    "jira",
    "github",
    "gitlab",
    "visualstudiocode",
    "androidstudio",
    "sonarqube",
    "figma",
  ];

  TechStackCloudComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get icons using the helper
    final icons = TechStackIcons.getIconsFromSlugs(slugs);

    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(16),
        ),
        child: GlobeOfLogosComponent(
          icons: icons,
          radius: 120,
          defaultIconColor: Colors.white70,
        ),
      ),
    );
  }
}
