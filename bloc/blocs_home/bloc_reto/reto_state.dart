import 'package:equatable/equatable.dart';

import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';

class RetoState {
  final bool esPrimer;
  final bool esPasos;
  final bool esAmigos;
  final bool esFoto;
  final bool success;
  final List<Usuario> usuarios;


  RetoState({
    required this.esPrimer,
    required this.usuarios,
    required this.esPasos,
    required this.esAmigos,
    required this.esFoto,
    required this.success,
  });

  RetoState copyWith({
    bool? esPrimer,
    bool? esPasos,
    bool? esAmigos,
    bool? esFoto,
    bool? success,
    List<Usuario>? usuarios,

  }) {
    return RetoState(
      esPasos: esPasos ?? this.esPasos,
      success: success ?? this.success,
      esFoto: esFoto ?? this.esFoto,
      esAmigos: esAmigos ?? this.esAmigos,
      esPrimer: esPrimer ?? this.esPrimer,
      usuarios: usuarios ?? this.usuarios,

    );
  }

  static RetoState empty() {
    return RetoState(
      esPrimer: true,
      esFoto: false,
      usuarios: [],
      esPasos:false,
      esAmigos: false,
      success:false

    );
  }

  RetoState update({
    bool? esPrimer,
    bool? esPasos,
    bool? esAmigos,
    bool? esFoto,
    bool? success,
    List<Usuario>? usuarios,

  }) {
    return copyWith(
      esPasos:esPasos,
      esFoto:esFoto,
      esPrimer: esPrimer,
      usuarios: usuarios,
      success:success,
      esAmigos: esAmigos

    );
  }

  @override
  String toString() {
    return 'RetoState(success:$success esFoto: $esFoto esPrimer: $esPrimer, usuarios: $usuarios esPasos: $esPasos esAmigos: $esAmigos)';
  }

  @override
  List<Object?> get props => [esPrimer, usuarios,esPasos,esAmigos,esFoto]; // Incluir el nuevo atributo en la lista de props
}