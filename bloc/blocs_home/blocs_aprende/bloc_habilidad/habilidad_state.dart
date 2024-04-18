

import '../../../../modelos/habilidad.dart';

class HabilidadState {
  final bool isLoadHabilidad;
  final bool isSuccess;
  final bool isFail;
  final bool isActualizarHabilidad;
  final List<Habilidad>? habilidades;
  final Habilidad? habilidad; 

  HabilidadState({
    required this.isLoadHabilidad,
    required this.isSuccess,
    required this.isFail,
    required this.isActualizarHabilidad,
    this.habilidades,
    this.habilidad, 
  });
  HabilidadState activateSuccess() {
    return copyWith(
      isSuccess: true,
      isFail: false,

    );
  }
  HabilidadState activateFail() {
    return copyWith(
      isSuccess: false,
      isFail: true,

    );
  }
  factory HabilidadState.empty() {
    return HabilidadState(
      isLoadHabilidad: false,
      isSuccess: false,
      isFail: false,
      isActualizarHabilidad: false,
      habilidades: [],
      habilidad: Habilidad.empty(), 
    );
  }

  HabilidadState copyWith({
    bool? isLoadHabilidad,
    bool? isSuccess,
    bool? isFail,
    bool? isActualizarHabilidad,
    List<Habilidad>? habilidades,
    Habilidad? habilidad,
  }) {
    return HabilidadState(
      isLoadHabilidad: isLoadHabilidad ?? this.isLoadHabilidad,
      isSuccess: isSuccess ?? this.isSuccess,
      isFail: isFail ?? this.isFail,
      isActualizarHabilidad: isActualizarHabilidad ?? this.isActualizarHabilidad,
      habilidades: habilidades ?? this.habilidades,
      habilidad: habilidad ?? this.habilidad,
    );
  }

  HabilidadState update({
    bool? isLoadHabilidad,
    bool? isSuccess,
    bool? isFail,
    bool? isActualizarHabilidad,
    List<Habilidad>? habilidades,
    Habilidad? habilidad,
  }) {
    return copyWith(
      isLoadHabilidad: isLoadHabilidad,
      isSuccess: isSuccess,
      isFail: isFail,
      isActualizarHabilidad: isActualizarHabilidad,
      habilidades: habilidades,
      habilidad: habilidad,
    );
  }

  @override
  String toString() {
    return '''
      isLoadHabilidad: $isLoadHabilidad,
      isSuccess: $isSuccess,
      isFail: $isFail,
      isActualizarHabilidad: $isActualizarHabilidad,
      lista habilidad: ${habilidades?.length},
      habilidad: $habilidad,
    ''';
  }
}

