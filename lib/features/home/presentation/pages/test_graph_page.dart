import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/test_result.dart';

class TestGraphPage extends StatelessWidget {
  final TestResult testResult;

  const TestGraphPage({
    super.key,
    required this.testResult,
  });

  @override
  Widget build(BuildContext context) {
    final allValues = [
      ...testResult.historicalValues,
      HistoricalValue(date: testResult.date, value: testResult.value),
    ]..sort((a, b) => a.date.compareTo(b.date));

    return Scaffold(
      appBar: AppBar(
        title: Text(testResult.testName),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Historical Values (${testResult.unit})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < allValues.length) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${allValues[value.toInt()].date.month}/${allValues[value.toInt()].date.day}',
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        allValues.length,
                        (index) =>
                            FlSpot(index.toDouble(), allValues[index].value),
                      ),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                    // Reference lines for normal range
                    LineChartBarData(
                      spots: List.generate(
                        allValues.length,
                        (index) =>
                            FlSpot(index.toDouble(), testResult.maxRange),
                      ),
                      color: Colors.red.withOpacity(0.3),
                      barWidth: 1,
                      dotData: const FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: List.generate(
                        allValues.length,
                        (index) =>
                            FlSpot(index.toDouble(), testResult.minRange),
                      ),
                      color: Colors.red.withOpacity(0.3),
                      barWidth: 1,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Normal Range',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                        '${testResult.minRange} - ${testResult.maxRange} ${testResult.unit}'),
                    const SizedBox(height: 16),
                    Text(
                      'Latest Result',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${testResult.value} ${testResult.unit}',
                      style: TextStyle(
                        color:
                            testResult.isNormal ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
