import '../../domain/models/pet.dart';
import '../../domain/models/test_result.dart';

class PetRecordsRepository {
  // Mock data for pets
  final List<Pet> _pets = [
    const Pet(
      id: 'dog1',
      name: 'Max',
      species: 'Dog',
      breed: 'Golden Retriever',
      age: 5,
    ),
    const Pet(
      id: 'cat1',
      name: 'Luna',
      species: 'Cat',
      breed: 'Siamese',
      age: 3,
    ),
    const Pet(
      id: 'duck1',
      name: 'Donald',
      species: 'Duck',
      breed: 'Mallard',
      age: 2,
    ),
  ];

  // Mock data for test results
  final List<TestResult> _testResults = [
    // Dog test results
    TestResult(
      id: 'test1',
      petId: 'dog1',
      testName: 'Complete Blood Count',
      result: 'Normal',
      unit: 'K/µL',
      value: 8.5,
      minRange: 5.5,
      maxRange: 12.5,
      date: DateTime(2024, 2, 1),
      veterinarian: 'Dr. Smith',
      historicalValues: [
        HistoricalValue(date: DateTime(2023, 8, 1), value: 7.2),
        HistoricalValue(date: DateTime(2023, 10, 15), value: 7.8),
        HistoricalValue(date: DateTime(2023, 12, 1), value: 8.1),
      ],
      statusHistory: [
        TestStatus(
          type: TestStatusType.ordered,
          date: DateTime(2024, 2, 1, 9, 0),
        ),
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 2, 1, 10, 30),
        ),
        TestStatus(
          type: TestStatusType.complete,
          date: DateTime(2024, 2, 1, 11, 45),
        ),
      ],
    ),
    TestResult(
      id: 'test2',
      petId: 'dog1',
      testName: 'Thyroid Function',
      result: 'High',
      unit: 'ng/dL',
      value: 4.8,
      minRange: 1.0,
      maxRange: 4.0,
      date: DateTime(2024, 1, 15),
      veterinarian: 'Dr. Johnson',
      historicalValues: [
        HistoricalValue(date: DateTime(2023, 7, 15), value: 2.5),
        HistoricalValue(date: DateTime(2023, 9, 15), value: 3.2),
        HistoricalValue(date: DateTime(2023, 11, 15), value: 4.1),
      ],
      statusHistory: [
        TestStatus(
          type: TestStatusType.ordered,
          date: DateTime(2024, 1, 15, 8, 0),
        ),
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 1, 15, 9, 30),
        ),
        TestStatus(
          type: TestStatusType.error,
          date: DateTime(2024, 1, 15, 10, 15),
        ),
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 1, 15, 11, 0),
        ),
        TestStatus(
          type: TestStatusType.complete,
          date: DateTime(2024, 1, 15, 12, 30),
        ),
      ],
    ),
    // Cat test results
    TestResult(
      id: 'test3',
      petId: 'cat1',
      testName: 'Kidney Function',
      result: 'Normal',
      unit: 'mg/dL',
      value: 1.2,
      minRange: 0.8,
      maxRange: 2.4,
      date: DateTime(2024, 1, 20),
      veterinarian: 'Dr. Wilson',
      historicalValues: [
        HistoricalValue(date: DateTime(2023, 7, 20), value: 1.4),
        HistoricalValue(date: DateTime(2023, 9, 20), value: 1.3),
        HistoricalValue(date: DateTime(2023, 11, 20), value: 1.2),
      ],
      statusHistory: [
        TestStatus(
          type: TestStatusType.ordered,
          date: DateTime(2024, 1, 20, 13, 0),
        ),
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 1, 20, 14, 30),
        ),
        TestStatus(
          type: TestStatusType.complete,
          date: DateTime(2024, 1, 20, 15, 45),
        ),
      ],
    ),
    TestResult(
      id: 'test4',
      petId: 'cat1',
      testName: 'Feline Leukemia Test',
      result: 'Negative',
      unit: 'titer',
      value: 0.0,
      minRange: 0.0,
      maxRange: 0.0,
      date: DateTime(2024, 1, 10),
      veterinarian: 'Dr. Wilson',
      statusHistory: [
        TestStatus(
          type: TestStatusType.ordered,
          date: DateTime(2024, 1, 10, 9, 0),
        ),
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 1, 10, 10, 0),
        ),
        TestStatus(
          type: TestStatusType.complete,
          date: DateTime(2024, 1, 10, 11, 30),
        ),
      ],
    ),
    // New dangerous blood glucose test for Luna
    TestResult(
      id: 'test6',
      petId: 'cat1',
      testName: 'Blood Glucose',
      result: 'Dangerous',
      unit: 'mg/dL',
      value: 450.0,
      minRange: 80.0,
      maxRange: 150.0,
      date: DateTime(2024, 2, 1),
      veterinarian: 'Dr. Wilson',
      historicalValues: [
        HistoricalValue(date: DateTime(2023, 8, 1), value: 120.0),
        HistoricalValue(date: DateTime(2023, 10, 1), value: 180.0),
        HistoricalValue(date: DateTime(2023, 12, 1), value: 350.0),
      ],
      statusHistory: [
        TestStatus(
          type: TestStatusType.ordered,
          date: DateTime(2024, 2, 1, 8, 0),
        ),
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 2, 1, 9, 30),
        ),
        TestStatus(
          type: TestStatusType.complete,
          date: DateTime(2024, 2, 1, 10, 45),
        ),
      ],
    ),
    // Duck test results
    TestResult(
      id: 'test5',
      petId: 'duck1',
      testName: 'Avian Influenza Test',
      result: 'Negative',
      unit: 'titer',
      value: 0.0,
      minRange: 0.0,
      maxRange: 0.0,
      date: DateTime(2024, 1, 25),
      veterinarian: 'Dr. Brown',
      statusHistory: [
        TestStatus(
          type: TestStatusType.ordered,
          date: DateTime(2024, 1, 25, 11, 0),
        ),
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 1, 25, 12, 0),
        ),
      ],
    ),
  ];

  // Get all pets
  List<Pet> getAllPets() => List.unmodifiable(_pets);

  // Get a specific pet by ID
  Pet getPetById(String id) => _pets.firstWhere(
        (pet) => pet.id == id,
        orElse: () => throw Exception('Pet not found'),
      );

  // Get all test results for a specific pet
  List<TestResult> getTestResultsForPet(String petId) =>
      List.unmodifiable(_testResults.where((test) => test.petId == petId));

  // Get a specific test result by ID
  TestResult getTestResultById(String id) => _testResults.firstWhere(
        (test) => test.id == id,
        orElse: () => throw Exception('Test result not found'),
      );
}
