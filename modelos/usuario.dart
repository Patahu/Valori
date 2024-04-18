import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Usuario extends Equatable {
  final String _uid;
  final String _correoElectronico;
  final String _apellidos;
  final bool _esAdministrador;
  final bool _esMaestro;
  final bool _esNino; 
  final bool _esPadre;
  final bool _esPsicologo;
  final Timestamp _fechaCreada;
  final String _id;
  final String _nombres;
  final int _progreso;
  final String _imagen; // Nuevo atributo _imagen de tipo String
  final int top;
  int _puesto=0;

  Usuario({
    required String uid,
    required String correoElectronico,
    required String apellidos,
    required bool esAdministrador,
    required bool esMaestro,
    required bool esNino, 
    required bool esPadre,
    required bool esPsicologo,
    required Timestamp fechaCreada,
    required String id,
    required String nombres,
    required int progreso,
    required int this.top,
    required String imagen, // Nuevo atributo _imagen de tipo String
  }) : _uid = uid,
       _correoElectronico = correoElectronico,
       _apellidos = apellidos,
       _esAdministrador = esAdministrador,
       _esMaestro = esMaestro,
       _esNino = esNino,
       _esPadre = esPadre,
       _esPsicologo = esPsicologo,
       _fechaCreada = fechaCreada,
       _id = id,
       _nombres = nombres,
       _progreso = progreso,
       _imagen = imagen; // Inicializar el atributo _imagen

  // Usuario vacío
  static final empty = Usuario(
    uid: '',
    correoElectronico: '',
    apellidos: '',
    esAdministrador: false,
    esMaestro: false,
    esNino: false,
    esPadre: false,
    esPsicologo: false,
    fechaCreada: Timestamp.now(),
    top:0,
    id: '',
    nombres: 'Usuario',
    progreso: 0,
    imagen: 'https://firebasestorage.googleapis.com/v0/b/valorixdb.appspot.com/o/ejercicio_imagen%2Favatar_1.png?alt=media&token=02edd702-0852-40cb-bb4b-192d37770807', // Asegúrate de incluir el atributo _imagen aquí
  );

  // Getters para todos los atributos incluyendo _imagen
  String get uid => _uid;
  String get correoElectronico => _correoElectronico;
  String get apellidos => _apellidos;
  bool get esAdministrador => _esAdministrador;
  bool get esMaestro => _esMaestro;
  bool get esNino => _esNino;
  bool get esPadre => _esPadre;
  bool get esPsicologo => _esPsicologo;
  Timestamp get fechaCreada => _fechaCreada;
  String get id => _id;


  String get nombres => _nombres;
  int get progreso => _progreso;
  String get imagen => _imagen; // Getter para _imagen

  factory Usuario.fromUser(User user) {
    return Usuario(
      uid: user.uid,
      correoElectronico: user.email!,
      apellidos: '',
      esAdministrador: false,
      esMaestro: false,
      esNino: false,
      top:0,
      esPadre: false,
      esPsicologo: false,
      fechaCreada: Timestamp.now(),
      id: user.uid,
      nombres: '',
      progreso: 0,
      imagen: '', // Asegúrate de incluir _imagen aquí también
    );
  }
  factory Usuario.copyR(String id,List<String> datos) {
    return Usuario(
      uid: id,
      top:0,
      correoElectronico: '',
      apellidos: '',
      esAdministrador: false,
      esMaestro: false,
      esNino: false,
      esPadre: false,
      esPsicologo: false,
      fechaCreada: Timestamp.now(),
      id: id,
      nombres: datos[0],
      progreso: 0,
      imagen: datos[1], // Asegúrate de incluir _imagen aquí también
    );
  }


  factory Usuario.fromDB(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return Usuario(

      uid: documentSnapshot.id,
      correoElectronico: '',
      apellidos: data['apellidos'] as String,
      esAdministrador: data['es_administrador'] as bool,
      esMaestro: data['es_maestro'] as bool,
      esNino: data['es_nino'] as bool,
      esPadre: data['es_padre'] as bool,
      esPsicologo: data['es_psicologo'] as bool,
      fechaCreada: data['fecha_creada'] as Timestamp,
      id: data['id'] as String,
      nombres: data['nombres'] as String,
      progreso: data['progreso'] as int,
      imagen: data['imagen'] as String, // Incluye _imagen aquí
      top:data['top'] ?? 0,
    );
  }
  
  int get puesto => _puesto;
  set puesto(int value) => _puesto = value;
  @override
  List<Object?> get props => [
    _uid,
    _correoElectronico,
    _apellidos,
    _esAdministrador,
    _esMaestro,
    _esNino,
    _esPadre,
    _esPsicologo,
    _fechaCreada,
    _id,
    _nombres,
    _progreso,
    _imagen, // Asegúrate de incluir _imagen aquí también
    top
  ];
}
