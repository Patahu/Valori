import '../../../../modelos/ejercicio.dart';
import '../../../../modelos/leccion.dart';
import '../../../../modelos/resume.dart';
class EjercicioState {
  final bool isFinish;
  final bool isCrearEjercicio;
  final bool isActualizarFC;
  final bool isActualizarEjercicio;
  final bool isCompletar;
  final bool isOrdenar;
  final bool isSeleccionar;
  final bool isSeleccionarAlt;
  final bool isSuccess;
  final bool isFail;
  final bool isLoad;
  final bool isAudio;
  final bool isResume; // Nuevo atributo
  final Resume? resume; // Nuevo atributo
  final List<Ejercicio>? ejercicios;
  final Ejercicio? ejercicio;
  final Map<String, String>? listaRespuestaOrdenar;

  EjercicioState({
    required this.isFinish,
    required this.isCrearEjercicio,
    required this.isActualizarFC,
    required this.isActualizarEjercicio,
    required this.isCompletar,
    required this.isOrdenar,
    required this.isSeleccionar,
    required this.isSeleccionarAlt,
    required this.isSuccess,
    required this.isFail,
    required this.isLoad,
    required this.isAudio,
    required this.isResume, // Nuevo atributo
    this.resume, // Nuevo atributo
    this.ejercicios,
    this.ejercicio,
    this.listaRespuestaOrdenar,
  });

  factory EjercicioState.empty() {
    return EjercicioState(
      isFinish: true,
      isCrearEjercicio: false,
      isActualizarFC: false,
      isActualizarEjercicio: false,
      isCompletar: false,
      isOrdenar: false,
      isSeleccionar: false,
      isSeleccionarAlt: false,
      isSuccess: false,
      isFail: false,
      isLoad: false,
      isAudio: false,
      isResume: false, // Valor por defecto para el nuevo atributo
      resume: null, // Valor por defecto para el nuevo atributo
      ejercicios: [],
      ejercicio: null,
      listaRespuestaOrdenar: {},
    );
  }

  EjercicioState copyWith({
    bool? isFinish,
    bool? isCrearEjercicio,
    bool? isActualizarFC,
    bool? isActualizarEjercicio,
    bool? isCompletar,
    bool? isOrdenar,
    bool? isSeleccionar,
    bool? isSeleccionarAlt,
    bool? isSuccess,
    bool? isFail,
    bool? isLoad,
    bool? isAudio,
    bool? isResume, // Nuevo atributo
    Resume? resume, // Nuevo atributo
    List<Ejercicio>? ejercicios,
    Ejercicio? ejercicio,
    Map<String, String>? listaRespuestaOrdenar,
  }) {
    return EjercicioState(
      isFinish: isFinish ?? this.isFinish,
      isCrearEjercicio: isCrearEjercicio ?? this.isCrearEjercicio,
      isActualizarFC: isActualizarFC ?? this.isActualizarFC,
      isActualizarEjercicio: isActualizarEjercicio ?? this.isActualizarEjercicio,
      isCompletar: isCompletar ?? this.isCompletar,
      isOrdenar: isOrdenar ?? this.isOrdenar,
      isSeleccionar: isSeleccionar ?? this.isSeleccionar,
      isSeleccionarAlt: isSeleccionarAlt ?? this.isSeleccionarAlt,
      isSuccess: isSuccess ?? this.isSuccess,
      isFail: isFail ?? this.isFail,
      isLoad: isLoad ?? this.isLoad,
      isAudio: isAudio ?? this.isAudio,
      isResume: isResume ?? this.isResume, // Nuevo atributo
      resume: resume ?? this.resume, // Nuevo atributo
      ejercicios: ejercicios ?? this.ejercicios,
      ejercicio: ejercicio ?? this.ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar ?? this.listaRespuestaOrdenar,
    );
  }

  EjercicioState update({
    bool? isFinish,
    bool? isCrearEjercicio,
    bool? isActualizarFC,
    bool? isActualizarEjercicio,
    bool? isCompletar, // Nuevo atributo
    bool? isOrdenar, // Nuevo atributo
    bool? isSeleccionar, // Nuevo atributo
    bool? isSeleccionarAlt, // Nuevo atributo
    bool? isSuccess, // Nuevo atributo
    bool? isFail, // Nuevo atributo
    bool? isLoad, // Renombrado de isLeccion a isLoad
    bool? isAudio, // Nuevo atributo
    Leccion? leccion, // Eliminado el atributo
    List<Ejercicio>? ejercicios,
    Ejercicio? ejercicio,
    Map<String, String>? listaRespuestaOrdenar, // Nuevo atributo
  }) {
    return copyWith(
      isFinish: isFinish,
      isCrearEjercicio: isCrearEjercicio,
      isActualizarFC: isActualizarFC,
      isActualizarEjercicio: isActualizarEjercicio,
      isCompletar: isCompletar, // Nuevo atributo
      isOrdenar: isOrdenar, // Nuevo atributo
      isSeleccionar: isSeleccionar, // Nuevo atributo
      isSeleccionarAlt: isSeleccionarAlt, // Nuevo atributo
      isSuccess: isSuccess, // Nuevo atributo
      isFail: isFail, // Nuevo atributo
      isLoad: isLoad, // Renombrado de isLeccion a isLoad
      isAudio: isAudio, // Nuevo atributo
      ejercicios: ejercicios,
      ejercicio: ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar,
    );
  }
  EjercicioState activateResume({Resume? resume}) {
    return EjercicioState(
      isFinish: true,
      isCrearEjercicio: false,
      isActualizarFC: false,
      isActualizarEjercicio: false,
      isCompletar: false,
      isOrdenar: false,
      isSeleccionar: false,
      isSeleccionarAlt: false,
      isSuccess: false,
      isFail: false,
      isLoad: false, // Nuevo atributo
      isAudio: false, // Nuevo atributo 
      resume: resume ?? resume,
      isResume: true,
      ejercicios: ejercicios,
      ejercicio: ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar,
    );
  }
  EjercicioState activateTime() {
    return copyWith(
      isLoad: true, // Nuevo atributo
    );
  }

  EjercicioState activateOrdenar({Ejercicio? ejercicio, Map<String, String>? listaRespuestaOrdenar}) {
    return EjercicioState(
      isFinish: false,
      isCrearEjercicio: false,
      isActualizarFC: false,
      isActualizarEjercicio: false,
      isCompletar: false,
      isOrdenar: true,
      isSeleccionar: false,
      isSeleccionarAlt: false,
      isSuccess: false,
      isFail: false,
      isLoad: false, // Nuevo atributo
      isAudio: false, // Nuevo atributo 
      resume: resume,
      isResume: false,
      ejercicios: ejercicios,
      ejercicio: ejercicio ?? this.ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar ?? this.listaRespuestaOrdenar,
    );
  }

  // Función para establecer solo isCompletar en true y el resto en false
  EjercicioState activateCompletar({Ejercicio? ejercicio, Map<String, String>? listaRespuestaOrdenar}) {
    return EjercicioState(
      isFinish: false,
      isCrearEjercicio: false,
      isActualizarFC: false,
      isActualizarEjercicio: false,
      isCompletar: true,
      isOrdenar: false,
      isSeleccionar: false,
      resume: resume,
      isResume: false,
      isSeleccionarAlt: false,
      isSuccess: false,
      isFail: false,
      isLoad: false, // Nuevo atributo
      isAudio: false, // Nuevo atributo
      ejercicios: ejercicios,
      ejercicio: ejercicio ?? this.ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar ?? this.listaRespuestaOrdenar,
    );
  }

  // Función para establecer solo isSeleccionar en true y el resto en false
  EjercicioState activateSeleccionar({Ejercicio? ejercicio, Map<String, String>? listaRespuestaOrdenar}) {
    return EjercicioState(
      isFinish: false,
      resume: resume,
      isResume: false,
      isCrearEjercicio: false,
      isActualizarFC: false,
      isActualizarEjercicio: false,
      isCompletar: false,
      isOrdenar: false,
      isSeleccionar: true,
      isSeleccionarAlt: false,
      isSuccess: false,
      isFail: false,
      isLoad: false, // Nuevo atributo
      isAudio: false, // Nuevo atributo
      ejercicios: ejercicios,
      ejercicio: ejercicio ?? this.ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar ?? this.listaRespuestaOrdenar,
    );
  }

  // Función para establecer solo isSeleccionarAlt en true y el resto en false
  EjercicioState activateSeleccionarAlt({Ejercicio? ejercicio, Map<String, String>? listaRespuestaOrdenar}) {
    return EjercicioState(
      isFinish: false,
      isCrearEjercicio: false,
      resume: resume,
      isResume: false,
      isActualizarFC: false,
      isActualizarEjercicio: false,
      isCompletar: false,
      isOrdenar: false,
      isSeleccionar: false,
      isSeleccionarAlt: true,
      isSuccess: false,
      isFail: false,
      isLoad: false, // Nuevo atributo
      isAudio: false, // Nuevo atributo
      ejercicios: ejercicios,
      ejercicio: ejercicio ?? this.ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar ?? this.listaRespuestaOrdenar,
    );
  }

  // Función para establecer solo isLeccion en true y el resto en false
  EjercicioState activateLeccion({Leccion? leccion, Ejercicio? ejercicio}) {
    return EjercicioState(
      isFinish: false,
      isCrearEjercicio: false,
      resume: resume,
      isResume: false,
      isActualizarFC: false,
      isActualizarEjercicio: false,
      isCompletar: false,
      isOrdenar: false,
      isSeleccionar: false,
      isSeleccionarAlt: false,
      isSuccess: false,
      isFail: false,
      isLoad: true,
      isAudio: false, // Nuevo atributo
      ejercicios: ejercicios,
      ejercicio: ejercicio,
      listaRespuestaOrdenar: listaRespuestaOrdenar,
    );
  }

  // Función para activar el atributo isAudio
  EjercicioState activateAudio({Ejercicio? ejercicio, Map<String, String>? listaRespuestaOrdenar}) {
    return copyWith(
    isFinish: false,
    isCrearEjercicio: false,
    isActualizarFC: false,
    isActualizarEjercicio: false,
    isCompletar: false,
    isOrdenar: false,
    isSeleccionar: false,
    isSeleccionarAlt: false,
    isSuccess: false,
    isFail: false,
    isLoad: false,
    isAudio: true,
    ejercicio: ejercicio,listaRespuestaOrdenar: listaRespuestaOrdenar);
  }

  @override
  String toString() {
    return '''
      isNewMessaging: $isFinish,
      isCrearEjercicio: $isCrearEjercicio,
      isActualizarFC: $isActualizarFC,
      isActualizarEjercicio: $isActualizarEjercicio,
      isCompletar: $isCompletar, // Nuevo atributo
      isOrdenar: $isOrdenar, // Nuevo atributo
      isSeleccionar: $isSeleccionar, // Nuevo atributo
      isSeleccionarAlt: $isSeleccionarAlt, // Nuevo atributo
      isSuccess: $isSuccess, // Nuevo atributo
      isFail: $isFail, // Nuevo atributo
      isLeccion: $isLoad, // Nuevo atributo
      isAudio: $isAudio, // Nuevo atributo
      lista ejercicios: ${ejercicios?.length},
      ejercicio: $ejercicio,
      listaRespuestaOrdenar: $listaRespuestaOrdenar, // Nuevo atributo
    ''';
  }
}
