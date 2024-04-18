
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/habilidad.dart';

import '../../modelos/leccion.dart';
import '../../modelos/resume.dart';

class CambiadorState {
    final bool es_aprende;
    final bool es_home; // *
    final bool es_habilidad;
    final bool es_leccion;
    final bool es_video; // Nuevo atributo
    final bool es_perfil; // *
    final bool es_ranking; // *
    final bool es_ejercicio; // Nuevo atributo
    final bool es_leccion_global; // Nuevo atributo
    final bool es_notificacion; // Nuevo atributo
    final bool es_resume; // Nuevo atributo
    final bool es_reporte_valor;
    final String tipo_reporte_valor;
    final Habilidad? habilidad;
    final Aprende? aprende;
    final Leccion? leccion;
    final int currentIndex; // Nuevo atributo
    final List<Resume>? resume; // Nuevo atributo

    CambiadorState({
      required this.es_aprende,
      required this.es_home,
      required this.es_habilidad,
      required this.es_leccion,
      required this.es_video, // Nuevo atributo
      required this.es_perfil, // Nuevo atributo
      required this.es_ranking, // Nuevo atributo
      required this.es_ejercicio, // Nuevo atributo
      required this.es_leccion_global, // Nuevo atributo
      required this.es_notificacion, // Nuevo atributo
      required this.es_resume, // Nuevo atributo
      required this.es_reporte_valor,
      required this.tipo_reporte_valor,
      this.habilidad,
      this.aprende,
      this.leccion,
      required this.currentIndex, // Nuevo atributo
      this.resume , // Nuevo atributo
    });

    factory CambiadorState.empty() {
      return CambiadorState(
        es_aprende: false,
        tipo_reporte_valor:'',
        es_home: true,
        es_habilidad: false,
        es_reporte_valor: false,
        es_leccion: false,
        es_video: false, // Valor por defecto para el nuevo atributo
        es_perfil: false, // Valor por defecto para el nuevo atributo
        es_ranking: false, // Valor por defecto para el nuevo atributo
        es_ejercicio: false, // Valor por defecto para el nuevo atributo
        es_leccion_global: false, // Valor por defecto para el nuevo atributo
        es_notificacion: false, // Valor por defecto para el nuevo atributo
        es_resume: false, // Valor por defecto para el nuevo atributo
        habilidad: Habilidad.empty(),
        aprende: Aprende.empty(),
        leccion: Leccion.empty(),
        currentIndex: 0, // Valor por defecto para el nuevo atributo
        resume: [], // Valor por defecto para el nuevo atributo
      );
    }

    CambiadorState copyWith({
      bool? es_aprende,
      bool? es_home,
      bool? es_habilidad,
      bool? es_leccion,
      bool? es_video, // Nuevo atributo
      bool? es_perfil, // Nuevo atributo
      bool? es_ranking, // Nuevo atributo
      bool? es_ejercicio, // Nuevo atributo
      bool? es_leccion_global, // Nuevo atributo
      bool? es_notificacion, // Nuevo atributo
      bool? es_resume, // Nuevo atributo
      bool? es_reporte_valor,
      String? tipo_reporte_valor,
      Habilidad? habilidad,
      Aprende? aprende,
      Leccion? leccion,
      int? currentIndex, // Nuevo atributo
      List<Resume>? resume, // Nuevo atributo
    }) {
      return CambiadorState(
        es_aprende: es_aprende ?? this.es_aprende,
        es_home: es_home ?? this.es_home,
        es_habilidad: es_habilidad ?? this.es_habilidad,
        es_leccion: es_leccion ?? this.es_leccion,
        es_video: es_video ?? this.es_video, // Nuevo atributo
        es_perfil: es_perfil ?? this.es_perfil, // Nuevo atributo
        es_ranking: es_ranking ?? this.es_ranking, // Nuevo atributo
        es_ejercicio: es_ejercicio ?? this.es_ejercicio, // Nuevo atributo
        es_leccion_global: es_leccion_global ?? this.es_leccion_global, // Nuevo atributo
        es_notificacion: es_notificacion ?? this.es_notificacion, // Nuevo atributo
        es_resume: es_resume ?? this.es_resume, // Nuevo atributo
        habilidad: habilidad ?? this.habilidad,
        aprende: aprende ?? this.aprende,
        leccion: leccion ?? this.leccion,
        currentIndex: currentIndex ?? this.currentIndex, // Nuevo atributo
        resume: resume ?? this.resume, // Nuevo atributo
        es_reporte_valor: es_reporte_valor ?? this.es_reporte_valor,
        tipo_reporte_valor: tipo_reporte_valor ?? this.tipo_reporte_valor
      );
    }

    CambiadorState update({
      bool? es_aprende,
      bool? es_home,
      bool? es_habilidad,
      bool? es_leccion,
      bool? es_video, // Nuevo atributo
      bool? es_perfil, // Nuevo atributo
      bool? es_ranking, // Nuevo atributo
      bool? es_ejercicio, // Nuevo atributo
      bool? es_leccion_global, // Nuevo atributo
      bool? es_notificacion, // Nuevo atributo
      bool? es_resume, // Nuevo atributo
      bool? es_reporte_valor,
      String? tipo_reporte_valor,
      Habilidad? habilidad,
      Aprende? aprende,
      Leccion? leccion,
      int? currentIndex, // Nuevo atributo
      List<Resume>? resume, // Nuevo atributo
    }) {
      return copyWith(
        es_aprende: es_aprende,
        es_home: es_home,
        es_habilidad: es_habilidad,
        es_leccion: es_leccion,
        es_video: es_video, // Nuevo atributo
        es_perfil: es_perfil, // Nuevo atributo
        es_ranking: es_ranking, // Nuevo atributo
        es_ejercicio: es_ejercicio, // Nuevo atributo
        es_leccion_global: es_leccion_global, // Nuevo atributo
        es_notificacion: es_notificacion, // Nuevo atributo
        es_resume: es_resume, // Nuevo atributo
        habilidad: habilidad,
        aprende: aprende,
        leccion: leccion,
        currentIndex: currentIndex, // Nuevo atributo
        es_reporte_valor: es_reporte_valor,
        resume: resume, // Nuevo atributo
        tipo_reporte_valor: tipo_reporte_valor,
      );
    }

  CambiadorState activateAprende({Habilidad? habilidad, Leccion? leccion}) {
    return CambiadorState(
      es_aprende: true,
      es_reporte_valor: false,
      es_home: false,
      es_habilidad: false,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad ?? this.habilidad,
      aprende: aprende ?? this.aprende,
      leccion: leccion ?? this.leccion,
      tipo_reporte_valor: tipo_reporte_valor,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }
  CambiadorState activateResume({List<Resume>? resumen}) {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_habilidad: false,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: true, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: true, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      resume: resumen ?? resume,
      aprende: aprende,
      leccion: leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }
  CambiadorState activateHome() {
    return CambiadorState(
      es_aprende: false,
      es_home: true,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_habilidad: false,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende,
      leccion: leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }
  
  CambiadorState activateRanking() {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_habilidad: false,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: true, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende,
      leccion: leccion,
      currentIndex: 1, // Valor por defecto para el nuevo atributo
    );
  }

  CambiadorState activateHabilidad({Aprende? aprende, Leccion? leccion}) {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_habilidad: true,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende ?? this.aprende,
      leccion: leccion ?? this.leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }
  CambiadorState activateReporteValor({String? tipoReporte}) {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_habilidad: false,
      es_reporte_valor: true,
      tipo_reporte_valor:tipoReporte ?? tipo_reporte_valor,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende ?? this.aprende,
      leccion: leccion ?? this.leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }

  CambiadorState activateLeccion({Habilidad? habilidad, Aprende? aprende}) {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_habilidad: false,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_leccion: true,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad ?? this.habilidad,
      aprende: aprende ?? this.aprende,
      leccion: leccion ?? this.leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }

  CambiadorState activateVideo({Leccion? leccion}) {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_habilidad: false,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_leccion: false,
      es_video: true, // Nuevo valor para el atributo es_video
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende,
      leccion: leccion ?? this.leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }

  CambiadorState activatePerfil() {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_habilidad: false,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: true,
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende,
      leccion: leccion,
      currentIndex: 2, // Valor por defecto para el nuevo atributo
    );
  }


  CambiadorState activateEjercicio({Leccion? leccion}) {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_habilidad: false,
      es_reporte_valor: false,
      es_leccion: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: true, // Nuevo valor para el atributo es_ejercicio
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende,
      leccion: leccion ?? this.leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }
  CambiadorState activateNotificacion(Habilidad? habilidad) {
    return CambiadorState(
      es_aprende: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_home: false,
      es_habilidad: false,
      es_reporte_valor: false,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Nuevo valor para el atributo es_ejercicio
      es_leccion_global: false, // Valor por defecto para el nuevo atributo
      es_notificacion: true, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad,
      aprende: aprende,
      leccion: leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }
  CambiadorState activateLeccionGlobal({bool? es_leccion_global, Habilidad? habilidad}) {
    return CambiadorState(
      es_aprende: false,
      es_home: false,
      es_habilidad: false,
      es_reporte_valor: false,
      tipo_reporte_valor: tipo_reporte_valor,
      es_leccion: false,
      es_video: false, // Valor por defecto para el nuevo atributo
      es_perfil: false, // Valor por defecto para el nuevo atributo
      es_ranking: false, // Valor por defecto para el nuevo atributo
      es_ejercicio: false, // Valor por defecto para el nuevo atributo
      es_leccion_global: es_leccion_global ?? this.es_leccion_global,
      es_notificacion: false, // Valor por defecto para el nuevo atributo
      es_resume: false, // Valor por defecto para el nuevo atributo
      habilidad: habilidad ?? this.habilidad,
      aprende: aprende,
      leccion: leccion,
      currentIndex: 0, // Valor por defecto para el nuevo atributo
    );
  }

  @override
  String toString() {
    return '''
      es_aprende: $es_aprende,
      es_home: $es_home,
      es_habilidad: $es_habilidad,
      es_reporte_valor: $es_reporte_valor,
      tipo_reporte_valor: $tipo_reporte_valor,
      es_leccion: $es_leccion,
      es_video: $es_video, // Nuevo atributo
      es_perfil: $es_perfil, // Nuevo atributo
      es_ranking: $es_ranking, // Nuevo atributo
      es_ejercicio: $es_ejercicio, // Nuevo atributo
      es_leccion_global: $es_leccion_global, // Nuevo atributo
      es_notificacion: $es_notificacion, // Nuevo atributo
      es_resume: $es_resume, // Nuevo atributo
      habilidad: $habilidad,
      aprende: $aprende,
      leccion: $leccion,
      currentIndex: $currentIndex, // Nuevo atributo
    ''';
  }
}

