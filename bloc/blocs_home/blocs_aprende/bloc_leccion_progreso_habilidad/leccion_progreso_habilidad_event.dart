import 'package:equatable/equatable.dart';
import 'package:valorix/src/modelos/aprende.dart';

import '../../../../modelos/leccion.dart';
import '../../../../modelos/leccion_progreso.dart';

abstract class LeccionProgresoHabilidadEvent extends Equatable {
  const LeccionProgresoHabilidadEvent();
  @override
  List<Object> get props => [];
}


class iniciarVistaHabilidadProgreso extends LeccionProgresoHabilidadEvent {
  final String idAprende;
  const iniciarVistaHabilidadProgreso(this.idAprende);
  @override
  List<Object> get props => [idAprende];


}

class BuscarHabilidadProgresoGlobal extends LeccionProgresoHabilidadEvent {

}
class comenzarComparaciones extends LeccionProgresoHabilidadEvent{}

