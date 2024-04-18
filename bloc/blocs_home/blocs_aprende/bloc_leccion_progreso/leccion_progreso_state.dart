


import '../../../../modelos/resultado.dart';

class LeccionProgresoState {
  final Map<String, Resultado> resultados;
  final bool esCargando;
  final bool esCargado;

  LeccionProgresoState({
    required this.resultados,
    required this.esCargando,
    required this.esCargado,
  });

  factory LeccionProgresoState.empty() {
    return LeccionProgresoState(
      resultados: {},
      esCargando: true,
      esCargado: false,
    );
  }

  LeccionProgresoState copyWith({
    Map<String, Resultado>? resultados,
    bool? esCargando,
    bool? esCargado,
  }) {
    return LeccionProgresoState(
      resultados: resultados ?? this.resultados,
      esCargando: esCargando ?? this.esCargando,
      esCargado: esCargado ?? this.esCargado,
    );
  }

  @override
  String toString() {
    return '''
      resultados: $resultados,
      esCargando: $esCargando,
      esCargado: $esCargado,
    ''';
  }
}



