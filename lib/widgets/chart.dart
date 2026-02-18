import 'package:flutter/material.dart';

import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Map<String, Object>> groupedTransactionValues;
  final double totalSpending;

  const Chart(this.groupedTransactionValues, this.totalSpending, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                (data['amount'] as double),
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                data['icon'] as IconData,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}