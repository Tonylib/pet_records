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
