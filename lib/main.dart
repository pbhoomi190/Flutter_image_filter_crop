import 'package:flutter/material.dart';
import 'package:flutter_image_filter/screens/filter_image_screen.dart';
import 'package:flutter_image_filter/utils/custom_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: CustomAppTheme.darkTheme,
      theme: CustomAppTheme.lightTheme,
      home: FilterImageScreen(),
    );
  }
}

