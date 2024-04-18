import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Leccion {
  final String nombre;
  final String id;
  final String imagen;
  final String duracion_video;
  final String id_aptitud;
  final String id_habilidad;
  final Timestamp fecha_ingresada; // Cambiado a tipo Timestamp
  final String descripcion;
  final String video;
  final bool es_pregunta;
  final List<String> pasos; // Nuevo atributo
  bool _fue_echoo = false;
  bool _fue_visto = false;
  int _numero_pregunta=0;
  int _numero_pregunta1=0;
  
  int _index = 0;
  int _indexTemporal=0;
  final String alcance;
  final bool es_video;
  final String dificultad; // Nueva variable final

  Leccion({
    required this.nombre,
    required this.imagen,
    required this.id,
    required this.duracion_video,
    required this.id_aptitud,
    required this.id_habilidad,
    required this.fecha_ingresada, // Cambiado a tipo Timestamp
    required this.descripcion, // Nuevo atributo
    required this.video,
    required this.es_pregunta,
    required this.pasos, 
    required this.alcance,// Nuevo atributo
    required this.es_video,
    required this.dificultad, // Nueva variable final
  });

  // Función para crear una instancia de Leccion vacía
  factory Leccion.empty() {
    return Leccion(
      nombre: '',
      imagen: '',
      id: '',
      duracion_video: '',
      id_aptitud: '',
      id_habilidad: '',
      fecha_ingresada: Timestamp.now(),
      descripcion: '',
      video: '',
      es_pregunta: false,
      pasos: [], // Map vacío
      alcance: 'global',
      es_video: false,
      dificultad: 'Fácil', // Valor por defecto de la dificultad
    );
  }
  factory Leccion.copyFromImID(Leccion other, String idRe) {
   Leccion nuevaLeccion =
    Leccion(
      nombre: other.nombre,
      imagen: other.imagen,
      id:idRe,
      duracion_video: other.duracion_video,
      id_aptitud: other.id_aptitud,
      id_habilidad: other.id_habilidad,
      fecha_ingresada: other.fecha_ingresada,
      descripcion: other.descripcion,
      video: other.video,
      es_pregunta: other.es_pregunta,
      pasos: other.pasos, // Map vacío
      alcance: other.alcance,
      es_video: other.es_video,
      dificultad: other.dificultad, // Se conserva la dificultad original
      
      
    );
    nuevaLeccion.indexTemporal = other.indexTemporal;
    return nuevaLeccion;
    
  }


  factory Leccion.copyFromIm(Leccion other, String imagen) {
   Leccion nuevaLeccion =
    Leccion(
      nombre: other.nombre,
      imagen: imagen,
      id: other.id,
      duracion_video: other.duracion_video,
      id_aptitud: other.id_aptitud,
      id_habilidad: other.id_habilidad,
      fecha_ingresada: other.fecha_ingresada,
      descripcion: other.descripcion,
      video: other.video,
      es_pregunta: other.es_pregunta,
      pasos: other.pasos, // Map vacío
      alcance: other.alcance,
      es_video: other.es_video,
      dificultad: other.dificultad, // Se conserva la dificultad original
      
      
    );
    nuevaLeccion.indexTemporal = other.indexTemporal;
    return nuevaLeccion;
    
  }

  factory Leccion.copyFromID(Leccion other, String id) {
    Leccion nuevaLeccion = Leccion(
      nombre: other.nombre,
      imagen: other.imagen,
      
      id: id,
      duracion_video: other.duracion_video,
      id_aptitud: other.id_aptitud,
      id_habilidad: other.id_habilidad,
      fecha_ingresada: other.fecha_ingresada,
      descripcion: other.descripcion,
      video: other.video,
      es_pregunta: other.es_pregunta,
      pasos: other.pasos, // Map vacío
      alcance: other.alcance,
      es_video: other.es_video,
      dificultad: other.dificultad, // Se conserva la dificultad original
    );
    nuevaLeccion.indexTemporal = other.indexTemporal;
    return nuevaLeccion;
    
  }
  // Factory method para crear una instancia de Leccion desde un DocumentSnapshot
  factory Leccion.fromDB(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return Leccion(
      id: documentSnapshot.id,
      nombre: data['nombre'] as String,
      imagen: data['imagen'] as String,
      duracion_video: data['duracion_video'] as String,
      id_aptitud: data['id_aptitud'] as String,
      id_habilidad: data['id_habilidad'] as String,
      fecha_ingresada: data['fecha_ingresada'] as Timestamp, // Cambiado a tipo Timestamp
      descripcion: data['descripcion'] as String, // Nuevo atributo
      video: data['video'] as String,
      es_pregunta: data['es_pregunta'] as bool,
      pasos: List<String>.from(data['pasos'] ?? {}), // Nuevo atributo
      alcance: data['alcance'] ?? 'global',
      es_video: data['es_video'] ?? false,
      dificultad: data['dificultad'] ?? 'Facil', // Se recupera la dificultad desde la base de datos
    );
  }

  // Getter para obtener el valor de _index
  int get indexTemporal => _indexTemporal;

  // Setter para establecer el valor de _index
  set indexTemporal(int value) {
    _indexTemporal = value;
  }
  // Getter para obtener el valor de _es_echoo
  bool get es_echoo => _fue_echoo;

  // Setter para establecer el valor de _es_echoo
  set es_echoo(bool value) {
    _fue_echoo = value;
  }

  // Getter para obtener el valor de _es_visto
  bool get es_visto => _fue_visto;

  // Setter para establecer el valor de _es_visto
  set es_visto(bool value) {
    _fue_visto = value;
  }  // Getter para obtener el valor de _es_visto


  int get numero_pregunta => _numero_pregunta;

 
  set numero_pregunta(int value) {
    _numero_pregunta = value;
  }  

    int get numero_pregunta1 => _numero_pregunta1;

 
  set numero_pregunta1(int value) {
    _numero_pregunta1 = value;
  }  

//_numero_pregunta

  // Getter para obtener el valor de _index
  int get index => _index;

  // Setter para establecer el valor de _index
  set index(int value) {
    _index = value;
  }
}

