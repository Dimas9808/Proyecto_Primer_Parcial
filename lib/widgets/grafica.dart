import 'package:flutter/material.dart';

import './barra_grafica.dart';

class Grafica extends StatelessWidget {
  final List<Map<String, Object>> transaccionesAgrupadas;

  const Grafica(this.transaccionesAgrupadas, {super.key});

  @override
  Widget build(BuildContext context) {
    // Calcular el gasto más alto de la semana/grupo para usarlo como 100% de altura
    double gastoMaximo = 0.0;
    for (var item in transaccionesAgrupadas) {
      if ((item['monto'] as double) > gastoMaximo) {
        gastoMaximo = (item['monto'] as double);
      }
    }

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transaccionesAgrupadas.map((dato) {
            // Calculamos el porcentaje relativo al MÁXIMO
            final porcentajeRelativo = gastoMaximo == 0.0 
                ? 0.0 
                : (dato['monto'] as double) / gastoMaximo;

            return Flexible(
              fit: FlexFit.tight,
              child: BarraGrafica(
                (dato['monto'] as double),
                porcentajeRelativo,
                dato['icono'] as IconData,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}