import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spendingAmount;
  final double spendingPctOfTotal;
  final IconData icon;

  const ChartBar(this.spendingAmount, this.spendingPctOfTotal, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          // Texto del monto (opcional, oculto en screenshot pero útil)
          // Barra
          SizedBox(
            height: constraints.maxHeight * 0.70,
            width: 30, // Ancho de la barra
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B72BE), // Color morado de las barras
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Icono
          SizedBox(
            height: constraints.maxHeight * 0.20,
            child: FittedBox(
              child: Icon(icon, color: Colors.grey.shade700),
            ),
          ),
        ],
      );
    });
  }
}