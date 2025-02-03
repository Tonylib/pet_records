import 'package:flutter/material.dart';
import '../../../../core/widgets/pet_records_app_bar.dart';
import '../widgets/greeting_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PetRecordsAppBar(title: 'Pet Records'),
      body: Center(
        child: GreetingWidget(),
      ),
    );
  }
}
