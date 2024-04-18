import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

class Ejercicio {
  final String alcance;
  Map<String, String> _alternativas;
  final String idEjercicio;
  final String idLeccion;

  final String pregunta;
  final String respuesta;
  final String tipo;
  final int repeticion;
  final String imagenFuera;
  final String descripcion;

  List<int> _numeroOrden=[0,0]; // Nuevo atributo

  Ejercicio({
    required this.alcance,
    required Map<String, String> alternativas,
    required this.idEjercicio,
    required this.idLeccion,

    required this.pregunta,
    required this.respuesta,
    required this.tipo,
    required this.imagenFuera,
    required this.descripcion,
    required this.repeticion

  }) : _alternativas = alternativas;

  factory Ejercicio.fromDB(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    return Ejercicio(
      alcance: data['alcance'] ?? '',
      alternativas: Map<String, String>.from(data['alternativas'] ?? {}),
      idEjercicio: documentSnapshot.id,
      idLeccion: data['id_leccion'] ?? '',
      pregunta: data['pregunta'] ?? '',
      respuesta: data['respuesta'] ?? '',
      tipo: data['tipo'] ?? '',
      repeticion: data['repeticion'] ?? 1,
      imagenFuera: data['imagenFuera'] ?? '',
      descripcion: data['descripcion'] ?? '',
// Nuevo atributo
    );
  }
  Map<String, String>  get alternativas=> _alternativas;
  set alternativas(Map<String, String> value) {
    _alternativas = value;
  }
  List<int>  get numeroOrden => _numeroOrden;
  set numeroOrden(List<int> value) {
    _numeroOrden = value;
  }

  factory Ejercicio.empty() {
    return Ejercicio(
      alcance: '',
      alternativas: {},
      idEjercicio: '',
      idLeccion: '',
      repeticion: 1,
      pregunta: '',
      respuesta: '',
      tipo: '',
      descripcion: '',
      imagenFuera: ''
    );
  }

  @override
  String toString() {
    return '''
      Alcance: $alcance,
      Alternativas: $_alternativas,
      ID Ejercicio: $idEjercicio,
      ID Lección: $idLeccion,

      Pregunta: $pregunta,
      Respuesta: $respuesta,
      Tipo: $tipo,

      Número de Orden: $_numeroOrden, // Nuevo atributo
    ''';
  }
}
