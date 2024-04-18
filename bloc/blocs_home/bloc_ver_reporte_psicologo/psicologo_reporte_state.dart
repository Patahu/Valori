




import '../../../modelos/reporte.dart';

class ReportePsicologState {
  final List<Reporte> reportesNuevos;
  final List<Reporte> todosReportes;
  final bool esCargando;
  final bool esCargadoTodo;

  ReportePsicologState({
    required this.reportesNuevos,
    required this.todosReportes,
    required this.esCargando,
    required this.esCargadoTodo,
  });

  factory ReportePsicologState.empty() {
    return ReportePsicologState(
      reportesNuevos: [],
      todosReportes:[],
      esCargando: false,
      esCargadoTodo: false,
    );
  }

  ReportePsicologState copyWith({
    final List<Reporte>? reportesNuevos,
    final List<Reporte>? todosReportes,
    bool? esCargando,
    bool? esCargadoTodo,
  }) {
    return ReportePsicologState(
      reportesNuevos: reportesNuevos ?? this.reportesNuevos,
      todosReportes: todosReportes ?? this.todosReportes,
      esCargando: esCargando ?? this.esCargando,
      esCargadoTodo: esCargadoTodo ?? this.esCargadoTodo,
    );
  }

  @override
  String toString() {
    return '''
      reportesNuevos: $reportesNuevos,
      todosReportes: $todosReportes,
      esCargando: $esCargando,
      esCargadoTodo: $esCargadoTodo,
    ''';
  }
}



