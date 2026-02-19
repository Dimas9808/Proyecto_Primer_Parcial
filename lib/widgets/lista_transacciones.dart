import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaccion.dart';

class ListaTransacciones extends StatelessWidget {
  final List<Transaccion> transacciones;
  final Function borrarTx; // 1. Recibimos la función

  const ListaTransacciones(this.transacciones, this.borrarTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return transacciones.isEmpty
        ? Center(
            child: Text(
              '¡No hay gastos aún!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              final tx = transacciones[index];
              
              // (Opcional) Si quieres mantener el icono de categoría, puedes moverlo o dejarlo.
              // En este caso, lo reemplazamos por el botón de borrar para limpiar la interfaz.

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
                          '\$${tx.monto.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tx.titulo,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    DateFormat.yMd().format(tx.fecha),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  // 2. Aquí está el botón de eliminar
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red, // Color rojo estándar
                    onPressed: () => borrarTx(tx.id), // Llamamos a la función con el ID
                  ),
                ),
              );
            },
            itemCount: transacciones.length,
          );
  }
}