import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet Records',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
