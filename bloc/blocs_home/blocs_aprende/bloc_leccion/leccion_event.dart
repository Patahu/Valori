import 'package:equatable/equatable.dart';
import 'package:valorix/src/modelos/habilidad.dart';

import '../../../../modelos/aprende.dart';
import '../../../../modelos/leccion.dart';
import '../../../../modelos/usuario.dart';



abstract class LeccionEvent extends Equatable {
  const LeccionEvent();
  @override
  List<Object> get props => [];
}

class BuscarLeccion extends LeccionEvent {
  final String habilidadID;
  const BuscarLeccion(this.habilidadID);
  @override
  List<Object> get props => [habilidadID];
}

class UpdaLeccion extends LeccionEvent {
  final List<Leccion> lecciones;
  const UpdaLeccion(this.lecciones);
  @override
  List<Object> get props => [lecciones];
}
class IngresarAlternativaReto extends LeccionEvent {

  final String value;


  IngresarAlternativaReto(this.value, );

 
  @override
  List<Object> get props => [value,];
}

class CrearLeccion extends LeccionEvent {
}

class EliminarAlternativaOrdenarR extends LeccionEvent{

    final int index;

  EliminarAlternativaOrdenarR(this.index);
}
class IngresarAlternativaOrdenarReto extends LeccionEvent{}
class ReiniciarBuscarEspecial extends LeccionEvent{
  
}

class CrearLeccionEspecial extends LeccionEvent {
}


class LoadEspecialRerporteEjercicios extends LeccionEvent {
}

class LoadEspecialRerporteEjerciciosOtraVez extends LeccionEvent {
}
//VolverLeccion
class VolverLeccion extends LeccionEvent {
}
class EliminarLeccion extends LeccionEvent {
  final Leccion leccion;
  const EliminarLeccion({required this.leccion});
  @override
  List<Object> get props => [leccion];
}

class ActualizarLeccion extends LeccionEvent {

  final Leccion leccion;
  const ActualizarLeccion({required this.leccion});
  @override
  List<Object> get props => [leccion];
}


class IngresarActualizarLeccion extends LeccionEvent {

  final Leccion leccion;
  const IngresarActualizarLeccion({required this.leccion});
  @override
  List<Object> get props => [leccion];
}

class RealiarCopiaBu extends LeccionEvent {


}

class ContinuarIngresBuDB extends LeccionEvent {
  final List<Usuario> abusadores;
  const ContinuarIngresBuDB({required this.abusadores});
  @override
  List<Object> get props => [abusadores];

}


class IngresarImagenLeccion extends LeccionEvent {
  final String imagen;
  const IngresarImagenLeccion({required this.imagen});
  @override
  List<Object> get props => [imagen];
}
class IngresarDificutaldLeccion extends LeccionEvent {
  final String dificultad;
  const IngresarDificutaldLeccion({required this.dificultad});
  @override
  List<Object> get props => [dificultad];
}



class DeterTiempo extends LeccionEvent {
  final int tiempo;
  const DeterTiempo({required this.tiempo});
  @override
  List<Object> get props => [tiempo];
}


class ActualizarLeccionDB extends LeccionEvent {
  final String titulo;
  final String descripcion;
  final String enlace;
  final Habilidad habilidad;
  final String id_aptitud;
  final String imagen;
  const ActualizarLeccionDB({required this.imagen,required this.titulo,required this.descripcion,required this.enlace,required this.id_aptitud, required this.habilidad});
  @override
  List<Object> get props => [titulo,descripcion,enlace];
}

class IngresarLeccion extends LeccionEvent {
  final String titulo;
  final String descripcion;
  final String enlace;
  final Habilidad habilidad;
  final String id_aptitud;
  final String imagen;
  final String tipo;
  const IngresarLeccion({required this.tipo,required this.imagen,required this.titulo,required this.descripcion,required this.enlace,required this.id_aptitud, required this.habilidad});
  @override
  List<Object> get props => [titulo,descripcion,enlace];
}

class CargarVideo extends LeccionEvent {
  final String enlace;
  const CargarVideo({required this.enlace});
  @override
  List<Object> get props => [enlace];
}