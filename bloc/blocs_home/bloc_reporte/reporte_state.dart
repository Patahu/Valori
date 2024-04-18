import 'package:equatable/equatable.dart';

import '../../../modelos/habilidad.dart';
import '../../../modelos/reporte.dart';
import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
// Importa la clase Usuario si aún no lo has hecho

class ReporteState  {
  final bool isLoad;
  final bool isSuccess;
  final bool isPractico;
  final bool isValor;
  final bool isDescripcion;
  final bool isAyudo;
  final List<Reporte> reportes;
  final List<Usuario> usuarios;
  final List<Habilidad> habilidades;
  final Reporte reporte; // Nuevo atributo

  ReporteState({
    required this.isLoad,
    required this.isSuccess,
    required this.reportes,
    required this.isPractico,
    required this.isAyudo,
    required this.isValor,
    required this.isDescripcion,
    required this.habilidades,
    required this.usuarios,
    required this.reporte, // Agregar el nuevo atributo
  });

  ReporteState copyWith({
    bool? isLoad,
    bool? isSuccess,
    bool? isPractico,
    bool? isAyudo,
    bool? isValor,
    bool? isDescripcion,
    List<Reporte>? reportes,
    List<Usuario>? usuarios,
    List<Habilidad>? habilidades,
 
    Reporte? reporte, // Agregar el nuevo atributo
  }) {
    return ReporteState(
      isLoad: isLoad ?? this.isLoad,
      isAyudo:isAyudo?? this.isAyudo,
      isValor:isValor?? this.isValor,
      habilidades: habilidades??this.habilidades,
      usuarios: usuarios ?? this.usuarios,
      isDescripcion: isDescripcion ?? this.isDescripcion,
      isPractico: isPractico ?? this.isPractico,
      isSuccess: isSuccess ?? this.isSuccess,
      reportes: reportes ?? this.reportes,
      reporte: reporte ?? this.reporte, // Agregar el nuevo atributo
    );
  }

  static ReporteState empty() {
    return ReporteState(
      isLoad: false,
      isPractico: false,
      isValor:false,
      isSuccess: false,
      isDescripcion:false,

      isAyudo:false,
      habilidades: [],
      reportes: [],
      usuarios: [],
      reporte: Reporte.empty(), // Valor por defecto para el nuevo atributo
    );
  }
  ReporteState activaPractico() {
    return copyWith(
   
      isDescripcion:false,
      isPractico: true,
      isValor:false,
      isSuccess: false,
      isAyudo:false,
    );

  }
  ReporteState activaAyudo(List<Usuario>? usuarios) {
    return copyWith(
      usuarios: usuarios,
      isDescripcion:false,
      isPractico: false,
      isValor:false,
      isSuccess: false,
      isAyudo:true,
    );

  }
  ReporteState activaTipo(List<Habilidad>? habilidades) {
    return copyWith(
      habilidades:habilidades ?? this.habilidades,
      isDescripcion:false,
      isPractico: false,
      isValor:true,
      isSuccess: false,
      isAyudo:false,
    );

  }

    ReporteState activaDescripcion() {
    return copyWith(
      isDescripcion:true,
      isPractico: false,
      isValor:false,
      isSuccess: false,
      isAyudo:false,
    );

  }
  ReporteState update({
    bool? isLoad,
    bool? isSuccess,
    bool? isPractico,
    bool? isAyudo,
    bool? isValor,
    bool? isDescripcion,
    List<Reporte>? reportes,
    List<Usuario>? usuarios,
    List<Habilidad>? habilidades,
    Reporte? reporte, // Agregar el nuevo atributo
  }) {
    return copyWith(
      isLoad: isLoad,
      isPractico: isPractico,
      isSuccess: isSuccess,
      reportes: reportes,
      habilidades: habilidades,
      usuarios: usuarios,
      isDescripcion:isDescripcion,
      isAyudo:isAyudo,
      isValor:isValor,
      reporte: reporte,
    );
  }

  @override
  String toString() {
    return '''ReporteState(isPractico: $isPractico
    , isLoad: $isLoad
    , isAyudo: $isAyudo
    , isResumeRanking: $isSuccess
    , isVideoResume: $reportes
    , isDescripcion: $isDescripcion
    , habilidades: ${habilidades.length}}
    , isValor: $isValor
    , resumen: $reporte)''';
  }

  @override
  List<Object?> get props => [isLoad,isPractico,isAyudo, isSuccess, reportes, reporte];
}


