import 'package:equatable/equatable.dart';

import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
// Importa la clase Usuario si aún no lo has hecho

class ResumeState extends Equatable {
  final bool isLoad;
  final bool isResumeRanking;
  final bool isVideoResume;
  final Usuario usuario;
  final Resume resumen; // Nuevo atributo

  ResumeState({
    required this.isLoad,
    required this.isResumeRanking,
    required this.isVideoResume,
    required this.usuario,
    required this.resumen, // Agregar el nuevo atributo
  });

  ResumeState copyWith({
    bool? isLoad,
    bool? isResumeRanking,
    bool? isVideoResume,
    Usuario? usuario,
    Resume? resumen, // Agregar el nuevo atributo
  }) {
    return ResumeState(
      isLoad: isLoad ?? this.isLoad,
      isResumeRanking: isResumeRanking ?? this.isResumeRanking,
      isVideoResume: isVideoResume ?? this.isVideoResume,
      usuario: usuario ?? this.usuario,
      resumen: resumen ?? this.resumen, // Agregar el nuevo atributo
    );
  }

  static ResumeState empty() {
    return ResumeState(
      isLoad: false,
      isResumeRanking: false,
      isVideoResume: false,
      usuario: Usuario.empty,
      resumen: Resume.empty(), // Valor por defecto para el nuevo atributo
    );
  }

  ResumeState update({
    bool? isLoad,
    bool? isResumeRanking,
    bool? isVideoResume,
    Usuario? usuario,
    Resume? resumen, // Agregar el nuevo atributo
  }) {
    return copyWith(
      isLoad: isLoad,
      isResumeRanking: isResumeRanking,
      isVideoResume: isVideoResume,
      usuario: usuario,
      resumen: resumen,
    );
  }

  @override
  String toString() {
    return 'ResumeState(isLoad: $isLoad, isResumeRanking: $isResumeRanking, isVideoResume: $isVideoResume, usuario: $usuario, resumen: $resumen)';
  }

  @override
  List<Object?> get props => [isLoad, isResumeRanking, isVideoResume, usuario, resumen];
}


