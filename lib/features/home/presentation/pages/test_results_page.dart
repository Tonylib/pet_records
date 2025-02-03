import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/pet_records_repository.dart';
import '../../domain/models/pet.dart';
import '../../domain/models/test_result.dart';
import 'test_graph_page.dart';

class TestResultsPage extends StatefulWidget {
  TestResultsPage({super.key});

  @override
  State<TestResultsPage> createState() => _TestResultsPageState();
}

class _TestResultsPageState extends State<TestResultsPage> {
  final PetRecordsRepository repository = PetRecordsRepository();
  TestStatusType? selectedStatus;

  @override
  Widget build(BuildContext context) {
    // Create a modifiable copy of the test results list
    final allTests = [...repository.getAllTestResults()];

    // Filter by status if selected
    final filteredTests = selectedStatus != null
        ? allTests
            .where((test) => test.currentStatus?.type == selectedStatus)
            .toList()
        : allTests;

    // Sort tests by date, most recent first
    filteredTests.sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('ALL'),
                    selected: selectedStatus == null,
                    onSelected: (selected) {
                      setState(() {
                        selectedStatus = null;
                      });
                    },
                  ),
                ),
                ...TestStatusType.values.map((status) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(
                          status.name.toUpperCase(),
                          style: TextStyle(
                            color:
                                selectedStatus == status ? Colors.white : null,
                          ),
                        ),
                        selected: selectedStatus == status,
                        selectedColor: status.color,
                        checkmarkColor: Colors.white,
                        onSelected: (selected) {
                          setState(() {
                            selectedStatus = selected ? status : null;
                          });
                        },
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredTests.length,
              itemBuilder: (context, index) {
                final test = filteredTests[index];
                final pet = repository.getPetById(test.petId);

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: test.hasHistoricalData
                        ? () => Get.to(() => TestGraphPage(testResult: test))
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.pets, size: 24),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pet.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      '${pet.species} • ${pet.breed}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  if (test.hasHistoricalData)
                                    const Icon(Icons.show_chart,
                                        color: Colors.blue),
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
                                  if (test.currentStatus != null)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Transform.scale(
                                          scale: 0.85,
                                          child: Chip(
                                            label: Text(
                                              test.currentStatus!.type.name
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            ),
                                            backgroundColor:
                                                test.currentStatus!.type.color,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            labelPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      test.testName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontSize: 20,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${test.value} ${test.unit} • ${test.date.toString().split(' ')[0]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
