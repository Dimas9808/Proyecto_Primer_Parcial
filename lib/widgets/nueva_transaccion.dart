import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaccion.dart';

class NuevaTransaccion extends StatefulWidget {
  final Function agregarTx;

  const NuevaTransaccion(this.agregarTx, {super.key});

  @override
  State<NuevaTransaccion> createState() => _EstadoNuevaTransaccion();
}

class _EstadoNuevaTransaccion extends State<NuevaTransaccion> {
  final _controladorTitulo = TextEditingController();
  final _controladorMonto = TextEditingController();
  DateTime? _fechaSeleccionada;
  Categoria? _categoriaSeleccionada; 

  void _enviarDatos() {
    if (_controladorMonto.text.isEmpty) {
      return;
    }
    final tituloIngresado = _controladorTitulo.text;
    final montoIngresado = double.parse(_controladorMonto.text);

    if (tituloIngresado.isEmpty || montoIngresado <= 0 || _fechaSeleccionada == null || _categoriaSeleccionada == null) {
      return;
    }

    widget.agregarTx(
      tituloIngresado,
      montoIngresado,
      _fechaSeleccionada,
      _categoriaSeleccionada,
    );

    Navigator.of(context).pop();
  }

  void _mostrarSelectorFecha() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    ).then((fechaElegida) {
      if (fechaElegida == null) return;
      setState(() {
        _fechaSeleccionada = fechaElegida;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Título'),
                controller: _controladorTitulo,
                maxLength: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      controller: _controladorMonto,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _fechaSeleccionada == null
                                ? 'Fecha No Elegida'
                                : DateFormat.yMd().format(_fechaSeleccionada!),
                                textAlign: TextAlign.right,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: _mostrarSelectorFecha,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<Categoria>(
                    hint: const Text('DIVIS'),
                    value: _categoriaSeleccionada,
                    icon: const Icon(Icons.arrow_drop_down),
                    onChanged: (Categoria? nuevoValor) {
                      setState(() {
                        _categoriaSeleccionada = nuevoValor!;
                      });
                    },
                    items: const [
                      DropdownMenuItem(value: Categoria.comida, child: Text('COMIDA')),
                      DropdownMenuItem(value: Categoria.viaje, child: Text('VIAJE')),
                      DropdownMenuItem(value: Categoria.cine, child: Text('CINE')),
                      DropdownMenuItem(value: Categoria.trabajo, child: Text('TRABAJO')),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar', style: TextStyle(color: Colors.deepPurple)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade50,
                          foregroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: _enviarDatos,
                        child: const Text('Guardar Gasto'),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}