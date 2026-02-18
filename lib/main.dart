import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
// Importaciones de tus nuevos archivos
import 'models/transaccion.dart';
import 'widgets/grafica.dart';
import 'widgets/nueva_transaccion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Gastos',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D0055),
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Datos iniciales
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'Curso Dart', amount: 199.90, date: DateTime(2026, 2, 10), category: Category.trabajo),
    Transaction(id: 't2', title: 'Cine', amount: 200.00, date: DateTime(2026, 2, 10), category: Category.cine),
    Transaction(id: 't3', title: 'Mi Viaje', amount: 234.00, date: DateTime(2026, 2, 3), category: Category.viaje),
    Transaction(id: 't4', title: 'Buffet', amount: 258.00, date: DateTime(2026, 2, 5), category: Category.comida),
    Transaction(id: 't5', title: 'Viaje Nuevo', amount: 10000.00, date: DateTime(2026, 2, 2), category: Category.viaje),
    Transaction(id: 't6', title: 'Comida', amount: 7000.00, date: DateTime(2026, 2, 2), category: Category.comida),
  ];

  List<Map<String, Object>> get _groupedTransactionValues {
    return [
      {'cat': Category.comida, 'icon': Icons.lunch_dining},
      {'cat': Category.cine, 'icon': Icons.movie},
      {'cat': Category.viaje, 'icon': Icons.flight_takeoff},
      {'cat': Category.trabajo, 'icon': Icons.work},
    ].map((data) {
      final cat = data['cat'] as Category;
      double totalSum = 0.0;

      for (var i = 0; i < _userTransactions.length; i++) {
        if (_userTransactions[i].category == cat) {
          totalSum += _userTransactions[i].amount;
        }
      }

      return {
        'category': cat,
        'amount': totalSum,
        'icon': data['icon'] as IconData,
      };
    }).toList();
  }

  double get _totalSpending {
    return _groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate, Category chosenCategory) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      category: chosenCategory,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    final appBar = AppBar(
      title: const Text('Control Gastos Flutter'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final txListWidget = SizedBox(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
      child: TransactionList(_userTransactions)
    );

    final chartWidget = SizedBox(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * (isLandscape ? 0.8 : 0.3),
      child: Chart(_groupedTransactionValues, _totalSpending),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: chartWidget),
                  Expanded(child: txListWidget),
                ],
              ),
            if (!isLandscape) ...[
              chartWidget,
              txListWidget,
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}