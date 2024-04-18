import 'package:equatable/equatable.dart';
import 'package:valorix/src/modelos/aprende.dart';

import '../../../../modelos/leccion.dart';
import '../../../../modelos/leccion_progreso.dart';

abstract class LeccionProgresoEvent extends Equatable {
  const LeccionProgresoEvent();
  @override
  List<Object> get props => [];
}


class iniciarVistaProgreso extends LeccionProgresoEvent {

}


class comenzarComparaciones extends LeccionProgresoEvent{}

