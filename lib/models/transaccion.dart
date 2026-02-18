enum Categoria { comida, cine, viaje, trabajo }

class Transaccion {
  final String id;
  final String titulo;
  final double monto;
  final DateTime fecha;
  final Categoria categoria;

  Transaccion({
    required this.id,
    required this.titulo,
    required this.monto,
    required this.fecha,
    required this.categoria,
  });
}