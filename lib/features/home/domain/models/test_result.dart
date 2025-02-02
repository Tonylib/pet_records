import 'package:flutter/material.dart';

class TestResult {
  final String id;
  final String petId;
  final String testName;
  final String result;
  final String unit;
  final double value;
  final double minRange;
  final double maxRange;
  final DateTime date;
  final String veterinarian;
  final List<HistoricalValue>? historicalValues;
  final List<TestStatus> statusHistory;

  const TestResult({
    required this.id,
    required this.petId,
    required this.testName,
    required this.result,
    required this.unit,
    required this.value,
    required this.minRange,
    required this.maxRange,
    required this.date,
    required this.veterinarian,
    this.historicalValues,
    this.statusHistory = const [],
  });

  bool get isNormal => value >= minRange && value <= maxRange;
  bool get hasHistoricalData => historicalValues?.isNotEmpty ?? false;
  TestStatus? get currentStatus =>
      statusHistory.isNotEmpty ? statusHistory.last : null;

  // Helper methods for range calculations
  double get range => maxRange - minRange;
  double get dangerouslyLowThreshold => minRange - (range * 0.2);
  double get dangerouslyHighThreshold => maxRange + (range * 0.2);
  double get slightlyLowThreshold => minRange - (range * 0.1);
  double get slightlyHighThreshold => maxRange + (range * 0.1);

  // Helper method to determine status based on a value
  String getStatusForValue(double value) {
    if (value < dangerouslyLowThreshold || value > dangerouslyHighThreshold) {
      return 'dangerous';
    } else if (value < minRange || value > maxRange) {
      return 'elevated';
    }
    return 'normal';
  }

  @override
  String toString() =>
      'TestResult(id: $id, petId: $petId, testName: $testName, result: $result, unit: $unit, value: $value, range: $minRange-$maxRange, date: $date, veterinarian: $veterinarian)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TestResult &&
        other.id == id &&
        other.petId == petId &&
        other.testName == testName &&
        other.result == result &&
        other.unit == unit &&
        other.value == value &&
        other.minRange == minRange &&
        other.maxRange == maxRange &&
        other.date == date &&
        other.veterinarian == veterinarian;
  }

  @override
  int get hashCode => Object.hash(
        id,
        petId,
        testName,
        result,
        unit,
        value,
        minRange,
        maxRange,
        date,
        veterinarian,
      );
}

class HistoricalValue {
  final DateTime date;
  final double value;

  const HistoricalValue({
    required this.date,
    required this.value,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HistoricalValue &&
        other.date == date &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(date, value);
}

enum TestStatusType {
  ordered(Color(0xFF2196F3)),
  processing(Color(0xFFFF9800)),
  error(Color(0xFFF44336)),
  complete(Color(0xFF4CAF50));

  final Color color;
  const TestStatusType(this.color);
}

class TestStatus {
  final TestStatusType type;
  final DateTime date;

  const TestStatus({
    required this.type,
    required this.date,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TestStatus && other.type == type && other.date == date;
  }

  @override
  int get hashCode => Object.hash(type, date);
}
