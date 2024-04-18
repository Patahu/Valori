import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Aprende {
  final String id; // Nuevo atributo
  final String nombre;
  final int color;
  final String imagen;

  Aprende({
    required this.id, // Agregar el atributo id al constructor
    required this.nombre,
    required this.color,
    required this.imagen,
  });

  // Factory method para crear una instancia de Aprende desde un DocumentSnapshot
  factory Aprende.fromDB(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return Aprende(
      id: documentSnapshot.id, // Asignar el id del documento
      nombre: data['nombre'] as String,
      color: data['color'] as int,
      imagen: data['imagen'] as String,
    );
  }

  // Método estático para crear una instancia vacía de Aprende
  factory Aprende.empty() {
    return Aprende(
      id: '', // Puedes proporcionar un valor predeterminado o dejarlo vacío
      nombre: '',
      color: 4291359200,
      imagen: 'violencia',
    );
  }

  // Método para actualizar una instancia existente de Aprende con nuevos valores
  Aprende update({
    String? nombre,
    int? color,
    String? imagen,
  }) {
    return Aprende(
      id: this.id, // Mantener el mismo id
      nombre: nombre ?? this.nombre,
      color: color ?? this.color,
      imagen: imagen ?? this.imagen,
    );
  }
}

