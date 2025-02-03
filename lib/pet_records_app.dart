import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_records/core/theme/app_theme.dart';
import 'package:pet_records/features/home/presentation/bindings/home_binding.dart';
import 'package:pet_records/features/home/presentation/pages/home_page.dart';

class PetRecordsApp extends StatelessWidget {
  static const String _title = 'Pet Records';
  const PetRecordsApp({super.key});

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
