// Mocks generated by Mockito 5.4.5 from annotations
// in pet_records/test/features/home/presentation/controllers/test_results_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:pet_records/features/home/data/repositories/pet_records_repository.dart'
    as _i4;
import 'package:pet_records/features/home/domain/models/pet.dart' as _i2;
import 'package:pet_records/features/home/domain/models/test_result.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePet_0 extends _i1.SmartFake implements _i2.Pet {
  _FakePet_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeTestResult_1 extends _i1.SmartFake implements _i3.TestResult {
  _FakeTestResult_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [PetRecordsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPetRecordsRepository extends _i1.Mock
    implements _i4.PetRecordsRepository {
  @override
  _i5.Future<List<_i3.TestResult>> getAllTestResults() =>
      (super.noSuchMethod(
            Invocation.method(#getAllTestResults, []),
            returnValue: _i5.Future<List<_i3.TestResult>>.value(
              <_i3.TestResult>[],
            ),
            returnValueForMissingStub: _i5.Future<List<_i3.TestResult>>.value(
              <_i3.TestResult>[],
            ),
          )
          as _i5.Future<List<_i3.TestResult>>);

  @override
  List<_i2.Pet> getAllPets() =>
      (super.noSuchMethod(
            Invocation.method(#getAllPets, []),
            returnValue: <_i2.Pet>[],
            returnValueForMissingStub: <_i2.Pet>[],
          )
          as List<_i2.Pet>);

  @override
  _i5.Future<_i2.Pet> getPetById(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#getPetById, [id]),
            returnValue: _i5.Future<_i2.Pet>.value(
              _FakePet_0(this, Invocation.method(#getPetById, [id])),
            ),
            returnValueForMissingStub: _i5.Future<_i2.Pet>.value(
              _FakePet_0(this, Invocation.method(#getPetById, [id])),
            ),
          )
          as _i5.Future<_i2.Pet>);

  @override
  List<_i3.TestResult> getTestResultsForPet(String? petId) =>
      (super.noSuchMethod(
            Invocation.method(#getTestResultsForPet, [petId]),
            returnValue: <_i3.TestResult>[],
            returnValueForMissingStub: <_i3.TestResult>[],
          )
          as List<_i3.TestResult>);

  @override
  _i3.TestResult getTestResultById(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#getTestResultById, [id]),
            returnValue: _FakeTestResult_1(
              this,
              Invocation.method(#getTestResultById, [id]),
            ),
            returnValueForMissingStub: _FakeTestResult_1(
              this,
              Invocation.method(#getTestResultById, [id]),
            ),
          )
          as _i3.TestResult);
}
