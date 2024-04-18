import '../../../../modelos/aprende.dart';
import '../../../../modelos/ejercicio.dart';

class PreguntaCrearState {
  final bool isLoadPregunta;
  final bool isSeleccionarImagen;
  final List<Ejercicio>? ejercicios;
  final bool isLoad;
  final String tipo;
  final bool isOrdenar;
  final bool isCompletar;
  final bool isAudio;
  final bool isSeleccionarAlt;
  final bool isIngresarAlternativaOrdenar;
  final List< String>? listaRespuestaOrdenar;
  final bool isLoading;

  PreguntaCrearState({
    required this.isLoadPregunta,
    required this.isSeleccionarImagen,
    required this.tipo,
    required this.isOrdenar,
    required this.isCompletar,
    required this.isAudio,
    required this.isSeleccionarAlt,
    required this.ejercicios,
    required this.listaRespuestaOrdenar,
    required this.isLoad,
    required this.isLoading,
    required this.isIngresarAlternativaOrdenar,
  });

  factory PreguntaCrearState.empty() {
    return PreguntaCrearState(
      isLoadPregunta: true,
      isSeleccionarImagen: false,
      ejercicios: [],
      tipo: 'seleccionar',
      isOrdenar: false,
      isCompletar: false,
      isAudio: false,
      isSeleccionarAlt: false,
      isLoading:false,
      listaRespuestaOrdenar: [],
      isIngresarAlternativaOrdenar:false,
      isLoad:false,
    );
  }

  PreguntaCrearState activateLoad() {
    return copyWith(
      isLoad: false,
      isSeleccionarImagen: true,
      isOrdenar: false,
      isCompletar: false,
      isAudio: false,
      isSeleccionarAlt: false,
      isLoading:false
      
    );
  }

  PreguntaCrearState activateSeleccionar() {
    return copyWith(
      isLoad: false,
      isSeleccionarImagen: true,
      isOrdenar: false,
      isCompletar: false,
      isAudio: false,
      isSeleccionarAlt: false,
      tipo: 'seleccionar',
      isLoading:false
    );
  }

  PreguntaCrearState activateOrdenar() {
    return copyWith(
      isLoad: false,
      isSeleccionarImagen: false,
      isOrdenar: true,
      isCompletar: false,
      isAudio: false,
      isSeleccionarAlt: false,
      tipo: 'ordenar',
      isLoading:false
    );
  }

  PreguntaCrearState activateCompletar() {
    return copyWith(
      isLoad: false,
      isSeleccionarImagen: false,
      isOrdenar: false,
      isCompletar: true,
      isAudio: false,
      isSeleccionarAlt: false,
      tipo: 'completar',
      isLoading:false
    );
  }

  PreguntaCrearState activateAudio() {
    return copyWith(
      isLoad: false,
      isSeleccionarImagen: false,
      isOrdenar: false,
      isCompletar: false,
      isAudio: true,
      isSeleccionarAlt: false,
      tipo: 'audio',
      isLoading:false
    );
  }

  PreguntaCrearState activateSeleccionarAlt() {
    return copyWith(
      isLoad: false,
      isSeleccionarImagen: false,
      isOrdenar: false,
      isCompletar: false,
      isAudio: false,
      isSeleccionarAlt: true,
      tipo: 'seleccionarAlt',
      isLoading:false
    );
  }

  PreguntaCrearState copyWith({
    bool? isLoadPregunta,
    bool? isSeleccionarImagen,
    bool? isOrdenar,
    bool? isCompletar,
    bool? isAudio,
    bool? isSeleccionarAlt,
    List<Ejercicio>? ejercicios,
    String? tipo,
    bool? isIngresarAlternativaOrdenar,
    List<String>? listaRespuestaOrdenar,
    bool? isLoad,
    bool? isLoading,
  }) {
    return PreguntaCrearState(
      isLoadPregunta: isLoadPregunta ?? this.isLoadPregunta,
      isSeleccionarImagen: isSeleccionarImagen ?? this.isSeleccionarImagen,
      isOrdenar: isOrdenar ?? this.isOrdenar,
      isCompletar: isCompletar ?? this.isCompletar,
      isAudio: isAudio ?? this.isAudio,
      isSeleccionarAlt: isSeleccionarAlt ?? this.isSeleccionarAlt,
      ejercicios: ejercicios ?? this.ejercicios,
      tipo: tipo ?? this.tipo,
      isLoading: isLoading ?? this.isLoading,
      isIngresarAlternativaOrdenar:isIngresarAlternativaOrdenar?? this.isIngresarAlternativaOrdenar,
      listaRespuestaOrdenar: listaRespuestaOrdenar ?? this.listaRespuestaOrdenar,
      isLoad: isLoad ?? this.isLoad,
    );
  }

  @override
  String toString() {
    return '''
      isLoadPregunta: $isLoadPregunta,
      isSeleccionarImagen: $isSeleccionarImagen,
      lista ejercicios: ${ejercicios?.length},
      tipo: $tipo,
      isOrdenar: $isOrdenar,
      isCompletar: $isCompletar,
      isAudio: $isAudio,
      isLoading: $isLoading,
      isIngresarAlternativaOrdenar: $isIngresarAlternativaOrdenar,
      isSeleccionarAlt: $isSeleccionarAlt,
      isLoad: $isLoad,
    ''';
  }
}

