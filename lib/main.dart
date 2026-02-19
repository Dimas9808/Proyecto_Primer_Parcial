import 'package:flutter/material.dart';

import './models/transaccion.dart';
import './widgets/grafica.dart';
import './widgets/lista_transacciones.dart';
import './widgets/nueva_transaccion.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Gastos',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          error: Colors.red, // Definimos el color de error (rojo) para el botón borrar
        ),
        useMaterial3: true,
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D0055),
          foregroundColor: Colors.white,
        ),
      ),
      home: const PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _EstadoPaginaPrincipal();
}

class _EstadoPaginaPrincipal extends State<PaginaPrincipal> {
  final List<Transaccion> _transaccionesUsuario = [
    Transaccion(id: 't1', titulo: 'Curso Dart', monto: 199.90, fecha: DateTime(2026, 2, 10), categoria: Categoria.trabajo),
    Transaccion(id: 't2', titulo: 'Cine', monto: 200.00, fecha: DateTime(2026, 2, 10), categoria: Categoria.cine),
    Transaccion(id: 't3', titulo: 'Mi Viaje', monto: 234.00, fecha: DateTime(2026, 2, 3), categoria: Categoria.viaje),
    Transaccion(id: 't4', titulo: 'Buffet', monto: 258.00, fecha: DateTime(2026, 2, 5), categoria: Categoria.comida),
    Transaccion(id: 't5', titulo: 'Viaje Nuevo', monto: 10000.00, fecha: DateTime(2026, 2, 2), categoria: Categoria.viaje),
    Transaccion(id: 't6', titulo: 'Comida', monto: 7000.00, fecha: DateTime(2026, 2, 2), categoria: Categoria.comida),
  ];

  List<Map<String, Object>> get _valoresAgrupadosTransacciones {
    return [
      {'cat': Categoria.comida, 'icono': Icons.lunch_dining},
      {'cat': Categoria.cine, 'icono': Icons.movie},
      {'cat': Categoria.viaje, 'icono': Icons.flight_takeoff},
      {'cat': Categoria.trabajo, 'icono': Icons.work},
    ].map((data) {
      final cat = data['cat'] as Categoria;
      double sumaTotal = 0.0;

      for (var i = 0; i < _transaccionesUsuario.length; i++) {
        if (_transaccionesUsuario[i].categoria == cat) {
          sumaTotal += _transaccionesUsuario[i].monto;
        }
      }

      return {
        'categoria': cat,
        'monto': sumaTotal,
        'icono': data['icono'] as IconData,
      };
    }).toList();
  }

  void _agregarNuevaTransaccion(String tituloTx, double montoTx, DateTime fechaElegida, Categoria categoriaElegida) {
    final nuevaTx = Transaccion(
      titulo: tituloTx,
      monto: montoTx,
      fecha: fechaElegida,
      categoria: categoriaElegida,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transaccionesUsuario.add(nuevaTx);
    });
  }

  // --- NUEVA FUNCIÓN PARA BORRAR ---
  void _borrarTransaccion(String id) {
    setState(() {
      _transaccionesUsuario.removeWhere((tx) => tx.id == id);
    });
  }

  void _empezarNuevaTransaccion(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NuevaTransaccion(_agregarNuevaTransaccion),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final esHorizontal = MediaQuery.of(context).orientation == Orientation.landscape;
    
    final barraApp = AppBar(
      title: const Text('Control Gastos Flutter'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _empezarNuevaTransaccion(context),
        ),
      ],
    );

    final widgetLista = SizedBox(
      height: (MediaQuery.of(context).size.height - barraApp.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
      // --- PASAMOS LA FUNCIÓN DE BORRAR AQUÍ ---
      child: ListaTransacciones(_transaccionesUsuario, _borrarTransaccion)
    );

    final widgetGrafica = SizedBox(
      height: (MediaQuery.of(context).size.height - barraApp.preferredSize.height - MediaQuery.of(context).padding.top) * (esHorizontal ? 0.8 : 0.3),
      child: Grafica(_valoresAgrupadosTransacciones),
    );

    return Scaffold(
      appBar: barraApp,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (esHorizontal)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: widgetGrafica),
                  Expanded(child: widgetLista),
                ],
              ),
            if (!esHorizontal) ...[
              widgetGrafica,
              widgetLista,
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () => _empezarNuevaTransaccion(context),
      ),
    );
  }
}