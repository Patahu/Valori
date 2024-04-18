


import '../../../../modelos/resultado.dart';

class LeccionProgresoHabilidadState {
  final Map<String, Resultado> resultados;
  final bool esCargando;
  final bool esCargado;

  LeccionProgresoHabilidadState({
    required this.resultados,
    required this.esCargando,
    required this.esCargado,
  });

  factory LeccionProgresoHabilidadState.empty() {
    return LeccionProgresoHabilidadState(
      resultados: {},
      esCargando: true,
      esCargado: false,
    );
  }

  LeccionProgresoHabilidadState copyWith({
    Map<String, Resultado>? resultados,
    bool? esCargando,
    bool? esCargado,
  }) {
    return LeccionProgresoHabilidadState(
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



