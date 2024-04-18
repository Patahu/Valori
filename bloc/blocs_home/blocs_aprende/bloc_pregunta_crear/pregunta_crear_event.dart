import 'package:equatable/equatable.dart';

import '../../../../modelos/aprende.dart';
import '../../../../modelos/ejercicio.dart';
import '../../../../modelos/leccion.dart';



abstract class PreguntarCrearEvent{
  const PreguntarCrearEvent();
  @override
  List<Object> get props => [];
}


class CrearPreguntaSeleccionarImagen extends PreguntarCrearEvent {
}
class CrearOrdenarPregunta extends PreguntarCrearEvent {
}
class AgregarImagenes extends PreguntarCrearEvent {
  final String pregunta;

  AgregarImagenes(this.pregunta);
}
class AgregarAudios extends PreguntarCrearEvent {
  final String pregunta;
  final List<String> pares;

  AgregarAudios(this.pregunta,this.pares);
}
class AgregarPreguntaLeccionDB extends PreguntarCrearEvent {
    final String pregunta;

  AgregarPreguntaLeccionDB(this.pregunta);
}



class AgregarPreguntaLeccionOrdenar extends PreguntarCrearEvent {
    final String pregunta;
    final String respuestaCorrecta;
    final String a1;
    final String a2;
    final String opcional;

  AgregarPreguntaLeccionOrdenar(this.pregunta,this.respuestaCorrecta,this.a1,this.a2,this.opcional);
}



class AgregarPreguntaLeccionSeleccionAlt extends PreguntarCrearEvent {
    final String pregunta;
    final String respuestaCorrecta;
    final String a1;
    final String a2;
    final String descripcion;

  AgregarPreguntaLeccionSeleccionAlt(this.pregunta,this.respuestaCorrecta,this.a1,this.a2,this.descripcion);
}

class IngresarAlternativa extends PreguntarCrearEvent {
  final String key;
  final String value;
  final bool isRespuesta;

  IngresarAlternativa(this.key, this.value, this.isRespuesta);

 
  @override
  List<Object> get props => [key,value,isRespuesta];
}
class IngresarAlternativaOrdenar extends PreguntarCrearEvent {

}

class EliminarAlternativaOrdenar extends PreguntarCrearEvent {
  final int index;

  EliminarAlternativaOrdenar(this.index);

}


class CrearCompletarPregunta extends PreguntarCrearEvent {
}
class CrearAudioPregunta extends PreguntarCrearEvent {
}
class CrearSeleccionarAlt extends PreguntarCrearEvent {
}
class VolverPreguntasCrear extends PreguntarCrearEvent {
}


class CambiarTipoPregunta extends PreguntarCrearEvent {
  final String tipo;

  const CambiarTipoPregunta(this.tipo);
  @override
  List<Object> get props => [tipo];
}


class IngresarLeccionToEjercicios extends PreguntarCrearEvent {
  final Leccion leccion;
 

  const IngresarLeccionToEjercicios(this.leccion);
  @override
  List<Object> get props => [leccion];
}


class UpdaEjercicios extends PreguntarCrearEvent {
  final List<Ejercicio> ejercicios;
  const UpdaEjercicios(this.ejercicios);
  @override
  List<Object> get props => [ejercicios];
}

class InitialLoadEjercicios extends PreguntarCrearEvent {
  final String id;

  const InitialLoadEjercicios(this.id);
  @override
  List<Object> get props => [id];
}


class EliminarPregunta extends PreguntarCrearEvent {
  final String id;

  const EliminarPregunta(this.id);
  @override
  List<Object> get props => [id];
}
class SumarRestarCantidadRepeteciciones extends PreguntarCrearEvent {
  final String id;
  final int cantidad;
  const SumarRestarCantidadRepeteciciones(this.id,this.cantidad);
  @override
  List<Object> get props => [id];
}

