




import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../firebase/aut_usuario/firebase_store.dart';
import '../../../modelos/leccion.dart';
import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_storage/firebase_storage.dart';

class RetoBloc extends Bloc<RetoEvent, RetoState> {
  late Leccion leccion;
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  DataBaseIncidentFirestore _storage=DataBaseIncidentFirestore();
  late int color;
  late List<Usuario> _listaUsuarios;
  List<Usuario> _listaAyudo=[];
  String _imagenReto='';
  RetoBloc() : super(RetoState.empty()) {
 
    on<inicarReto>(practica);
    on<siguienteRetoPasos>(siguientePasos);
    on<siguienteRetoAmigos>(siguienteBuscarAmigos);
    on<ingresarUsuarioRetoParticipo>(ingresarUsuarioPractico);
    on<siguienteIngresarFoto>(siguienteFoto);
    on<ingresarFotoReto>(asignarFoto);
    on<agregarImagenReto>(ingresarImagenesDB);


  }
  List<Usuario> get listaAyudo=>_listaAyudo;
  String get imagenReto=>_imagenReto;
  FutureOr<void> ingresarImagenesDB(agregarImagenReto event, Emitter<RetoState> emit) async {
  
    //crearLeccionProgreso
          
      
      if(!leccion.es_echoo){
        final DateTime dateTime = Timestamp.now().toDate();
        final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.microsecond}';
        final String nombre=leccion.id+timestampAsString;
        final String destino='ejercicio_imagen/fotoAlternativa/${nombre}';

        final file = File(_imagenReto);
        
        UploadTask? task;

        task = _storage.uploadFile(destino, file);

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        _imagenReto=urlDownload;


      final user = await _firebaseAuthDataUser.getUsuario();
      await _firebaseAuthDataUser.crearLeccionProgresoPregunta(false, leccion.id_aptitud, leccion.id_habilidad, leccion.id, user.id);
      
      await _firebaseAuthDataUser.ingresarProgreso(10,user); ///AUMENTO ESTA AQUI S
      emit(state.copyWith(success: true));
    }

    

    //add(AgregarPreguntaLeccionDB(event.pregunta));
      //
      //emit(state.activateSeleccionarAlt());
  }
  FutureOr<void> asignarFoto(ingresarFotoReto event, Emitter<RetoState> emit) async {
    _imagenReto=event.imagen;
    emit(state.copyWith(esFoto: true));
  }
  FutureOr<void> siguienteFoto(siguienteIngresarFoto event, Emitter<RetoState> emit) async {
 
    emit(state.copyWith(esAmigos: false,esFoto: true));
  }
 
  FutureOr<void> ingresarUsuarioPractico(ingresarUsuarioRetoParticipo event, Emitter<RetoState> emit) async {
    
    final usu=state.usuarios[event.index];
    if(usu.puesto==0){
      _listaAyudo.add(usu);
      state.usuarios[event.index].puesto=color;
    }else{
      _listaAyudo.remove(usu);
      state.usuarios[event.index].puesto=0;
    }
    emit(state.copyWith(usuarios: state.usuarios));
  }
  FutureOr<void> siguienteBuscarAmigos(siguienteRetoAmigos event, Emitter<RetoState> emit) async {
      _listaUsuarios=await _firebaseAuthDataUser.datosAmigos();
    List<Usuario> listaUsuarios=[];
    _listaUsuarios.forEach((value) {
      listaUsuarios.add(value);
      }); _listaUsuarios=await _firebaseAuthDataUser.datosAmigos();
    emit(state.copyWith(esPasos: false,esPrimer: false,esAmigos: true,usuarios: listaUsuarios));
  }
  FutureOr<void> siguientePasos(siguienteRetoPasos event, Emitter<RetoState> emit) async {
 
    emit(state.copyWith(esPasos: true,esPrimer: false));
  }

  FutureOr<void> practica(inicarReto event, Emitter<RetoState> emit) async {
    leccion=event.leccion;
    color=event.color;
    emit(state.copyWith(esPrimer: true,esFoto: false,success: false,esAmigos: false,esPasos: false));
  }

}
