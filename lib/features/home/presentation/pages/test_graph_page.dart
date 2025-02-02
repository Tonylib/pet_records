import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/test_result.dart';
import 'package:intl/intl.dart';

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

    // Find the min and max values for the y-axis with padding
    final allTestValues = allValues.map((v) => v.value).toList();
    final maxValue = allTestValues.reduce((a, b) => a > b ? a : b);
    final minValue = allTestValues.reduce((a, b) => a < b ? a : b);
    final valueRange = maxValue - minValue;

    // Calculate nice round numbers for the axis
    final yMin = ((minValue - valueRange * 0.2) / 10).floor() * 10.0;
    final yMax = ((maxValue + valueRange * 0.2) / 10).ceil() * 10.0;
    final yInterval =
        ((yMax - yMin) / 6).round() / 2 * 10.0; // Ensure it's a multiple of 10

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
                    drawHorizontalLine: true,
                    horizontalInterval: yInterval,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.black12,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.black12,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      );
                    },
                    checkToShowHorizontalLine: (value) {
                      return value % yInterval == 0;
                    },
                    checkToShowVerticalLine: (value) {
                      return value.toInt() < allValues.length;
                    },
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < allValues.length) {
                            final date = allValues[value.toInt()].date;
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                DateFormat('M/d').format(date),
                                style: const TextStyle(fontSize: 12),
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
                        reservedSize: 50,
                        interval: yInterval,
                        getTitlesWidget: (value, meta) {
                          if (value % yInterval == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  minY: yMin,
                  maxY: yMax,
                  minX: -0.5,
                  maxX: allValues.length - 0.5,
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
                        y1: yMin,
                        y2: testResult.dangerouslyLowThreshold,
                        color: Colors.red.withOpacity(0.1),
                      ),
                      HorizontalRangeAnnotation(
                        y1: testResult.dangerouslyLowThreshold,
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
                        y2: testResult.dangerouslyHighThreshold,
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      HorizontalRangeAnnotation(
                        y1: testResult.dangerouslyHighThreshold,
                        y2: yMax,
                        color: Colors.red.withOpacity(0.1),
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
                      '${testResult.minRange.toInt()} - ${testResult.maxRange.toInt()}',
                      Colors.green,
                    ),
                    _buildRangeRow(
                      context,
                      'Elevated',
                      '< ${testResult.minRange.toInt()} or > ${testResult.maxRange.toInt()}',
                      Colors.orange,
                    ),
                    _buildRangeRow(
                      context,
                      'Dangerous',
                      '< ${testResult.dangerouslyLowThreshold.toInt()} or > ${testResult.dangerouslyHighThreshold.toInt()}',
                      Colors.red,
                    ),
                    const Divider(),
                    Text(
                      'Latest Result',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${testResult.value.toInt()} ${testResult.unit}',
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
