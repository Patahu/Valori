import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/modelos/leccion.dart';
import 'package:valorix/src/modelos/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:valorix/src/ui/resume_screen/resume_screen.dart';
import '../../modelos/aprende.dart';
import '../../modelos/ejercicio.dart';
import '../../modelos/leccion_progreso.dart';
import '../../modelos/reporte.dart';
import '../../modelos/resultado.dart';
import '../../modelos/validators.dart';
import 'firebase_auth_servicio.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirbaseAuthDataUser{
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;


  Stream<Usuario> datosUsuario(String idUsuario) {
    print("AQUI-----:"+idUsuario);
 
      return _firebaseFirestore
          .collection("usuario")
          .doc(idUsuario)
          .snapshots()
          .map((snapshot) => Usuario.fromDB(snapshot));

  }
  Stream<List<Usuario>> datosRanking() {
    return _firebaseFirestore
        .collection("usuario")
        .orderBy('progreso', descending: true) // Ordenar por progreso de forma descendente
 
        .snapshots()
        .map((snapshot) {
          // Mapear los documentos a objetos Usuario
          final usuarios = snapshot.docs.map((doc) => Usuario.fromDB(doc)).toList();
          
          // Rellenar los espacios faltantes con Usuario.empty
          while (usuarios.length < 3) {
            usuarios.add(Usuario.empty);
          }
        
          return usuarios;
        });
  }
  Stream<List<Usuario>> datosPerfilAmiogos() {
    return _firebaseFirestore
        .collection("usuario")
        .snapshots()
        .map((snapshot) {
          // Mapear los documentos a objetos Usuario
          final usuarios = snapshot.docs.map((doc) => Usuario.fromDB(doc)).toList();
          

        
          return usuarios;
        });
  }
Future<List<Usuario>> datosRankingFoto() async {
  try {
    final snapshot = await _firebaseFirestore
        .collection("usuario")
        .orderBy('progreso', descending: true) // Ordenar por progreso de forma descendente
        .get();

    // Mapear los documentos a objetos Usuario
    final usuarios = snapshot.docs.map((doc) => Usuario.fromDB(doc)).toList();

    // Rellenar los espacios faltantes con Usuario.empty
    print("Cantidad de usuarios: ${usuarios.length}");


    return usuarios;
  } catch (error) {
    // Manejar el error, puedes lanzarlo nuevamente o retornar una lista vacía
    print("Error al obtener los datos del ranking: $error");
    return [];
  }
}
Future<String> subirImagenAFirestore(String pathImagen, String nombre) async {


  // Referencia a la ubicación de la imagen en Firebase Storage
  final Reference referenciaFirebaseStorage = FirebaseStorage.instance.ref().child('ejercicio_imagen/fotoAlternativa/$nombre');

  // Sube la imagen a Firebase Storage
  try {
    final UploadTask uploadTask = referenciaFirebaseStorage.putFile(File(pathImagen));
    await uploadTask.whenComplete(() => null);
  } catch (e) {
   print('Error al subir la imagen: $e');
  }

  // Obtiene la URL de la imagen
  final String urlImagen = await referenciaFirebaseStorage.getDownloadURL();

  return urlImagen;
}

  Future<Usuario> getUsuario() async {
    final userr = _firebaseAuth.currentUser;
    DocumentSnapshot doc =
        await _firebaseFirestore.collection("usuario").doc(userr?.uid).get();
    if (doc.exists) {
      final userss = Usuario.fromDB(doc);
      return userss;
    }
    return Usuario.empty;
    }

  Future<void> ingresarProgreso(int aumento,Usuario usu) async {

      Map<String, dynamic> actualizacionData = {
            'progreso': usu.progreso+aumento,
          };
          // Actualizar el documento en la colección "leccion_progreso"
          await _firebaseFirestore
              .collection("usuario")
              .doc(usu.id)
              .update(actualizacionData);

   
  }
  
  Stream<List<Habilidad>> datosHabilidades(String idDocumento) {

    return _firebaseFirestore
        .collection("habilidad")
        .where('id_aptitud', isEqualTo: idDocumento)
        .snapshots()
        .map((snapshot) {
          List<Habilidad> po = snapshot.docs.map((doc) => Habilidad.fromDB(doc)).toList();
          return po;
        });
  }

  Future<List<Habilidad>> datosHabilidadesNoGlobales(String id) async {
    final snapshot = await _firebaseFirestore
        .collection("habilidad")
        .where('id_aptitud', isEqualTo: id)

        .snapshots()
        .first;

    final listaHabilidades = snapshot.docs.map((doc) => Habilidad.fromDB(doc)).toList();
    return listaHabilidades;
  }

  Stream<List<Leccion>> datosRetosEjercicios(String idUsuario){
  return _firebaseFirestore
    .collection("leccion")
    .where('usuarios', arrayContains: idUsuario) // Filtra por string dentro del array
    .snapshots()
    .map((snapshot) {
      List<Leccion> po = snapshot.docs.map((doc) => Leccion.fromDB(doc)).toList();
      return po;
    });
  }

  Future<List<Leccion_progreso>> datosLeccionesProgresoEspecial(String idUsuario) async {
    List<Leccion_progreso> po=[];

    try{
      var leccionDocs=await _firebaseFirestore
        .collection("leccion_progreso")
   
        .where('id_usuario',isEqualTo: idUsuario)
        
        .get();
      po=leccionDocs.docs.map((doc) => Leccion_progreso.fromDB(doc)).toList();
    }catch(error){
      print("Ocurrio un error");
    }

    return po;
  }
  Stream<List<Habilidad>> datosHabilidadesGlobales() {

    return _firebaseFirestore
        .collection("habilidad")
        .where('alcance', isEqualTo: 'global')
        .snapshots()
        .map((snapshot) {
          List<Habilidad> po = snapshot.docs.map((doc) => Habilidad.fromDB(doc)).toList();
          return po;
        });
  }
  Stream<List<Aprende>> datosAprende() {
    return _firebaseFirestore
        .collection("aptitud")
        .orderBy('fecha_ingreso', descending: false)  // Añade esta línea para ordenar por fecha_ingreso descendente
        .snapshots()
        .map((snapshot) {
          List<Aprende> po = snapshot.docs.map((doc) => Aprende.fromDB(doc)).toList();
          return po;
        });
  }


Future<void> crearReporte(
    String descripcion,
    Usuario usuario,
    String tipo,
    Map<String,dynamic> listaAyudo,
    Map<String,dynamic> listaPractico,
    Map<String,String> listaValor,
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> reporteData = {
      'descripcion': descripcion,
      'id_usuario': usuario.id,
      'fecha_ingresada': Timestamp.now(),
      'tipo':tipo,
      'listaAyudo':listaAyudo,
      'listaPractico':listaPractico,
      'listaValor':listaValor,
      'usuario':[usuario.id,usuario.nombres,usuario.imagen],
      'fueVisto':false,
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("reporte").doc().set(reporteData);


  }


Future<void> crearLeccionProgresoVideo(
    bool fue_visto,
    String id_aptitud,
    String id_habilidad,
    String id_leccion,
    String id_usuario,
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> aprendeData = {
      'fue_echo': false,
      'fue_visto': fue_visto,
      'id_aptitud':id_aptitud,
      'id_habilidad':id_habilidad,
      'id_leccion':id_leccion,
      'id_usuario':id_usuario
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("leccion_progreso").doc().set(aprendeData);


  }
  Future<void> crearLeccionProgresoPregunta(
    bool fue_visto,
    String id_aptitud,
    String id_habilidad,
    String id_leccion,
    String id_usuario,
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> aprendeData = {
      'fue_echo': true,
      'fue_visto': fue_visto,
      'id_aptitud':id_aptitud,
      'id_habilidad':id_habilidad,
      'id_leccion':id_leccion,
      'id_usuario':id_usuario
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("leccion_progreso").doc().set(aprendeData);


  }
Future<void> modificarLeccionProgreso(
  bool fue_visto,
  bool fue_echo,
  String id_leccion_progresada,
) async {
  try {
    // Datos para actualizar en el documento de la colección "leccion_progreso"
    Map<String, dynamic> actualizacionData = {
      'fue_echo': fue_echo,
      'fue_visto': fue_visto,
    };

    // Actualizar el documento en la colección "leccion_progreso"
    await _firebaseFirestore
        .collection("leccion_progreso")
        .doc(id_leccion_progresada)
        .update(actualizacionData);
  } catch (error) {
    print("Ocurrió un error al modificar la lección progreso: $error");
    // Puedes manejar el error según tus necesidades, como lanzar una excepción o registrar el error
  }
}

Future<void> crearHabilidadDb(
    String id_aptitud,
    Timestamp? fecha_ingresa,
    String? imagen,
    String? nombre,
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> aprendeData = {
      'fecha_ingreso': fecha_ingresa,
      'id_aptitud':id_aptitud,
      'imagen':imagen,
      'nombre':nombre,
      'tipo':'tiempo',
      'alcance':'aptitud',
      'color':Color.fromARGB(255, 189, 97, 250).value,
      
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("habilidad").doc().set(aprendeData);


  }
  Future<void> modificarLeccionDb(
      {
      required String idLeccion,
      String? descripcion,
      String? duracionVideo,
      String? imagen,
      String? titulo,
      String? video,
      String? dificultad,
      List<String>? pasos,

    }) async {
      // Datos actualizados para la lección
      Map<String, dynamic> leccionData = {
        'descripcion': descripcion,
        'duracion_video': duracionVideo,
        'imagen': imagen,
        'nombre': titulo,
        'video': video,
        'dificultad':dificultad,
        'pasos':pasos,
      };

      // Actualizar documento en la colección "leccion" utilizando el ID existente
      await _firebaseFirestore.collection("leccion").doc(idLeccion).update(leccionData);
    }

  Future<void> eliminarLeccion(String idDocumento) async {
  try {
    // Eliminar documento en la colección "aprende"
    await _firebaseFirestore.collection("leccion").doc(idDocumento).delete();
    print("Documento eliminado exitosamente");
  } catch (error) {
    print("Error al eliminar el documento: $error");
    // Manejar el error según tus necesidades
  }
}
  Future<void> eliminarEjercicio(String idDocumento) async {
  try {
    // Eliminar documento en la colección "aprende"
    await _firebaseFirestore.collection("ejercicio").doc(idDocumento).delete();
    print("Documento eliminado exitosamente");
  } catch (error) {
    print("Error al eliminar el documento: $error");
    // Manejar el error según tus necesidades
  }
}
  Future<void> crearEjerciciodDb(
    {
      String? alcance,
    String? id_leccion,
    String? pregunta,
    String? respuesta,
    String? id,
    String? tipo,
    Map<String, String>? alternativas,
    String? imagenFuera, 
    String? descripcion,
    }
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> leccionData = {
      'alcance': alcance,
      'id_leccion':id_leccion,
      'pregunta':pregunta,
      'respuesta':respuesta,
      'numero_orden':0,
      'tipo':tipo,
      'alternativas':alternativas??{},
      'imagenFuera':imagenFuera??'',
      'descripcion': descripcion,
      'repeticion':1,
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("ejercicio").doc(id).set(leccionData);


  }
  Future<void> crearLecciondDbA(
    {
      String? alcance,
    Timestamp? fecha_ingresa,
    String? descripcion,
    String? duracion_video,
    String? id_aptitud,
    String? id_habilidad,
    String? imagen,
    String? titulo,
    String? video,
    bool? es_pregunta,
    bool? es_video,
    int? orden,
    String? dificultad,
    String? id,
    List<String>? usuarios,
    }
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> leccionData = {
      'alcance': alcance,
      'descripcion':descripcion,
      'duracion_video':duracion_video,
      'es_pregunta':es_pregunta,
      'es_video':es_video,
      'fecha_ingresada':fecha_ingresa,
      'id_aptitud':id_aptitud,
      'id_habilidad':id_habilidad,
      'imagen':imagen,
      'nombre':titulo,
      'video':video,
      'orden':orden,
      'dificultad':dificultad,
      'usuarios':usuarios??[],
    
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("leccion").doc(id).set(leccionData);


  }
  Future<void> crearLecciondDb(
    {
      String? alcance,
    Timestamp? fecha_ingresa,
    String? descripcion,
    String? duracion_video,
    String? id_aptitud,
    String? id_habilidad,
    String? imagen,
    String? titulo,
    String? video,
    bool? es_pregunta,
    bool? es_video,
    int? orden,
    String? dificultad,
    String? id,
    List<String>? pasos,

    }
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> leccionData = {
      'alcance': alcance,
      'descripcion':descripcion,
      'duracion_video':duracion_video,
      'es_pregunta':es_pregunta,
      'es_video':es_video,
      'fecha_ingresada':fecha_ingresa,
      'id_aptitud':id_aptitud,
      'id_habilidad':id_habilidad,
      'imagen':imagen,
      'nombre':titulo,
      'video':video,
      'orden':orden,
      'dificultad':dificultad,
      'pasos':pasos,

    
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("leccion").doc(id).set(leccionData);


  }
  Future<void> eliminarHabilidad(String idDocumento) async {
  try {
    // Eliminar documento en la colección "aprende"
    await FirebaseFirestore.instance.collection("habilidad").doc(idDocumento).delete();
    print("Documento eliminado exitosamente");
  } catch (error) {
    print("Error al eliminar el documento: $error");
    // Manejar el error según tus necesidades
  }
}

Future<void> actualizarHabilidadDb(
  String? nombre,
  String? nuevaImagen,
  String id,
) async {
  try {
    // Datos para actualizar el documento en la colección "aprende"
    Map<String, dynamic> nuevosDatos = {
      'imagen': nuevaImagen,
      'nombre':nombre,
    
    };

    // Actualizar documento en la colección "aprende"


    await FirebaseFirestore.instance
        .collection("habilidad")
        .doc(id)
        .update(nuevosDatos);
  } catch (error) {
    print("Error al actualizar documento: $error");
    // Manejar el error según tus necesidades
  }
}


/*
Stream<List<Aprende>> datosProgreso(String idDocumento) {
  return _firebaseFirestore
      .collection("aptitud")
      .doc(idDocumento)
      .collection('habilidad')
      .orderBy('fecha_ingreso', descending: true)
      .snapshots()
      .asyncMap((snapshotAptitud) async {
        List<String> idsAptitud = snapshotAptitud.docs.map((doc) => doc.id).toList();
        
        // Obtén la otra colección (reemplaza "otraColeccion" con tu nombre de colección)
        QuerySnapshot snapshotOtraColeccion = await _firebaseFirestore
                  .collection("aptitud")
                  .doc(idDocumento)
                  .collection('progreso')
                  .orderBy('fecha_ingreso', descending: true)
            .where(FieldPath.documentId, whereIn: idsAptitud)
            .get();

        List<Aprende> po = snapshotOtraColeccion.docs.map((doc) => Aprende.fromDB(doc)).toList();
        return po;
      });
}*/
Stream<List<Leccion>> datosLecciones(String id) {
  return _firebaseFirestore
      .collection("leccion")
     
      .where('id_habilidad', isEqualTo: id)
      .snapshots()
      .map((snapshot) {
        List<Leccion> po = snapshot.docs.map((doc) => Leccion.fromDB(doc)).toList();
        // Se elimina la linea de ordenamiento ya que la consulta ya ordena
        // po.sort((a, b) => a.fecha_ingresada.compareTo(b.fecha_ingresada));

        return po;
      });
}

Future<Leccion>  datosLeccion(String idLeccion) async {
  try {
        var leccionDocs = await _firebaseFirestore
            .collection("leccion")
            .doc(idLeccion)
            .get();
        return Leccion.fromDB(leccionDocs);


      } catch (error) {
        print("Ocurrió un error al obtener los datos de la lección progresada: $error");
      }

      // Si no se encontraron documentos o hubo un error, devuelve null
      return Leccion.empty();
  }


  Future<Map<String, List<String>>> fotosPortador() async {
    try {
      // Obtener todos los documentos de la colección "foto"
      var fotoDocs = await _firebaseFirestore.collection("foto").get();

      // Inicializar un mapa vacío para almacenar los datos clasificados
      Map<String, List<String>> fotos = {
        'fotoAprende': [],
        'fotoEjercicio': [],
        'fotoHistoria': [],
        'fotoPaisaje':[],
        'fotoReto':[],
      };

      // Recorrer los documentos y clasificar los datos
      fotoDocs.docs.forEach((doc) {
        print("buscamos todas la fotossssssssssssssssssssssssssssssssssssssssssssssssssssssssssss");
        if (doc.id == 'fotoAprende') {
          fotos['fotoAprende'] = (doc['listaFoto'] as List<dynamic>).cast<String>();
        } else if (doc.id == 'fotoEjercicio') {
          fotos['fotoEjercicio'] = (doc['listaFoto'] as List<dynamic>).cast<String>();
        } else if (doc.id == 'fotoHistoria') {
          fotos['fotoHistoria'] = (doc['listaFoto'] as List<dynamic>).cast<String>();
        }else if (doc.id == 'fotoPaisaje') {
          fotos['fotoPaisaje'] = (doc['listaFoto'] as List<dynamic>).cast<String>();
        }else if (doc.id == 'fotoReto') {
          fotos['fotoReto'] = (doc['listaFoto'] as List<dynamic>).cast<String>();
        }
      });

      return fotos;
    } catch (error) {
      print("Ocurrió un error al obtener los datos de la lección progresada: $error");
      return {};
    }
  }
Future<List<Ejercicio>> datosEjerciciosDesdeLeccion(String idLeccion) async {
    try {
    var leccionDocs = await _firebaseFirestore
        .collection("ejercicio")
        .where('id_leccion', isEqualTo: idLeccion)
        .get();
      
      // Mapear cada documento a una instancia de Ejercicio y devolver una lista de Ejercicios
      return leccionDocs.docs.map((doc) => Ejercicio.fromDB(doc)).toList();
    } catch (error) {
      print("Ocurrió un error al obtener los datos de la lección progresada: $error");
      // Si ocurre un error, devolver una lista vacía
      return [];
    }

  }

  Future<List<Usuario>> datosAmigos() async {
    try {
      final usuariosDocs = await _firebaseFirestore
          .collection("usuario")
          .get();
      final listaUsuarios = <Usuario>[];
      usuariosDocs.docs.forEach((doc) {
        listaUsuarios.add(Usuario.fromDB(doc));
      });
      return listaUsuarios;
    } catch (error) {
      print("Ocurrió un error al obtener los datos de los usuarios: $error");
      return []; // Devolver una lista vacía en caso de error
    }
  }
Future<Ejercicio> datosEjercicio(String idEjercicio) async {
    try {
      var leccionDocs = await _firebaseFirestore
        .collection("ejercicio")
        .doc(idEjercicio)
        .get();
        return Ejercicio.fromDB(leccionDocs);
    } catch (error) {
      print("Ocurrió un error al obtener los datos de la lección progresada: $error");
      // Si ocurre un error, devolver una lista vacía
      return Ejercicio.empty();
    }

  }


  Stream<List<Reporte>> datosReporteInicio()  {
      return _firebaseFirestore
      .collection("reporte")
      .where('fueVisto', isEqualTo: false)
      .where('tipo', isEqualTo: 'violencia')
      .snapshots()
      .map((snapshot) {
        List<Reporte> po = snapshot.docs.map((doc) => Reporte.fromDB(doc)).toList();
        return po;
      });
  }
  Stream<List<Reporte>> datosReporteTodos()  {
      return _firebaseFirestore
      .collection("reporte")
      .where('tipo', isEqualTo: 'violencia')
      .snapshots()
      .map((snapshot) {
        List<Reporte> po = snapshot.docs.map((doc) => Reporte.fromDB(doc)).toList();
        return po;
      });
  }
Stream<List<Ejercicio>> datosEjercciosStream(String id) {
  return _firebaseFirestore
      .collection("ejercicio")
      .where('id_leccion', isEqualTo: id)
 
      .snapshots()
      .map((snapshot) {
        List<Ejercicio> po = snapshot.docs.map((doc) => Ejercicio.fromDB(doc)).toList();
        return po;
      });
}
Stream<List<Reporte>> datosReporte(String id,String tipo) {
  return _firebaseFirestore
      .collection("reporte")
      .where('id_usuario', isEqualTo: id)
      .where('tipo', isEqualTo: tipo)
      .snapshots()
      .map((snapshot) {
        List<Reporte> po = snapshot.docs.map((doc) => Reporte.fromDB(doc)).toList();
        return po;
      });
}
Future<void> modificarVistoReporte(
  String? idDocumento
) async {
  try {
    // Datos para actualizar en el documento de la colección "leccion_progreso"
    Map<String, dynamic> actualizacionData = {
      'fueVisto': true,
    };

    // Actualizar el documento en la colección "leccion_progreso"
    await _firebaseFirestore
        .collection("reporte")
        .doc(idDocumento)
        .update(actualizacionData);
  } catch (error) {
    print("Ocurrió un error al modificar el reporte : $error");
    // Puedes manejar el error según tus necesidades, como lanzar una excepción o registrar el error
  }
}




Future<Leccion_progreso?> datosLeccionProgresado(String idLeccion, String idUsuario) async {
  try {
    var leccionDocs = await _firebaseFirestore
        .collection("leccion_progreso")
        .where('id_leccion', isEqualTo: idLeccion)
        .where('id_usuario', isEqualTo: idUsuario)
        .get();

    if (leccionDocs.docs.isNotEmpty) {
      // Si se encontraron documentos, devuelve el primero
      var doc = leccionDocs.docs.first;
      return Leccion_progreso.fromDB(doc);
    }
  } catch (error) {
    print("Ocurrió un error al obtener los datos de la lección progresada: $error");
  }

  // Si no se encontraron documentos o hubo un error, devuelve null
  return null;
}


  Future<List<Leccion_progreso>> datosLeccionesProgreso(String idHabilidad, String idUsuario) async {
    List<Leccion_progreso> po=[];

    try{
      var leccionDocs=await _firebaseFirestore
        .collection("leccion_progreso")
        .where('id_habilidad', isEqualTo: idHabilidad)
        .where('id_usuario',isEqualTo: idUsuario)
        .get();
      po=leccionDocs.docs.map((doc) => Leccion_progreso.fromDB(doc)).toList();
    }catch(error){
      print("Ocurrio un error");
    }

    return po;
  }

  Future<List<Resultado>> obtenerCantidadInterseccion(String idUsuario) async {
    try {
      // Obtener documentos de la colección "leccion"
      var leccionDocs = await FirebaseFirestore.instance
          .collection("leccion")
    
          .get();

      // Obtener documentos de la colección "leccion_progreso"
      var leccionProgresoDocs = await FirebaseFirestore.instance
          .collection("leccion_progreso")
          .where('id_usuario', isEqualTo: idUsuario)
          .get();

      // Convertir documentos a listas de Leccion y LeccionProgreso
      var lecciones = leccionDocs.docs.map((doc) => Leccion.fromDB(doc)).toList();
      var leccionesProgreso = leccionProgresoDocs.docs.map((doc) => Leccion_progreso.fromDB(doc)).toList();

      // Encontrar la intersección entre las dos listas
      var interseccion = lecciones.where((leccion) => leccionesProgreso.any((lp){
          if(lp.id_leccion == leccion.id){
            leccion.es_echoo=lp.fue_echo;
            leccion.es_visto=lp.fue_visto;
            return true;
          }
          return false;

      }));

      // Obtener documentos de la colección "aptitud"
      var aptitudDocs = await FirebaseFirestore.instance
          .collection("aptitud")
          .get();

      // Convertir documentos a lista de Aptitud
      var aptitudes = aptitudDocs.docs.map((doc) => Aprende.fromDB(doc)).toList();

      // Obtener la intersección entre lecciones y aptitudes basada en id_aptitud
      var interseccionAptitud = interseccion.where((leccion) => aptitudes.any((aptitud) => aptitud.id == leccion.id_aptitud));

      // Obtener la intersección entre lecciones y aptitudes basada en id_aptitud (segunda intersección)
      var interseccionAptitudxLecciones = lecciones.where((leccion) => aptitudes.any((aptitud) => aptitud.id == leccion.id_aptitud));

      var resultados = <Resultado>[];

      // Incrementar el conteo para las lecciones que tienen una aptitud asociada
      aptitudes.forEach((aptitud) {
        var idAptitud = aptitud.id;
        var resultado = Resultado(0, 0, idAptitud);
        resultados.add(resultado);
      });
      interseccionAptitud.forEach((leccion) {
        var idAptitud=leccion.id_aptitud;
        var esD=Validators.determinarCon(leccion.es_visto,leccion.es_pregunta,leccion.es_echoo);//determinarCon(leccion.es_visto,leccion.es_pregunta,leccion.es_echoo);

        resultados.forEach((element) {
          if(element.idResultado==idAptitud && esD){
            element.enProgreso++;
          }
        });

      });
      // Actualizar el conteo para la segunda intersección (intersección de lecciones y aptitudes)
      interseccionAptitudxLecciones.forEach((leccion) {
        var idAptitud = leccion.id_aptitud;

        resultados.forEach((element) {
          if(element.idResultado==idAptitud ){
            element.total++;
          }
        });

      });

      return resultados;
    } catch (error) {
      print("-----------------Error al obtener la cantidad de intersección: $error");
      return [];
    }
  }
  Future<List<Resultado>> obtenerCantidadInterseccionHabilidadGlobal(String idUsuario) async {
    try {
      // Obtener documentos de la colección "leccion"
      var leccionDocs = await FirebaseFirestore.instance
          .collection("leccion")
          .where('alcance', isEqualTo: 'global')
          .get();

      // Obtener documentos de la colección "leccion_progreso"
      var leccionProgresoDocs = await FirebaseFirestore.instance
          .collection("leccion_progreso")
          .where('id_usuario', isEqualTo: idUsuario)
          .get();

      // Convertir documentos a listas de Leccion y LeccionProgreso
      var lecciones = leccionDocs.docs.map((doc) => Leccion.fromDB(doc)).toList();
      var leccionesProgreso = leccionProgresoDocs.docs.map((doc) => Leccion_progreso.fromDB(doc)).toList();

      // Encontrar la intersección entre las dos listas
      var interseccion = lecciones.where((leccion) => leccionesProgreso.any((lp) {
        if(lp.id_leccion == leccion.id){
          leccion.es_echoo=lp.fue_echo;
          leccion.es_visto=lp.fue_visto;
          return true;
        }
        return false;
      }));

      // Obtener documentos de la colección "aptitud"
      var habilidadesDocs = await FirebaseFirestore.instance
          .collection("habilidad")
          .where("alcance",isEqualTo: "global")
          .get();
  



      // Convertir documentos a lista de Aptitud
      var habilidades = habilidadesDocs.docs.map((doc) => Habilidad.fromDB(doc)).toList();

      // Obtener la intersección entre lecciones y aptitudes basada en id_aptitud
      var interseccionAptitud = interseccion.where((leccion) => habilidades.any((habilidad) => habilidad.id == leccion.id_habilidad));

      // Obtener la intersección entre lecciones y aptitudes basada en id_aptitud (segunda intersección)
      var interseccionAptitudxLecciones = lecciones.where((leccion) => habilidades.any((habilidad) => habilidad.id == leccion.id_habilidad));

        //----------------
    
      var ejerciciosDocs = await FirebaseFirestore.instance
          .collection("ejercicio")
          .where("alcance",isEqualTo: "leccion")
          .get();

      var ejercicios = ejerciciosDocs.docs.map((doc) => Ejercicio.fromDB(doc)).toList();
      final idEspecial='SNSmlsqB0PCN1IUBrNRc';
      var interseccionEjercicios = ejercicios.where((ejercicio) => lecciones.any((leccion) => (leccion.id == ejercicio.idLeccion) && leccion.id_habilidad==idEspecial));



      //-----------------
      var resultados = <Resultado>[];

      // Incrementar el conteo para las lecciones que tienen una aptitud asociada
      habilidades.forEach((habilidad) {
        var idHabilidad = habilidad.id;
        var resultado = Resultado(0, 0, idHabilidad);
        resultados.add(resultado);
      });


      interseccionAptitud.forEach((lec) { 
        interseccionEjercicios.forEach((ejer) {
          if(lec.id==ejer.idLeccion){
            lec.numero_pregunta++;
          }
         });
      });



      interseccionAptitud.forEach((leccion) {
        var idHabilidad=leccion.id_habilidad;
        var esD=Validators.determinarCon(leccion.es_visto,leccion.es_pregunta,leccion.es_echoo);
        resultados.forEach((element) {
                  
          if(element.idResultado==idHabilidad && esD && idHabilidad!=idEspecial){
            element.enProgreso++;
          }else if(element.idResultado==idHabilidad && esD && idHabilidad==idEspecial){
            element.enProgreso+=leccion.numero_pregunta;
            //element.enProgreso+=;
          }
        });

      });


      interseccionAptitudxLecciones.forEach((lec) { 
        interseccionEjercicios.forEach((ejer) {
          if(lec.id==ejer.idLeccion){
            lec.numero_pregunta1++;
          }
         });
      });


      // Actualizar el conteo para la segunda intersección (intersección de lecciones y aptitudes)
      interseccionAptitudxLecciones.forEach((leccion) {
        var idHabilidad = leccion.id_habilidad;
        resultados.forEach((element) {
    
          if(element.idResultado==idHabilidad && idHabilidad!=idEspecial){
            element.total++;
          }else if(element.idResultado==idHabilidad && idHabilidad==idEspecial){
            element.total+=leccion.numero_pregunta1;
          }
        });

      });




      return resultados;
    } catch (error) {
      print("-----------------Error al obtener la cantidad de intersección: $error");
      return [];
    }
  }

  Future<List<Resultado>> obtenerCantidadInterseccionHabilidad(String idUsuario, String idAptitud) async {
    try {
      // Obtener documentos de la colección "leccion"
      var leccionDocs = await FirebaseFirestore.instance
          .collection("leccion")
          .get();

      // Obtener documentos de la colección "leccion_progreso"
      var leccionProgresoDocs = await FirebaseFirestore.instance
          .collection("leccion_progreso")
          .where('id_usuario', isEqualTo: idUsuario)
          .get();

      // Convertir documentos a listas de Leccion y LeccionProgreso
      var lecciones = leccionDocs.docs.map((doc) => Leccion.fromDB(doc)).toList();
      var leccionesProgreso = leccionProgresoDocs.docs.map((doc) => Leccion_progreso.fromDB(doc)).toList();

      // Encontrar la intersección entre las dos listas
      var interseccion = lecciones.where((leccion) => leccionesProgreso.any((lp) {
        if(lp.id_leccion == leccion.id){
          leccion.es_echoo=lp.fue_echo;
          leccion.es_visto=lp.fue_visto;
          return true;
        }
        return false;
      }));

      // Obtener documentos de la colección "aptitud"
      var aptitudDocs = await FirebaseFirestore.instance
          .collection("habilidad")
          .where("id_aptitud",isEqualTo: idAptitud)
          .get();

      // Convertir documentos a lista de Aptitud
      var habilidades = aptitudDocs.docs.map((doc) => Habilidad.fromDB(doc)).toList();

      // Obtener la intersección entre lecciones y aptitudes basada en id_aptitud
      var interseccionAptitud = interseccion.where((leccion) => habilidades.any((habilidad) => habilidad.id == leccion.id_habilidad));

      // Obtener la intersección entre lecciones y aptitudes basada en id_aptitud (segunda intersección)
      var interseccionAptitudxLecciones = lecciones.where((leccion) => habilidades.any((habilidad) => habilidad.id == leccion.id_habilidad));

      var resultados = <Resultado>[];

      // Incrementar el conteo para las lecciones que tienen una aptitud asociada
      habilidades.forEach((habilidad) {
        var idHabilidad = habilidad.id;
        var resultado = Resultado(0, 0, idHabilidad);
        resultados.add(resultado);
      });
      interseccionAptitud.forEach((leccion) {
        var idHabilidad=leccion.id_habilidad;
        var esD=Validators.determinarCon(leccion.es_visto,leccion.es_pregunta,leccion.es_echoo);
        resultados.forEach((element) {
          if(element.idResultado==idHabilidad && esD){
            element.enProgreso++;
          }
        });

      });
      // Actualizar el conteo para la segunda intersección (intersección de lecciones y aptitudes)
      interseccionAptitudxLecciones.forEach((leccion) {
        var idHabilidad = leccion.id_habilidad;
        resultados.forEach((element) {
          if(element.idResultado==idHabilidad){
            element.total++;
          }
        });

      });




      return resultados;
    } catch (error) {
      print("-----------------Error al obtener la cantidad de intersección: $error");
      return [];
    }
  }

Future<void> actualizarEjercicioCantidadDb(
  int? cantidad,
  String id,
) async {
  try {
    // Datos para actualizar el documento en la colección "aprende"
    Map<String, dynamic> nuevosDatos = {
      'repeticion': cantidad,
    };

    // Actualizar documento en la colección "aprende"


    await FirebaseFirestore.instance
        .collection("ejercicio")
        .doc(id)
        .update(nuevosDatos);
  } catch (error) {
    print("Error al actualizar documento: $error");
    // Manejar el error según tus necesidades
  }
}

Future<void> actualizarAprendeDb(
  String? nombre,
  int? nuevoColor,
  String? nuevaImagen,
  String id,
) async {
  try {
    // Datos para actualizar el documento en la colección "aprende"
    Map<String, dynamic> nuevosDatos = {
      'color': nuevoColor,
      'imagen': nuevaImagen,
      'nombre':nombre,
    };

    // Actualizar documento en la colección "aprende"


    await FirebaseFirestore.instance
        .collection("aptitud")
        .doc(id)
        .update(nuevosDatos);
  } catch (error) {
    print("Error al actualizar documento: $error");
    // Manejar el error según tus necesidades
  }
}

  Future<void> crearAprendeDb(
    int? color,
    Timestamp? fecha_ingresa,
    String? imagen,
    String? nombre,
  ) async {
    // Datos para la colección "aprende"
    Map<String, dynamic> aprendeData = {
      'fecha_ingreso': fecha_ingresa,
      'color':color,
      'imagen':imagen,
      'nombre':nombre
    };

    // Crear documento en la colección "aprende"
    await _firebaseFirestore.collection("aptitud").doc().set(aprendeData);


  }

  Future<void> eliminarAprende(String idDocumento) async {
  try {
    // Consultar documentos en la colección "habilidad" donde id_aptitud sea igual a idDocumento
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("habilidad")
        .where("id_aptitud", isEqualTo: idDocumento)
        .get();

    // Eliminar cada documento encontrado
    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    // Eliminar documento en la colección "aprende"
    await FirebaseFirestore.instance.collection("aptitud").doc(idDocumento).delete();
    print("Documento eliminado exitosamente");
  } catch (error) {
    print("Error al eliminar el documento: $error");
    // Manejar el error según tus necesidades
  }
}




}