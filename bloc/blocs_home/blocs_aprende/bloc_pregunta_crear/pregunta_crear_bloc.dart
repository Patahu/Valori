

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../../firebase/aut_usuario/firebase_store.dart';
import '../../../../modelos/aprende.dart';
import '../../../../modelos/leccion.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
class PreguntaLeccionCrearBloc extends Bloc<PreguntarCrearEvent, PreguntaCrearState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  DataBaseIncidentFirestore _storage=DataBaseIncidentFirestore();
  StreamSubscription? _subscriptionTodo1;
  List<String> _alternativas=[];
  Map<String,String> _subir={};
  String _respuestaCorrecta='1';
  String _tipoEjercicio='';
  String _dificultad='Fácil';
  String _imagenFuera='';
  String _descripcion='';
  late Leccion _leccion;
  PreguntaLeccionCrearBloc() : super(PreguntaCrearState.empty()) {

   

    on<CambiarTipoPregunta>(cambiarTipo);
   

    on<CrearPreguntaSeleccionarImagen>(crearPreguntaSeleccionarImagen);
    on<CrearOrdenarPregunta>(crearOrdenar);
    on<CrearCompletarPregunta>(crearCompletar);
    on<CrearAudioPregunta>(crearAudio);
    on<CrearSeleccionarAlt>(crearSeleccionarAlt);
    on<IngresarAlternativa>(ingresarAlternativa);
    on<AgregarImagenes>(ingresarImagenesDB);
    on<IngresarLeccionToEjercicios>(ingresarLeccion);
    on<AgregarPreguntaLeccionDB>(ingresarEjercicioDFinal);
    on<IngresarAlternativaOrdenar>(ingresarAlternativaOrdenar);
    on<EliminarAlternativaOrdenar>(eliminarAlternativaOrdenar);
    on<AgregarPreguntaLeccionOrdenar>(agregarPreguntaLeccionOrdenar);
    on<AgregarAudios>(ingresarAudiosDB);
    on<AgregarPreguntaLeccionSeleccionAlt>(agregarPreguntaLeccionSeleccionAlt);
    on<InitialLoadEjercicios>(initialLoadEjercicios);
    on<UpdaEjercicios>(updateEjercicios);
    on<EliminarPregunta>(elimnarPregunta);
    on<SumarRestarCantidadRepeteciciones>(SRCantidadRepeticiones);

  }
  FutureOr<void> SRCantidadRepeticiones(SumarRestarCantidadRepeteciciones event, Emitter<PreguntaCrearState> emit) async{
    
    
    
    final anterior=await _firebaseAuthDataUser.datosEjercicio(event.id);
    int repetciones=anterior.repeticion;
    if(repetciones!=0){
      repetciones+=event.cantidad;
      _firebaseAuthDataUser.actualizarEjercicioCantidadDb(repetciones,event.id);

    }else{
      repetciones+=event.cantidad;
      if(repetciones>0){
        _firebaseAuthDataUser.actualizarEjercicioCantidadDb(repetciones,event.id);

      }
    }

  }
  FutureOr<void> elimnarPregunta(EliminarPregunta event, Emitter<PreguntaCrearState> emit) async{
    _firebaseAuthDataUser.eliminarEjercicio(event.id);

  }
  FutureOr<void> initialLoadEjercicios(InitialLoadEjercicios event, Emitter<PreguntaCrearState> emit) async{
    _cancelSubscription();
    print("LLAMADAAAAAAAAAAAAAAAAAAA");
    _subscriptionTodo1 = _firebaseAuthDataUser.datosEjercciosStream(event.id).listen((element) {
  
      add(UpdaEjercicios(element));
    });
    


  }

  FutureOr<void> updateEjercicios(UpdaEjercicios event, Emitter<PreguntaCrearState> emit) async{
    emit(state.copyWith(ejercicios: event.ejercicios,isLoad: true));
    
  }
  FutureOr<void> agregarPreguntaLeccionSeleccionAlt(AgregarPreguntaLeccionSeleccionAlt event, Emitter<PreguntaCrearState> emit) async{
    _descripcion=event.descripcion;
    int contador=1;
    for(String path in _alternativas){
        final DateTime dateTime = Timestamp.now().toDate();
        final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.microsecond}';
        final String nombre=_leccion.id+timestampAsString;
        final String destino='ejercicio_imagen/fotoAlternativa/${nombre}';

        final file = File(path);
        
        UploadTask? task;

        task = _storage.uploadFile(destino, file);

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        _imagenFuera=urlDownload;
        contador++;
    }
    _alternativas=[];
    
    _respuestaCorrecta=event.respuestaCorrecta;
    _alternativas.add(event.respuestaCorrecta);
    _alternativas.add(event.a1);
    _alternativas.add(event.a2);
   
    add(AgregarPreguntaLeccionDB(event.pregunta));

  }

  FutureOr<void> ingresarAudiosDB(AgregarAudios event, Emitter<PreguntaCrearState> emit) async {
  
    int contador=0;
    for(String path in _alternativas){
              final DateTime dateTime = Timestamp.now().toDate();
        final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.microsecond}';
        final String nombre=_leccion.id+timestampAsString;
        final String destino='ejercicio_audio/${nombre}';

        final file = File(path);
        
        UploadTask? task;

        task = _storage.uploadFile(destino, file);

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        _subir[event.pares[contador]]=urlDownload;
        contador++;
    }



    add(AgregarPreguntaLeccionDB(event.pregunta));
      //
      //emit(state.activateSeleccionarAlt());
  }
  FutureOr<void> agregarPreguntaLeccionOrdenar(AgregarPreguntaLeccionOrdenar event, Emitter<PreguntaCrearState> emit) async{
    _respuestaCorrecta=event.respuestaCorrecta;
    _alternativas.add(event.respuestaCorrecta);
    _alternativas.add(event.a1);
    _alternativas.add(event.a2);
    final preguntaFinal=event.pregunta + "_________________" + event.opcional;
    add(AgregarPreguntaLeccionDB(preguntaFinal));
    
  }
  FutureOr<void> eliminarAlternativaOrdenar(EliminarAlternativaOrdenar event, Emitter<PreguntaCrearState> emit) async{
    //_alternativasOrdenar[event.key]=event.value;
    _alternativas.removeAt(event.index);
    emit(state.copyWith(listaRespuestaOrdenar: _alternativas));
    //emit(state.copyWith(isIngresarAlternativaOrdenar:true));
  }
  FutureOr<void> ingresarAlternativaOrdenar(IngresarAlternativaOrdenar event, Emitter<PreguntaCrearState> emit) async{
    //_alternativasOrdenar[event.key]=event.value;
    emit(state.copyWith(isIngresarAlternativaOrdenar:true));
  }
  FutureOr<void> ingresarLeccion(IngresarLeccionToEjercicios event, Emitter<PreguntaCrearState> emit) async{
    _leccion=event.leccion;
    print("HERRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    add(CambiarTipoPregunta('seleccionar'));

  }
  FutureOr<void> ingresarImagenesDB(AgregarImagenes event, Emitter<PreguntaCrearState> emit) async {
    emit(state.copyWith(isLoading: true));
    int contador=1;
   
    for(String path in _alternativas){
        final DateTime dateTime = Timestamp.now().toDate();
        final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.microsecond}';
        final String nombre=_leccion.id+timestampAsString;
        final String destino='ejercicio_imagen/fotoAlternativa/${nombre}';

        final file = File(path);
        
        UploadTask? task;

        task = _storage.uploadFile(destino, file);

        final snapshot = await task!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        _subir[contador.toString()]=urlDownload;
        contador++;
    }



    add(AgregarPreguntaLeccionDB(event.pregunta));
      //
      //emit(state.activateSeleccionarAlt());
  }
  FutureOr<void> ingresarEjercicioDFinal(AgregarPreguntaLeccionDB event, Emitter<PreguntaCrearState> emit) async {
    if(_tipoEjercicio=='seleccionar'){
          _firebaseAuthDataUser.crearEjerciciodDb(
        alcance: 'leccion',
        id_leccion: _leccion.id,
        pregunta: event.pregunta,
        respuesta: _subir[_respuestaCorrecta],
        tipo: _tipoEjercicio,
        alternativas: _subir
        
      );


    
    }else if(_tipoEjercicio=='ordenar'){
      
      _firebaseAuthDataUser.crearEjerciciodDb(
        alcance: 'leccion',
        id_leccion: _leccion.id,
        pregunta: event.pregunta,
        respuesta: res(_alternativas),

        tipo: _tipoEjercicio,
        alternativas: convertirListaEnMapa(_alternativas),
        
      );

    }else if(_tipoEjercicio=='completar'){
      _firebaseAuthDataUser.crearEjerciciodDb(
        alcance: 'leccion',
        id_leccion: _leccion.id,
        pregunta: event.pregunta,
        respuesta: _respuestaCorrecta,
  
        tipo: _tipoEjercicio,
        alternativas: convertirListaEnMapa(_alternativas),
        
      );
      
    }else if(_tipoEjercicio=='audio'){
      _firebaseAuthDataUser.crearEjerciciodDb(
        alcance: 'leccion',
        id_leccion: _leccion.id,
        pregunta: event.pregunta,
        respuesta: '',
  
        tipo: _tipoEjercicio,
        alternativas: _subir,
        
      );
    
    }else if(_tipoEjercicio=='seleccionarAlt'){

      _firebaseAuthDataUser.crearEjerciciodDb(
        alcance: 'leccion',
        id_leccion: _leccion.id,
        pregunta: event.pregunta,
        respuesta: _respuestaCorrecta,

        tipo: _tipoEjercicio,
        alternativas: convertirListaEnMapa(_alternativas),
        imagenFuera: _imagenFuera,
        descripcion: _descripcion,
        
      );
      
    }
    emit(state.copyWith(isLoading: false));

      //
      //emit(state.activateSeleccionarAlt());
  }

  Map<String, String> convertirListaEnMapa(List<String> lista) {
    Map<String, String> mapa = {};
    int contador=0;
    for (String item in lista) {
      mapa[contador.toString()] = item;
      contador++;
    }
    return mapa;
  }
  String res(List<String> lista) {
    String re = '';
    int contador=0;
    for (String item in lista) {
      if(contador==0){
        re+=item;
      }else{
        re+=" "+item;
      }
      
      contador++;
   
    }
    return re;
  }
  FutureOr<void> ingresarAlternativa(IngresarAlternativa event, Emitter<PreguntaCrearState> emit) async {



    if(_tipoEjercicio=='seleccionar'){
      // El index en los botones comienza por 1
      _alternativas.add(event.value);
      if(event.isRespuesta){
        _respuestaCorrecta=event.key;
      }
      print("INGRESO ALTERNATIVAAAAAAAAAAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print("key"+_alternativas.toString());
    
    }else if(_tipoEjercicio=='ordenar'){
      _alternativas.add(event.value);
      emit(state.copyWith(listaRespuestaOrdenar: _alternativas,isIngresarAlternativaOrdenar:false));
   
    }else if(_tipoEjercicio=='completar'){
      
    }else if(_tipoEjercicio=='audio'){
      _alternativas.add(event.value);
      
    }else if(_tipoEjercicio=='seleccionarAlt'){
      _alternativas.add(event.value);
      
    }
  }
  FutureOr<void> cambiarTipo(CambiarTipoPregunta event, Emitter<PreguntaCrearState> emit) async {
    _tipoEjercicio=event.tipo;
    List<String> _alternativas=[];
    Map<String,String> _subir={};
    String _respuestaCorrecta='1';
    String _dificultad='Fácil';
    String _imagenFuera='';
    String _descripcion='';
    if(event.tipo=='seleccionar'){
      add(CrearPreguntaSeleccionarImagen());
    }else if(event.tipo=='ordenar'){
      add(CrearOrdenarPregunta());
    }else if(event.tipo=='completar'){
      add(CrearCompletarPregunta());
    }else if(event.tipo=='audio'){
      add(CrearAudioPregunta());
    }else if(event.tipo=='seleccionarAlt'){
      add(CrearSeleccionarAlt());
    }
  }
  FutureOr<void> crearSeleccionarAlt(CrearSeleccionarAlt event, Emitter<PreguntaCrearState> emit) async {

      emit(state.activateSeleccionarAlt());
  }
  FutureOr<void> crearAudio(CrearAudioPregunta event, Emitter<PreguntaCrearState> emit) async {
      emit(state.activateAudio());
  }
  FutureOr<void> crearCompletar(CrearCompletarPregunta event, Emitter<PreguntaCrearState> emit) async {

      emit(state.activateCompletar());
  }
   FutureOr<void> crearOrdenar(CrearOrdenarPregunta event, Emitter<PreguntaCrearState> emit) async {
    emit(state.activateOrdenar());

  }




  FutureOr<void> crearPreguntaSeleccionarImagen(CrearPreguntaSeleccionarImagen event, Emitter<PreguntaCrearState> emit) async {

    emit(state.activateSeleccionar());
  }


  // Método para cancelar la suscripción
  void _cancelSubscription() {
    if (_subscriptionTodo1 != null) {
      _subscriptionTodo1!.cancel();
    }
  }
  @override
  Future<void> close() {
    _cancelSubscription();
    return super.close();
  }
}
