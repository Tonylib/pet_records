import 'package:flutter_test/flutter_test.dart';
import 'package:pet_records/features/home/data/repositories/pet_records_repository.dart';
import 'package:pet_records/features/home/domain/models/pet.dart';
import 'package:pet_records/features/home/domain/models/test_result.dart';

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

    test('getPetById returns correct pet', () {
      final pet = repository.getPetById('dog1');
      expect(pet.name, 'Max');
      expect(pet.species, 'Dog');
      expect(pet.breed, 'Golden Retriever');
    });

    test('getPetById throws exception for invalid ID', () {
      expect(
        () => repository.getPetById('invalid_id'),
        throwsException,
      );
    });

    test('getTestResultsForPet returns correct test results', () {
      final dogTests = repository.getTestResultsForPet('dog1');
      expect(dogTests.length, 2);
      expect(
        dogTests.map((t) => t.testName).toList(),
        ['Complete Blood Count', 'Thyroid Function'],
      );

      final catTests = repository.getTestResultsForPet('cat1');
      expect(catTests.length, 2);
      expect(
        catTests.map((t) => t.testName).toList(),
        ['Kidney Function', 'Feline Leukemia Test'],
      );

      final duckTests = repository.getTestResultsForPet('duck1');
      expect(duckTests.length, 1);
      expect(duckTests.first.testName, 'Avian Influenza Test');
    });

    test('getTestResultById returns correct test result', () {
      final test = repository.getTestResultById('test1');
      expect(test.testName, 'Complete Blood Count');
      expect(test.petId, 'dog1');
      expect(test.isNormal, true);
    });

    test('getTestResultById throws exception for invalid ID', () {
      expect(
        () => repository.getTestResultById('invalid_id'),
        throwsException,
      );
    });

    test('test results have correct normal/abnormal status', () {
      final normalTest = repository.getTestResultById('test1');
      expect(normalTest.isNormal, true);

      final abnormalTest = repository.getTestResultById('test2');
      expect(abnormalTest.isNormal, false);
    });
  });
}
