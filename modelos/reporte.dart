
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/modelos/usuario.dart';

class Reporte{
  final String idReporte;
  final Map<String,Usuario> listaAyudo;
  final Map<String,Usuario> listaPractico;
  final Map<String,Habilidad> listaValor;
  final String descripcion;
  final String idUsuario;
  final Usuario usuario;
  final String tipo;
  final bool fueVisto;
  Reporte({
    required this.idReporte,
    required this.listaAyudo,
    required this.listaPractico,
    required this.listaValor,
    required this.descripcion,
    required this.idUsuario,
    required this.tipo,
    required this.usuario,
    required this.fueVisto,
  });

  factory Reporte.fromDB(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    final listaAyudo = Map<String, dynamic>.from(data['listaAyudo'] ?? {});
    Map<String,Usuario> listaAfinal={};
    listaAyudo.forEach((key, value) {
      List<String> reu= value.cast<String>();
      listaAfinal[key]=Usuario.copyR(key, reu);

    });

    final listaPractico = Map<String, dynamic>.from(data['listaPractico'] ?? {});
    Map<String,Usuario> listaPfinal={};
    listaPractico.forEach((key, value) {
      List<String> reu= value.cast<String>();
      listaPfinal[key]=Usuario.copyR(key, reu);

    });


    final listaValor = Map<String, String>.from(data['listaValor'] ?? {});
    Map<String,Habilidad> listaVfinal={};
    listaValor.forEach((key, value) {
      listaVfinal[key]=Habilidad.copyR(value, key,0);

    });

    final listaUsu = List<dynamic>.from(data['usuario'] ?? []);
    final usu=Usuario.copyR(listaUsu[0], [listaUsu[1],listaUsu[2]]);

    return Reporte(
      idReporte: documentSnapshot.id,
      listaAyudo: listaAfinal,
      listaPractico:listaPfinal,
      listaValor:listaVfinal,
      descripcion: data['descripcion'] ??'',
      tipo: data['tipo'] ??'',
      idUsuario:data['id_usuario'] ?? '',
      usuario: usu,
      fueVisto:data['fueVisto'] ?? false,
    );
  }
  // Factory method para crear una instancia de Habilidad vacía
  factory Reporte.empty() {
    return Reporte(
      idReporte: '',
      listaAyudo: {},
      listaPractico: {},
      listaValor:{},
      fueVisto:false,
      descripcion: '',
      tipo: '',
      idUsuario: '',
      usuario: Usuario.empty
    );
  }
}