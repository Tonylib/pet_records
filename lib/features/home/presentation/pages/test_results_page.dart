import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/pet_records_repository.dart';
import '../../domain/models/pet.dart';
import '../../domain/models/test_result.dart';
import 'test_graph_page.dart';

class TestResultsPage extends StatelessWidget {
  final PetRecordsRepository repository = PetRecordsRepository();

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
          final latestTest = testResults.isNotEmpty
              ? testResults.reduce((a, b) => a.date.isAfter(b.date) ? a : b)
              : null;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ExpansionTile(
              leading: const Icon(Icons.pets, size: 32),
              title: Text(
                pet.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${pet.species} • ${pet.breed} • ${pet.age} years old'),
                  if (latestTest?.currentStatus != null) ...[
                    const SizedBox(height: 4),
                    Transform.scale(
                      scale: 0.85,
                      child: Chip(
                        label: Text(
                          latestTest!.currentStatus!.type.name.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        backgroundColor: latestTest.currentStatus!.type.color,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ],
              ),
              children: [
                ...testResults.map((test) => ListTile(
                      onTap: test.hasHistoricalData
                          ? () => Get.to(() => TestGraphPage(testResult: test))
                          : null,
                      title: Text(test.testName),
                      subtitle: Text(
                        '${test.value} ${test.unit} • ${test.date.toString().split(' ')[0]}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (test.hasHistoricalData)
                            const Icon(Icons.show_chart, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            test.currentStatus?.type ==
                                    TestStatusType.processing
                                ? 'Pending'
                                : test.result,
                            style: TextStyle(
                              color: test.currentStatus?.type ==
                                      TestStatusType.processing
                                  ? Colors.orange
                                  : _getResultColor(test.result),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getResultColor(String result) {
    switch (result.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'high':
        return Colors.orange;
      case 'low':
        return Colors.orange;
      case 'dangerous':
        return Colors.red;
      case 'negative':
        return Colors.green;
      case 'positive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
