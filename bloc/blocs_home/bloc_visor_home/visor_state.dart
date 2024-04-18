import 'package:equatable/equatable.dart';

import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';

class VisorState extends Equatable {
  final bool isHome;
  final bool isRanking;
  final bool isPerfil; // Nuevo atributo
  final bool isNone; // Nuevo atributo

  VisorState({
    required this.isHome,
    required this.isRanking,
    required this.isPerfil,
    required this.isNone, // Incluir el nuevo atributo en el constructor
  });

  VisorState copyWith({
    bool? isHome,
    bool? isRanking,
    bool? isPerfil,
    bool? isNone, // Permitir la modificación del nuevo atributo
  }) {
    return VisorState(
      isHome: isHome ?? this.isHome,
      isRanking: isRanking ?? this.isRanking,
      isPerfil: isPerfil ?? this.isPerfil,
      isNone: isNone ?? this.isNone, // Incluir el nuevo atributo en la copia
    );
  }

  static VisorState empty() {
    return VisorState(
      isHome: true,
      isRanking: false,
      isPerfil: false,
      isNone: false,
    );
  }

  VisorState update({
    bool? isHome,
    bool? isRanking,
    bool? isPerfil,
    bool? isNone, // Permitir la modificación del nuevo atributo
  }) {
    return copyWith(
      isHome: isHome,
      isRanking: isRanking,
      isPerfil: isPerfil,
      isNone: isNone, // Incluir el nuevo atributo en la actualización
    );
  }

  VisorState activaHome() {
    return VisorState(
      isHome: true,
      isRanking: false,
      isPerfil: false,
      isNone: false,
    );
  }
  VisorState activaRanking() {
    return VisorState(
      isHome: false,
      isRanking: true,
      isPerfil: false,
      isNone: false,
    );
  }
  VisorState activaPerfil() {
    return VisorState(
      isHome: false,
      isRanking: false,
      isPerfil: true,
      isNone: false,
    );
  }

  VisorState activaNone() {
    return VisorState(
      isHome: false,
      isRanking: false,
      isPerfil: false,
      isNone: true,
    );
  }

  @override
  String toString() {
    return 'VisorState(isHome: $isHome, isRanking: $isRanking, isPerfil: $isPerfil, isNone: $isNone)';
  }

  @override
  List<Object?> get props => [isHome, isRanking, isPerfil, isNone]; // Incluir el nuevo atributo en la lista de props
}