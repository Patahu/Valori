import '../../../../modelos/leccion.dart';
class LeccionState {
  final bool isLoadLeccion;
  final bool isCrearLeccion;
  final bool isLoadVideo;
  final bool isCanCreate;
  final bool isActualizarLeccion; // Nuevo atributo
  final bool success;
  final bool fail;
  final List<Leccion> lecciones;
  final Leccion leccion;
  final Leccion leccionCM;
  final List< String> listaRespuestaOrdenar;
  final bool isIngresarAlternativaOrdenar;

  LeccionState({
    required this.isLoadLeccion,
    required this.isCrearLeccion,
    required this.isLoadVideo,
    required this.isCanCreate,
    required this.isActualizarLeccion, // Incluimos el nuevo atributo en el constructor
    required this.success,
    required this.fail,
    required this.leccionCM,
    required this.listaRespuestaOrdenar,
    required this.isIngresarAlternativaOrdenar,
    required this.lecciones,
    required this.leccion,

  });

  factory LeccionState.empty() {
    return LeccionState(
      isLoadLeccion: false,
      isCrearLeccion: false,
      isLoadVideo: false,
      isIngresarAlternativaOrdenar:false,
      isCanCreate: false,
      isActualizarLeccion: false, // Incluimos el nuevo atributo en el constructor vacío
      success: false,
      fail: false,
      listaRespuestaOrdenar:[],
      lecciones: [],
      leccion: Leccion.empty(),
      leccionCM:Leccion.empty(),
    );
  }

  LeccionState copyWith({
    bool? isLoadLeccion,
    bool? isCrearLeccion,
    bool? isLoadVideo,
    bool? isCanCreate,
    bool? isActualizarLeccion, // Permitimos la modificación del nuevo atributo
    bool? success,
    bool? fail,
    List<Leccion>? lecciones,
    Leccion? leccion,
    Leccion? leccionCM,
    List< String>? listaRespuestaOrdenar,
    bool? isIngresarAlternativaOrdenar,

  }) {
    return LeccionState(
      isIngresarAlternativaOrdenar:isIngresarAlternativaOrdenar?? this.isIngresarAlternativaOrdenar,
      listaRespuestaOrdenar: listaRespuestaOrdenar ?? this.listaRespuestaOrdenar,
      isLoadLeccion: isLoadLeccion ?? this.isLoadLeccion,
      isCrearLeccion: isCrearLeccion ?? this.isCrearLeccion,
      isLoadVideo: isLoadVideo ?? this.isLoadVideo,
      isCanCreate: isCanCreate ?? this.isCanCreate,
      isActualizarLeccion: isActualizarLeccion ?? this.isActualizarLeccion, // Incluimos el nuevo atributo en el método copyWith
      success: success ?? this.success,
      fail: fail ?? this.fail,
      lecciones: lecciones ?? this.lecciones,
      leccion: leccion ?? this.leccion,
      leccionCM: leccionCM ?? this.leccionCM,
    );
  }



  LeccionState successActivate() {
    return copyWith(
      success: true,
      fail: false,
      isLoadVideo:false,
      isCanCreate:false,


    );
  }
//isLoadLeccion: true, lecciones: leccionesVer,leccion: leccionCaido
    LeccionState activateLoadLecciones({Leccion? leccion,List<Leccion>? leccionesVer, required bool isLoadLeccion}) {
    return copyWith(
      leccion: leccion ?? leccion,
      lecciones:leccionesVer ?? lecciones ,
      isLoadLeccion:true,

    );
  }
  LeccionState activateActualizarLeccion({Leccion? leccionCM,List<String>? pasos}) {
    return copyWith(
      success: false,
      fail: false,
      isActualizarLeccion: true,
      isCrearLeccion: false,
      leccionCM: leccionCM,
      isLoadVideo: false,
      isCanCreate: false,
      listaRespuestaOrdenar:pasos,
    );
  }
  LeccionState activateCrearLeccion({Leccion? leccionCM}) {
    return copyWith(
      success: false,
      fail: false,
      isActualizarLeccion: false,
      isCrearLeccion: true,
      leccionCM: leccionCM,
      isLoadVideo: false,
      isCanCreate: false,
      listaRespuestaOrdenar:[],
    );
  }

  LeccionState failActivate() {
    return copyWith(success: false, fail: true);
  }

  @override
  String toString() {
    return '''
      isLoadLeccion: $isLoadLeccion,
      isCrearLeccion: $isCrearLeccion,
      isLoadVideo: $isLoadVideo,
      listaRespuestaOrdenar: $listaRespuestaOrdenar
      isCanCreate: $isCanCreate,
      isActualizarLeccion: $isActualizarLeccion,
      success: $success,
      fail: $fail,
      lista lecciones: ${lecciones.length},
      leccion: $leccion,
      isIngresarAlternativaOrdenar: $isIngresarAlternativaOrdenar
    ''';
  }
}
