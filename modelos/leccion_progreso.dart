
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Leccion_progreso {
  final String id;
  final String id_aptitud;
  final String id_usuario;
  final String id_leccion;
  final String? duracion_video;
  final bool fue_echo;
  final bool fue_visto;
  // Nuevo atributo

  Leccion_progreso({
    required this.id,
    required this.id_aptitud,
    required this.id_usuario,
    required this.id_leccion,
    this.duracion_video,
    required this.fue_echo,
    required this.fue_visto,
    // Asignar el valor de es_pregunta
  });

  factory Leccion_progreso.fromDB(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return Leccion_progreso(
      id: documentSnapshot.id,
      id_aptitud: data['id_aptitud'] as String,
      id_usuario: data['id_usuario'] as String,
      id_leccion: data['id_leccion'] as String,
      duracion_video: data['duracion_video'] as String?,
      fue_echo: data['fue_echo'] as bool,
      fue_visto: data['fue_visto'] as bool,
// Asignar el valor de es_pregunta
    );
  }
}


