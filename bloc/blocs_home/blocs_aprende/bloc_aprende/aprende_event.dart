import 'package:equatable/equatable.dart';

import '../../../../modelos/aprende.dart';



abstract class AprendeEvent{
  const AprendeEvent();
  @override
  List<Object> get props => [];
}

class BuscarAprende extends AprendeEvent {
}
class CrearAprende extends AprendeEvent {
}

class VolverAprende extends AprendeEvent {
}

class ActualizarCFAprende extends AprendeEvent {
}

class ModificarAprende extends AprendeEvent {
  final Aprende aprende;
  const ModificarAprende(this.aprende);
  @override
  List<Object> get props => [aprende];
}

class IngresarAprende extends AprendeEvent {
  final String nombre;
  final int numero;
  final String imagen;
  const IngresarAprende(this.nombre,this.numero,this.imagen);
  @override
  List<Object> get props => [nombre,numero,imagen];
}

class ElimnarAprende extends AprendeEvent {
  final String id;

  const ElimnarAprende(this.id);
  @override
  List<Object> get props => [id];
}
class ActualizarAprende extends AprendeEvent {
  final String id;
  final String nombre;
  final int numero;
  final String imagen;
  const ActualizarAprende(this.id,this.nombre,this.numero,this.imagen);
  @override
  List<Object> get props => [nombre,numero,imagen];
}
class UpdaAprende extends AprendeEvent {
  final List<Aprende> aprenderes;
  const UpdaAprende(this.aprenderes);
  @override
  List<Object> get props => [aprenderes];
}