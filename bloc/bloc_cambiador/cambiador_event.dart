
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/habilidad.dart';

import '../../modelos/leccion.dart';
import '../../modelos/resume.dart';

abstract class CambiadorEvent {}

class cambiarToCardHabilidad extends CambiadorEvent{
  final Aprende aprende;
  cambiarToCardHabilidad(this.aprende);
}
class cambiarToCardLeccion extends CambiadorEvent{
  final Habilidad habilidad;
  cambiarToCardLeccion(this.habilidad);
}

class cambiarToCardLeccionGlobal extends CambiadorEvent{
  final Habilidad habilidad;
  cambiarToCardLeccionGlobal(this.habilidad);
}
class backHome extends CambiadorEvent{
}

class backHabilidades extends CambiadorEvent{}

class cambiarToCardVideo extends CambiadorEvent{
  final Leccion leccion;
  cambiarToCardVideo(this.leccion);
}

class backToCardVideo extends CambiadorEvent{}
class backLecciones extends CambiadorEvent{}

class backLeccionesGlobal extends CambiadorEvent{}
class cambiarToRanking extends CambiadorEvent{}

class cambiarToPerfil extends CambiadorEvent{}

class cambiarToInicio extends CambiadorEvent{}

class cambiarToEjercicio extends CambiadorEvent{
  final Leccion leccion;
  cambiarToEjercicio(this.leccion);

}
class cambiarToEjercicioEspecial extends CambiadorEvent{
  final Leccion leccion;
  cambiarToEjercicioEspecial(this.leccion);
}

class cambiarToNotificacion extends CambiadorEvent{}

class cambiarToResumen extends CambiadorEvent{


}

class cambiartToReporte extends CambiadorEvent{
  final String tipo;
  cambiartToReporte(this.tipo);

}

class agregarResumen extends CambiadorEvent{
  final Resume resume;
  agregarResumen(this.resume);

}