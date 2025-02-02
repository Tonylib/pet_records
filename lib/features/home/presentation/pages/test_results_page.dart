import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/pet_records_repository.dart';
import '../../domain/models/pet.dart';
import 'test_graph_page.dart';

class TestResultsPage extends StatelessWidget {
  final repository = PetRecordsRepository();

  TestResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = repository.getAllPets();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          final testResults = repository.getTestResultsForPet(pet.id);

          return Card(
            child: ExpansionTile(
              leading: Icon(
                Icons.pets,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                pet.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle:
                  Text('${pet.species} • ${pet.breed} • ${pet.age} years old'),
              children: testResults
                  .map((test) => ListTile(
                        title: Text(test.testName),
                        subtitle: Text(
                          '${test.result} • ${test.value} ${test.unit}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (test.hasHistoricalData) ...[
                              IconButton(
                                icon: const Icon(Icons.show_chart),
                                onPressed: () => Get.to(
                                  () => TestGraphPage(testResult: test),
                                  transition: Transition.zoom,
                                ),
                                tooltip: 'View Historical Data',
                              ),
                              const SizedBox(width: 8),
                            ],
                            Icon(
                              test.isNormal
                                  ? Icons.check_circle
                                  : Icons.warning,
                              color:
                                  test.isNormal ? Colors.green : Colors.orange,
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
