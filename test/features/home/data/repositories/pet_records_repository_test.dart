import 'package:flutter_test/flutter_test.dart';
import 'package:pet_records/features/home/data/repositories/pet_records_repository.dart';

void main() {
  late PetRecordsRepository repository;

  setUp(() {
    repository = PetRecordsRepository();
  });

  group('PetRecordsRepository', () {
    test('getAllPets returns all pets', () {
      final pets = repository.getAllPets();
      expect(pets.length, 3);
      expect(pets.map((p) => p.species).toList(), ['Dog', 'Cat', 'Duck']);
    });

    test('getPetById returns correct pet', () async {
      final pet = await repository.getPetById('dog1');
      expect(pet.name, 'Max');
      expect(pet.species, 'Dog');
      expect(pet.breed, 'Golden Retriever');
    });

    test('getPetById throws exception for invalid ID', () async {
      expect(
        () => repository.getPetById('invalid_id'),
        throwsException,
      );
    });

    test('getAllTestResults returns all test results', () async {
      final results = await repository.getAllTestResults();
      expect(results.length, 9); // Updated count for all test results
      expect(
        results.map((t) => t.testName).toList(),
        contains('Complete Blood Count'),
      );
    });

    test('getTestResultsForPet returns correct test results', () {
      final dogTests = repository.getTestResultsForPet('dog1');
      expect(dogTests.length, 3); // Updated count including new ordered test
      expect(
        dogTests.map((t) => t.testName).toList(),
        ['Heartworm Test', 'Complete Blood Count', 'Thyroid Function'],
      );

      final catTests = repository.getTestResultsForPet('cat1');
      expect(catTests.length, 4); // Updated count including new tests
      expect(
        catTests.map((t) => t.testName).toList(),
        [
          'Toxoplasmosis Screen',
          'Kidney Function',
          'Feline Leukemia Test',
          'Blood Glucose'
        ],
      );

      final duckTests = repository.getTestResultsForPet('duck1');
      expect(duckTests.length, 2); // Updated count including new ordered test
      expect(
        duckTests.map((t) => t.testName).toList(),
        ['Duck Virus Enteritis', 'Avian Influenza Test'],
      );
    });

    test('getTestResultById returns correct test result', () {
      final test = repository.getTestResultById('test1');
      expect(test.testName, 'Complete Blood Count');
      expect(test.petId, 'dog1');
      expect(test.result, 'Normal');
    });

    test('getTestResultById throws exception for invalid ID', () {
      expect(
        () => repository.getTestResultById('invalid_id'),
        throwsException,
      );
    });

    test('test results have correct status', () {
      final normalTest = repository.getTestResultById('test1');
      expect(normalTest.result, 'Normal');

      final abnormalTest = repository.getTestResultById('test2');
      expect(abnormalTest.result, 'High');

      final dangerousTest = repository.getTestResultById('test6');
      expect(dangerousTest.result, 'Dangerous');
    });
  });
}
