

import '../../../../modelos/leccion.dart';

abstract class NotificacionEvent {}




class BuscarNotificaciones extends NotificacionEvent{
}


class CambiarTodos extends NotificacionEvent{
}
class CambiarNuevas extends NotificacionEvent{
}
class UpdaNotificacionLeccion extends NotificacionEvent{

  final List<Leccion> lecciones;
  UpdaNotificacionLeccion(this.lecciones);
  @override
  List<Object> get props => [lecciones];
}