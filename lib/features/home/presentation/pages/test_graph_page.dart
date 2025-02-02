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

    // Find the min and max values for the y-axis
    final allTestValues = allValues.map((v) => v.value).toList();
    final minValue =
        (allTestValues.reduce((a, b) => a < b ? a : b) - testResult.range * 0.3)
            .clamp(testResult.dangerouslyLowThreshold, double.infinity);
    final maxValue = (allTestValues.reduce((a, b) => a > b ? a : b) +
            testResult.range * 0.3)
        .clamp(double.negativeInfinity, testResult.dangerouslyHighThreshold);

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
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 0.5,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.black12,
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.black12,
                        strokeWidth: 1,
                      );
                    },
                  ),
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
                        interval: 0.5,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minY: minValue,
                  maxY: maxValue,
                  clipData: FlClipData.all(),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black12),
                  ),
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
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) {
                          final value = allValues[index].value;
                          final color =
                              switch (testResult.getStatusForValue(value)) {
                            'dangerous' => Colors.red,
                            'elevated' => Colors.orange,
                            _ => Colors.green,
                          };
                          return FlDotCirclePainter(
                            radius: 6,
                            color: color,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                    ),
                  ],
                  backgroundColor: Colors.white,
                  rangeAnnotations: RangeAnnotations(
                    horizontalRangeAnnotations: [
                      HorizontalRangeAnnotation(
                        y1: testResult.dangerouslyLowThreshold,
                        y2: testResult.slightlyLowThreshold,
                        color: Colors.red.withOpacity(0.1),
                      ),
                      HorizontalRangeAnnotation(
                        y1: testResult.slightlyLowThreshold,
                        y2: testResult.minRange,
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      HorizontalRangeAnnotation(
                        y1: testResult.minRange,
                        y2: testResult.maxRange,
                        color: Colors.green.withOpacity(0.1),
                      ),
                      HorizontalRangeAnnotation(
                        y1: testResult.maxRange,
                        y2: testResult.slightlyHighThreshold,
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      HorizontalRangeAnnotation(
                        y1: testResult.slightlyHighThreshold,
                        y2: testResult.dangerouslyHighThreshold,
                        color: Colors.red.withOpacity(0.1),
                      ),
                    ],
                  ),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: testResult.minRange,
                        color: Colors.green.withOpacity(0.5),
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      ),
                      HorizontalLine(
                        y: testResult.maxRange,
                        color: Colors.green.withOpacity(0.5),
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      ),
                    ],
                  ),
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
                      'Ranges',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildRangeRow(
                      context,
                      'Normal',
                      '${testResult.minRange} - ${testResult.maxRange}',
                      Colors.green,
                    ),
                    _buildRangeRow(
                      context,
                      'Elevated',
                      '< ${testResult.minRange} or > ${testResult.maxRange}',
                      Colors.orange,
                    ),
                    _buildRangeRow(
                      context,
                      'Dangerous',
                      '< ${testResult.dangerouslyLowThreshold.toStringAsFixed(1)} or > ${testResult.dangerouslyHighThreshold.toStringAsFixed(1)}',
                      Colors.red,
                    ),
                    const Divider(),
                    Text(
                      'Latest Result',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${testResult.value} ${testResult.unit}',
                      style: TextStyle(
                        color: switch (
                            testResult.getStatusForValue(testResult.value)) {
                          'dangerous' => Colors.red,
                          'elevated' => Colors.orange,
                          _ => Colors.green,
                        },
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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

  Widget _buildRangeRow(
      BuildContext context, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
