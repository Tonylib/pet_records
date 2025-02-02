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
  final List<HistoricalValue> historicalValues;

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
    this.historicalValues = const [],
  });

  bool get isNormal => value >= minRange && value <= maxRange;
  bool get hasHistoricalData => historicalValues.isNotEmpty;

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
}
