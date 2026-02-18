import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaccion.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: Text(
              'No hay gastos aún!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              final tx = transactions[index];
              IconData icon;
              // Mapeo de categorías a iconos
              switch (tx.category) {
                case Category.comida: icon = Icons.lunch_dining; break;
                case Category.viaje: icon = Icons.flight_takeoff; break;
                case Category.cine: icon = Icons.movie; break;
                case Category.trabajo: icon = Icons.work; break;
              }

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                color: Colors.deepPurple.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$${tx.amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tx.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    DateFormat.yMd().format(tx.date),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Icon(icon, color: Colors.black87),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}