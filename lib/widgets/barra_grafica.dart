import 'package:flutter/material.dart';

class BarraGrafica extends StatelessWidget {
  final double montoGasto;
  final double porcentajeDelTotal; // En este caso será porcentaje del máximo
  final IconData icono;

  const BarraGrafica(this.montoGasto, this.porcentajeDelTotal, this.icono, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          // Barra
          SizedBox(
            height: constraints.maxHeight * 0.70,
            width: 30,
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
                  heightFactor: porcentajeDelTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B72BE), // Color morado
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
              child: Icon(icono, color: Colors.grey.shade700),
            ),
          ),
        ],
      );
    });
  }
}