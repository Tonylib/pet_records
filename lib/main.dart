import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/bindings/home_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Pet Records';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: _title,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialBinding: HomeBinding(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
