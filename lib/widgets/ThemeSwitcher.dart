import 'package:drive_clone_app/Utils/utils.dart';
import 'package:drive_clone_app/providers/ThemeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final switcherProvider = Provider.of<ThemeNotifier>(context);
    return Switch(
      activeColor: Theme.of(context).accentColor,
      onChanged: (value) {
        switcherProvider.toggleTheme();
      },
      value: switcherProvider.themeData == darkTheme,
    );
  }
}
