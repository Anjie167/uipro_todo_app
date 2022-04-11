import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem({required this.title, required this.icon});
}

class DrawerItems {
  static final categorise =
      DrawerItem(title: "Categorise", icon: Icons.grid_view_outlined);
  static final analytics =
      DrawerItem(title: "Tasks", icon: FontAwesomeIcons.list);
  static final about =
      DrawerItem(title: "Profile", icon: Icons.person_outlined);

  static final List<DrawerItem> all = [categorise, analytics,about];
}
