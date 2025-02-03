import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pet_records/features/home/data/repositories/pet_records_repository.dart';
import 'package:pet_records/features/home/domain/models/pet.dart';
import 'package:pet_records/features/home/domain/models/test_result.dart';
import 'package:pet_records/features/home/presentation/controllers/test_results_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<PetRecordsRepository>()])
import 'test_results_controller_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Get.testMode = true;

  late TestResultsController controller;
  late MockPetRecordsRepository mockRepository;

  final testPet = Pet(
    id: 'test_pet_1',
    name: 'Max',
    species: 'Dog',
    breed: 'Labrador',
    dateOfBirth: DateTime(2020, 1, 1),
  );

  final testResults = [
    TestResult(
      id: 'test1',
      petId: 'test_pet_1',
      testName: 'Blood Test',
      result: 'Normal',
      unit: 'mg/dL',
      value: 10.0,
      minRange: 8.0,
      maxRange: 12.0,
      date: DateTime(2024, 1, 1),
      veterinarian: 'Dr. Smith',
      statusHistory: [
        TestStatus(
          type: TestStatusType.complete,
          date: DateTime(2024, 1, 1),
        ),
      ],
    ),
    TestResult(
      id: 'test2',
      petId: 'test_pet_1',
      testName: 'Glucose',
      result: 'High',
      unit: 'mg/dL',
      value: 150.0,
      minRange: 70.0,
      maxRange: 140.0,
      date: DateTime(2024, 1, 2),
      veterinarian: 'Dr. Smith',
      statusHistory: [
        TestStatus(
          type: TestStatusType.processing,
          date: DateTime(2024, 1, 2),
        ),
      ],
    ),
  ];

  setUp(() {
    Get.reset();
    Get.testMode = true;

    mockRepository = MockPetRecordsRepository();
    Get.put<PetRecordsRepository>(mockRepository);

    final app = GetMaterialApp(
      home: const Scaffold(),
    );
    app.createElement();

    controller = TestResultsController();
  });

  tearDown(() {
    Get.reset();
  });

  group('TestResultsController', () {
    test('initial state should be loading with empty data', () {
      expect(controller.testResultsData.loading.value, true);
      expect(controller.testResultsData.data.value, isEmpty);
      expect(controller.testResultsData.error.value, isEmpty);
      expect(controller.testResultsData.selectedStatus.value, null);
    });

    group('loadData', () {
      test('should load test results and pets successfully', () async {
        // Arrange
        when(mockRepository.getAllTestResults())
            .thenAnswer((_) async => testResults);
        when(mockRepository.getPetById('test_pet_1'))
            .thenAnswer((_) async => testPet);

        // Act
        await controller.loadData();

        // Assert
        expect(controller.testResultsData.loading.value, false);
        expect(controller.testResultsData.error.value, isEmpty);
        expect(controller.testResultsData.data.value, equals(testResults));
        expect(controller.testResultsData.petsCache['test_pet_1'],
            equals(testPet));

        verify(mockRepository.getAllTestResults()).called(1);
        verify(mockRepository.getPetById('test_pet_1')).called(1);
      });

      test('should handle error when loading test results fails', () async {
        // Arrange
        final error = Exception('Failed to load test results');
        when(mockRepository.getAllTestResults()).thenThrow(error);

        // Act
        await controller.loadData();

        // Assert
        expect(controller.testResultsData.loading.value, false);
        expect(controller.testResultsData.error.value, error.toString());
        expect(controller.testResultsData.data.value, isEmpty);
        expect(controller.testResultsData.petsCache, isEmpty);
      });
    });

    group('setSelectedStatus', () {
      test('should update selected status', () {
        // Act
        controller.setSelectedStatus(TestStatusType.processing);

        // Assert
        expect(controller.testResultsData.selectedStatus.value,
            TestStatusType.processing);
      });

      test('should clear selected status when null is passed', () {
        // Arrange
        controller.setSelectedStatus(TestStatusType.processing);
        expect(controller.testResultsData.selectedStatus.value,
            TestStatusType.processing);

        // Act
        controller.setSelectedStatus(null);

        // Assert
        expect(controller.testResultsData.selectedStatus.value, null);
      });
    });

    group('filteredTests', () {
      setUp(() async {
        when(mockRepository.getAllTestResults())
            .thenAnswer((_) async => testResults);
        when(mockRepository.getPetById('test_pet_1'))
            .thenAnswer((_) async => testPet);
        await controller.loadData();
      });

      test('should return all tests when no status is selected', () {
        // Act
        controller.setSelectedStatus(null);

        // Assert
        expect(controller.testResultsData.filteredTests.length, equals(2));
      });

      test(
          'should return only processing tests when processing status is selected',
          () {
        // Act
        controller.setSelectedStatus(TestStatusType.processing);

        // Assert
        final filtered = controller.testResultsData.filteredTests;
        expect(filtered.length, equals(1));
        expect(filtered.first.id, equals('test2'));
        expect(filtered.first.currentStatus?.type,
            equals(TestStatusType.processing));
      });

      test('should return only complete tests when complete status is selected',
          () {
        // Act
        controller.setSelectedStatus(TestStatusType.complete);

        // Assert
        final filtered = controller.testResultsData.filteredTests;
        expect(filtered.length, equals(1));
        expect(filtered.first.id, equals('test1'));
        expect(filtered.first.currentStatus?.type,
            equals(TestStatusType.complete));
      });
    });

    group('getResultColor', () {
      test('should return correct colors for different result types', () {
        expect(controller.getResultColor('normal'),
            equals(Get.theme.colorScheme.primary));
        expect(controller.getResultColor('high'), equals(Colors.orange));
        expect(controller.getResultColor('low'), equals(Colors.orange));
        expect(controller.getResultColor('dangerous'),
            equals(Get.theme.colorScheme.error));
        expect(controller.getResultColor('negative'),
            equals(Get.theme.colorScheme.primary));
        expect(controller.getResultColor('positive'),
            equals(Get.theme.colorScheme.error));
        expect(controller.getResultColor('unknown'),
            equals(Get.theme.colorScheme.outline));
      });
    });
  });
}
