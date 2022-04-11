import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/theme.dart';


class ChangeThemeButton extends StatefulWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  State<ChangeThemeButton> createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> {
  bool isOn = false;
  bool isIcons = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
        onPressed: () {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          isIcons = !isIcons;
          isOn = themeProvider.isDarkMode;

          provider.toggleThem(isOn);
        },
        icon: isIcons
            ? const Icon(
                Icons.mode_night_outlined,
                color: Colors.grey,
              )
            : const Icon(
                Icons.light_mode_outlined,
                color: Colors.grey,
              ));
  }
}
