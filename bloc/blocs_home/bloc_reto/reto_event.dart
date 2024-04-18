import '../../../modelos/leccion.dart';
import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';

abstract class RetoEvent {}



class inicarReto extends RetoEvent{
  final Leccion leccion;
  final int color;

  inicarReto(this.leccion,this.color);
}

class siguienteRetoPasos extends RetoEvent{
 
}

class siguienteRetoAmigos extends RetoEvent{
 
}

class siguienteIngresarFoto extends RetoEvent{
 
}
//AgregarImagenes
class agregarImagenReto extends RetoEvent{


 
}

class ingresarFotoReto extends RetoEvent{
  final String imagen;

  ingresarFotoReto(this.imagen);
 
}
class ingresarUsuarioRetoParticipo extends RetoEvent{
  final int index;

  ingresarUsuarioRetoParticipo(this.index);
}