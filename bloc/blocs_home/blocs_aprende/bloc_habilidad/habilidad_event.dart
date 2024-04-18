




import '../../../../modelos/habilidad.dart';

abstract class HabilidadEvent{
  const HabilidadEvent();
  @override
  List<Object> get props => [];
}

class BuscarHabilidad extends HabilidadEvent {
  final String idDocumento;
  const BuscarHabilidad(this.idDocumento);
}


class BuscarHabilidadGlobal extends HabilidadEvent {

}
class CrearHabilidad extends HabilidadEvent {

}


class IngresarImageHabilidad extends HabilidadEvent {
  final String url;
  const IngresarImageHabilidad(this.url);
  @override
  List<Object> get props => [url];
}
class ModificarHabilidad extends HabilidadEvent {

  final Habilidad habilidad;
  const ModificarHabilidad(this.habilidad);
  @override
  List<Object> get props => [habilidad];
}

class IngresarHabilidad extends HabilidadEvent {
  final String nombre;
  final String id_aptitud;
  final String imagen;
  const IngresarHabilidad({required this.nombre,required this.id_aptitud,required this.imagen});
  @override
  List<Object> get props => [nombre,id_aptitud,imagen];
}

class ElimnarHabilidad extends HabilidadEvent {
  final String id;

  const ElimnarHabilidad(this.id);
  @override
  List<Object> get props => [id];
}
class ActualizarHabilidad extends HabilidadEvent {
  final String id;
  final String nombre;

  final String imagen;
  const ActualizarHabilidad({required this.id,required this.nombre,required this.imagen});
  @override
  List<Object> get props => [nombre,imagen];
}
class UpdaHabilidad extends HabilidadEvent {
  final List<Habilidad> habilidades;
  const UpdaHabilidad(this.habilidades);
  @override
  List<Object> get props => [habilidades];
}

