import 'package:equatable/equatable.dart';
import 'package:valorix/src/modelos/ejercicio.dart';

import '../../../../modelos/aprende.dart';
import '../../../../modelos/leccion.dart';



abstract class EjercicioEvent extends Equatable {
  const EjercicioEvent();
  @override
  List<Object> get props => [];
}

class BuscarEjercicio extends EjercicioEvent {
  final Leccion leccion;
  const BuscarEjercicio(this.leccion);
  @override
  List<Object> get props => [leccion];
}
class reloadEjercicio extends EjercicioEvent {
}
class UpdateEjercicioToEjercicio extends EjercicioEvent {
  final Ejercicio ejercicio;
  const UpdateEjercicioToEjercicio(this.ejercicio);
  @override
  List<Object> get props => [ejercicio];
}

class UpdateEjercicioToLeccion extends EjercicioEvent {
  final String ejercicio;
  const UpdateEjercicioToLeccion(this.ejercicio);
  @override
  List<Object> get props => [ejercicio];
}

class UIngresarRespuestaOrdenar extends EjercicioEvent {
  final String key;
  final String value;
  const UIngresarRespuestaOrdenar(this.key,this.value);
  @override
  List<Object> get props => [key,value];
}

class UEliminarRespuestaOrdenar extends EjercicioEvent {
  final String idAlternativa;

  const UEliminarRespuestaOrdenar(this.idAlternativa);
  @override
  List<Object> get props => [idAlternativa];
}

class comprobarRespuestaPregunta extends EjercicioEvent {}

class IniciarAudio extends EjercicioEvent {
  final String urlAudio;
  IniciarAudio({
    required this.urlAudio,


  });

}

class UIngresarllaveAudio extends EjercicioEvent {

  final String llave;
  const UIngresarllaveAudio(this.llave);
  @override
  List<Object> get props => [llave];
}