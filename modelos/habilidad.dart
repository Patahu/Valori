
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Habilidad {
  final String id;
  final String imagen;
  final String nombre;
  final String alcance; // Nuevo atributo
  final int color; // Nuevo atributo
  final String tipo; // Nuevo atributo
  final Timestamp fecha_ingreso;
  int _colorR=0;
  Habilidad({
    required this.id,
    required this.imagen,
    required this.nombre,
    required this.alcance,
    required this.color,
    required this.tipo,
    required this.fecha_ingreso,
  });

  int get colorR => _colorR;
  set colorR(int value) => _colorR = value;

  // Factory method para crear una instancia de Habilidad desde un Map
  factory Habilidad.fromDB(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> map = documentSnapshot.data() as Map<String, dynamic>;
    return Habilidad(
      id: documentSnapshot.id,
      imagen: map['imagen'],
      nombre: map['nombre'],
      alcance: map['alcance'], // Agregar el atributo alcance
      color: map['color'], // Agregar el atributo color
      tipo: map['tipo']??'', // Agregar el atributo tipo
      fecha_ingreso:map['fecha_ingreso']??Timestamp.now(),
    );
  }

  // Método para convertir la instancia de Habilidad a un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagen': imagen,
      'nombre': nombre,
      'alcance': alcance, // Agregar el atributo alcance
      'color': color, // Agregar el atributo color
      'tipo': tipo, // Agregar el atributo tipo
    };
  }

  factory Habilidad.copyFrom(Habilidad other) {
    return Habilidad(
      id: other.id,
      imagen: other.imagen,
      nombre: other.nombre,
      alcance: other.alcance,
      color: other.color,
      tipo: other.tipo,
      fecha_ingreso:other.fecha_ingreso
    );
  }
  factory Habilidad.copyFromIm(Habilidad other, String imagen) {
    return Habilidad(
      id: other.id,
      imagen: imagen,
      nombre: other.nombre,
      alcance: other.alcance,
      color: other.color,
      tipo: other.tipo,
      fecha_ingreso:other.fecha_ingreso
    );
  }

    factory Habilidad.copyR(String? nombre, String? id,int? color) {
    return Habilidad(
      id: id??'',
      imagen: '',
      nombre: nombre??'',
      alcance: '',
      color: color??0,
      tipo: '',
      fecha_ingreso:Timestamp.now()
    );
  }
  // Factory method para crear una instancia de Habilidad vacía
  factory Habilidad.empty() {
    return Habilidad(
      id: '',
      imagen: '',
      nombre: '',
      alcance: '', // Agregar el atributo alcance
      color: 4278245019, // Agregar el atributo color
      tipo: '', // Agregar el atributo tipo
      fecha_ingreso:Timestamp.now()
    );
  }
    factory Habilidad.empty2() {
    return Habilidad(
      id: '',
      imagen: '',
      nombre: '',
      alcance: '', // Agregar el atributo alcance
      color: 4293309470, // Agregar el atributo color
      tipo: '', // Agregar el atributo tipo
      fecha_ingreso:Timestamp.now()
    );
  }


      factory Habilidad.empty3() {
    return Habilidad(
      id: '',
      imagen: 'https://firebasestorage.googleapis.com/v0/b/valorixdb.appspot.com/o/ejercicio_imagen%2FfotoAprende%2F150e39c9d3b1e44e9b2fe5733b9c828a.png?alt=media&token=d5941c0e-69e3-4871-87a1-c06b57c96320',
      nombre: 'Top 3',
      alcance: '', // Agregar el atributo alcance
      color: 4293309470, // Agregar el atributo color
      tipo: '', // Agregar el atributo tipo
      fecha_ingreso:Timestamp.now()
    );
  }
}



