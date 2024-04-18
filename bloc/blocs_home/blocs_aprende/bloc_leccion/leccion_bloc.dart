
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/modelos/validators.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../modelos/leccion.dart';
import 'bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LeccionBloc extends Bloc<LeccionEvent, LeccionState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  StreamSubscription? _subscriptionTodo1;
  String _habilidad='';
  Function() listener=(){};
  late String _tiempo='0';
  bool _isActive=false;
  late String _nombre='';
  YoutubePlayerController controller=YoutubePlayerController(initialVideoId: '');
  List<String> _alternativas=[];
  String _imagen='';
  String _dificultad='Fácil';
  LeccionBloc() : super(LeccionState.empty()) {
    on<BuscarLeccion>(busAprende);
    on<UpdaLeccion>(updaLista);
    on<CrearLeccion>(crearLeccion);

    on<IngresarLeccion>(ingresarLeccion);
    on<CargarVideo>(cargarVideo);
    on<DeterTiempo>(determinarTiempo);
    on<ActualizarLeccion>(actualizarLeccion);
    on<ActualizarLeccionDB>(actualizarLeccionDB);
    on<EliminarLeccion>(eliminarLeccion);
    on<IngresarImagenLeccion>(ingresarImagenLeccion);
    on<IngresarDificutaldLeccion>(ingresarDificultad);
    //on<VolverLeccion>(volverLeccion);
    on<LoadEspecialRerporteEjercicios>(backLoadEspecialRerporteEjercicios);
    on<LoadEspecialRerporteEjerciciosOtraVez>(backLoadEspecialRerporteEjerciciosOtra);
    on<IngresarActualizarLeccion>(ingresarLeccionAcc);
    on<RealiarCopiaBu>(realizarUnaCopiaBu);
    on<ContinuarIngresBuDB>(continuarRB);
    on<CrearLeccionEspecial>(crearLeccionEspecial);
    on<ReiniciarBuscarEspecial>(busAprendeReiniciar);
    on<IngresarAlternativaOrdenarReto>(ingresarAlternativaOrdenarReto);
    on<IngresarAlternativaReto>(ingresarAlternativa);
    on<EliminarAlternativaOrdenarR>(eliminarAlternativaOrdenarAlter);
  }
    FutureOr<void> eliminarAlternativaOrdenarAlter(EliminarAlternativaOrdenarR event, Emitter<LeccionState> emit) async{
    //_alternativasOrdenar[event.key]=event.value;
    _alternativas.removeAt(event.index);
    emit(state.copyWith(listaRespuestaOrdenar: _alternativas));
    //emit(state.copyWith(isIngresarAlternativaOrdenar:true));
  }
  FutureOr<void> ingresarAlternativaOrdenarReto(IngresarAlternativaOrdenarReto event, Emitter<LeccionState> emit) async{
    //_alternativasOrdenar[event.key]=event.value;
    emit(state.copyWith(isIngresarAlternativaOrdenar:true));
  }
  FutureOr<void> ingresarAlternativa(IngresarAlternativaReto event, Emitter<LeccionState> emit) async {

      _alternativas.add(event.value);
      emit(state.copyWith(listaRespuestaOrdenar: _alternativas,isIngresarAlternativaOrdenar:false));

  }
  FutureOr<void> busAprendeReiniciar(ReiniciarBuscarEspecial event, Emitter<LeccionState> emit) async {
    // Cancelar la suscripción existente antes de establecer una nueva
    _cancelSubscription();
    _subscriptionTodo1 = _firebaseAuthDataUser.datosLecciones(_habilidad).listen((lecciones) {
      final leccionesOrdenadas = ordenarLecciones(lecciones);
      add(UpdaLeccion(leccionesOrdenadas));
    });
  }
  FutureOr<void> crearLeccionEspecial(CrearLeccionEspecial event, Emitter<LeccionState> emit) async {
    final DateTime dateTime = Timestamp.now().toDate();
    final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}';
    _nombre='e-'+timestampAsString;
    final leccionCopiada=Leccion.copyFromImID(Leccion.empty(), _nombre);
    emit(state.activateCrearLeccion(leccionCM: leccionCopiada,));
   

  }
  FutureOr<void> continuarRB(ContinuarIngresBuDB event, Emitter<LeccionState> emit) async {
    

      final List<String> idAbusadores=[];
      event.abusadores.forEach((element) { 
        idAbusadores.add(element.id);
      });

      try{
        
          _firebaseAuthDataUser.crearLecciondDbA(
          id: _nombre,
          alcance:'especial',
          fecha_ingresa:Timestamp.now(),
          descripcion:'',
          duracion_video:'',
          id_aptitud:'',
          id_habilidad:'',
          imagen:'https://firebasestorage.googleapis.com/v0/b/valorixdb.appspot.com/o/ejercicio_imagen%2FfotoReto%2F113bc53796507786676b786106e2c32e.png?alt=media&token=f94e1685-4da1-43ad-a59d-0c9b37af6974',
          titulo:'Tienes ejercicios de un reporte de violencia',
          video:'',
          es_pregunta:true,
          es_video:false,
          dificultad: '',
          usuarios: idAbusadores,
        );
    
        emit(state.successActivate());
        
      //controller.play();
      }catch(e){
        emit(state.failActivate());
      }

  


  }
  FutureOr<void> realizarUnaCopiaBu(RealiarCopiaBu event, Emitter<LeccionState> emit) async {
    final DateTime dateTime = Timestamp.now().toDate();
    final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}';
    _nombre='e-'+timestampAsString;
    //_imagen=state.leccionCM!.imagen;

    final ejerciciosACopiar=await _firebaseAuthDataUser.datosEjerciciosDesdeLeccion(state.leccionCM.id);
    ejerciciosACopiar.forEach((element) {
      final DateTime dateTime = Timestamp.now().toDate();
      final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}${dateTime.microsecond}';
      final ids='ce-'+timestampAsString;
      _firebaseAuthDataUser.crearEjerciciodDb(
        alcance: 'especial',
        id_leccion: _nombre,
        pregunta: element.pregunta,
        respuesta: element.respuesta,
        id: ids,
        tipo: element.tipo,
        alternativas: element.alternativas,
        descripcion: element.descripcion,
        imagenFuera: element.imagenFuera,
      );
    });
    final leccionCopiada=Leccion.copyFromImID(state.leccionCM, _nombre);
    emit(state.activateActualizarLeccion(leccionCM: leccionCopiada,));
  }
  FutureOr<void> ingresarLeccionAcc(IngresarActualizarLeccion event, Emitter<LeccionState> emit) async {
    



    emit(state.copyWith(leccionCM: event.leccion));


  }
  FutureOr<void> backLoadEspecialRerporteEjerciciosOtra(LoadEspecialRerporteEjerciciosOtraVez event, Emitter<LeccionState> emit) async {
    emit(state.copyWith(isActualizarLeccion: false,isLoadLeccion: true,success:false,fail: false,isCrearLeccion: false));

  }
  FutureOr<void> backLoadEspecialRerporteEjercicios(LoadEspecialRerporteEjercicios event, Emitter<LeccionState> emit) async {
    emit(state.copyWith(isLoadLeccion: false,isCrearLeccion: false,isActualizarLeccion: false));


  }
  /*FutureOr<void> volverLeccion(VolverLeccion event, Emitter<LeccionState> emit) async {
    //emit(state.copyWith(isLoadVideo: false,isCanCreate: false));


  }*/
  FutureOr<void> ingresarDificultad(IngresarDificutaldLeccion event, Emitter<LeccionState> emit) async {

    _dificultad=event.dificultad;
    print(_dificultad);

  }
   
    FutureOr<void> ingresarImagenLeccion(IngresarImagenLeccion event, Emitter<LeccionState> emit) async {

    _imagen=event.imagen;
    
    final leccion=Leccion.copyFromIm(state.leccionCM,_imagen);
    emit(state.copyWith(leccionCM: leccion));
  }
   
  FutureOr<void> eliminarLeccion(EliminarLeccion event, Emitter<LeccionState> emit) async {

    _firebaseAuthDataUser.eliminarLeccion(event.leccion.id);
    //emit(state.activateActualizarLeccion(leccion: event.leccion));
  }
  FutureOr<void> actualizarLeccionDB(ActualizarLeccionDB event, Emitter<LeccionState> emit) async {

        try{
          _firebaseAuthDataUser.modificarLeccionDb(
          descripcion:event.descripcion,
          imagen:_imagen,
          titulo:event.titulo,
          video:event.enlace,
          idLeccion: state.leccionCM.id, //STATE AQUI P
          duracionVideo: _tiempo,
          dificultad: _dificultad,
          pasos: _alternativas,
 
      );
  
      emit(state.successActivate());
      
    //controller.play();
    }catch(e){
      emit(state.failActivate());
    }
    //emit(state.activateActualizarLeccion(leccion: event.leccion));
  }
  FutureOr<void> actualizarLeccion(ActualizarLeccion event, Emitter<LeccionState> emit) async {

    _imagen=event.leccion.imagen;
    _alternativas=event.leccion.pasos;
    emit(state.activateActualizarLeccion(leccionCM: event.leccion,pasos:_alternativas));
  }
  FutureOr<void> cargarVideo(CargarVideo event, Emitter<LeccionState> emit) async {
   
      var id = YoutubePlayer.convertUrlToId(
                        event.enlace,
                      ) ??
                      '';
   

      if(id.isNotEmpty){
          try{

              
              if(!_isActive){
                _isActive=true;
              controller = YoutubePlayerController(
                  initialVideoId: id,
                  flags: const YoutubePlayerFlags(
                  mute: true,
                  autoPlay: true,
                  disableDragSeek: false,
                  loop: false,
                  isLive: false,
                  forceHD: false,
                  enableCaption: true,
                    ),
              );
      
                // Inicializar el listener y guardarlo en una variable
              listener = () {
                
              final position = controller.value.position.inSeconds;
              final duration = controller.value.metaData.duration.inSeconds;
                  
            
              if(duration!=0){
                    add(DeterTiempo(tiempo: duration));
                  }
                // controller.removeListener(_listener);
                

              };
              
                
              controller.addListener(listener);
              emit(state.copyWith(isLoadVideo: true));
            }else{
              _isActive=false;
              emit(state.copyWith(isLoadVideo: false,isCanCreate: false));
              await Future.delayed(Duration(milliseconds: 100));
    
              add(CargarVideo(enlace: event.enlace));
            }




        }catch(e){
          emit(state.copyWith(isLoadVideo: false));
          print("ERROR EN LA CARGA DEL VIDEO "+e.toString());

        }



      }else{

        emit(state.copyWith(isLoadVideo: false));
      }

  }
  FutureOr<void> determinarTiempo(DeterTiempo event, Emitter<LeccionState> emit) async {
  
 
    int minutos = event.tiempo ~/ 60; // Obtiene los minutos
    int segundos = event.tiempo % 60; // Obtiene los segundos

    String minutosS='';
    String segundosS='';
    if(minutos>10){
      minutosS=minutos.toString();
    }else{
      minutosS='0'+minutos.toString();
    }
    if(segundos>10){
      segundosS=segundos.toString();
    }else{
      segundosS='0'+segundos.toString();
    }
    _tiempo=minutosS +':'+segundosS +' min';


    
    controller.pause();
    controller.removeListener(listener);
    emit(state.copyWith(isCanCreate: true));
  }
  FutureOr<void> ingresarLeccion(IngresarLeccion event, Emitter<LeccionState> emit) async {

    // TIPO 1 SON PARA TODO APRENDER (SOLO VIDEO) es_pregunta: false, es_video:true
    // TIPO 2 VIDEO Y PREGUNTAS es_pregunta: true, es_video:true
    // TIPO 3 SOLO PREGUNTAS es_pregunta: true, es_video:false
    Map<String,bool> far={'es_pregunta':false,'es_video':true}; // tipo1
    if(event.tipo=='2'){
      far={'es_pregunta':true,'es_video':true}; // tipo 2
    }else if(event.tipo=='3'){
      far={'es_pregunta':true,'es_video':false}; // tipo 3
    }

    try{
       
      _firebaseAuthDataUser.crearLecciondDb(
      id: _nombre,
      alcance:event.habilidad.alcance=='global'?'global':'habilidad',
      fecha_ingresa:Timestamp.now(),
      descripcion:event.descripcion,
      duracion_video:_tiempo,
      id_aptitud:event.id_aptitud,
      id_habilidad:event.habilidad.id,
      imagen:event.imagen!='' ? _imagen:event.imagen,
      titulo:event.titulo,
      video:event.enlace,
      es_pregunta:far['es_pregunta'],
      es_video:far['es_video'],
      dificultad: _dificultad,
      pasos: _alternativas,
      );
  
      emit(state.successActivate());
      
    //controller.play();
    }catch(e){
      emit(state.failActivate());
    }

    //Timestamp.now()
    //emit(state.update(isNewMessaging: true, habilidades: event.habilidades));
  }
  FutureOr<void> crearLeccion(CrearLeccion event, Emitter<LeccionState> emit) async {
    final DateTime dateTime = Timestamp.now().toDate();
    final String timestampAsString = '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}';
    _nombre=_habilidad+timestampAsString;
    final leccion=Leccion.copyFromID( Leccion.empty(),_nombre);
    _alternativas=[];
   
    emit(state.activateCrearLeccion(leccionCM: leccion,));

  }


  FutureOr<void> busAprende(BuscarLeccion event, Emitter<LeccionState> emit) async {
    // Cancelar la suscripción existente antes de establecer una nueva
    _cancelSubscription();
    _habilidad=event.habilidadID;
    _subscriptionTodo1 = _firebaseAuthDataUser.datosLecciones(event.habilidadID).listen((lecciones) {
      
      final leccionesOrdenadas = ordenarLecciones(lecciones);
      add(UpdaLeccion(leccionesOrdenadas));
    });
  }
  List<Leccion> ordenarLecciones(List<Leccion> lecciones) {
  lecciones.sort(compararLecciones);
  return lecciones;
  }
  int compararLecciones(Leccion a, Leccion b) {
    return a.fecha_ingresada.compareTo(b.fecha_ingresada);
  }
  FutureOr<void> updaLista(UpdaLeccion event, Emitter<LeccionState> emit) async {
    if(event.lecciones.isNotEmpty){

      final user = await _firebaseAuthDataUser.getUsuario();
      final listaProgreso=await _firebaseAuthDataUser.datosLeccionesProgreso(_habilidad,user.id);
      List<Leccion> leccionesVer=[];
      event.lecciones.forEach((element) {
        leccionesVer.add(element);
      });
    
      listaProgreso.forEach((leccionProgreso) {
        leccionesVer.forEach((leccion) {
          if(leccionProgreso.id_leccion==leccion.id){
            leccion.es_echoo=leccionProgreso.fue_echo;
            leccion.es_visto=leccionProgreso.fue_visto;
            //leccion.es_pregunta=leccionProgreso.es_pregunta;
          }   
        });
      });
      final leccionCaido=encontrarPrimeraLeccionNoEcho(leccionesVer);

      emit(state.activateLoadLecciones(isLoadLeccion: true, leccionesVer: leccionesVer,leccion: leccionCaido));

    }else{
      emit(state.copyWith(isLoadLeccion: true, lecciones: [],leccion: Leccion.empty()));

    }



  }

  // Método para cancelar la suscripción
  void _cancelSubscription() {
    if (_subscriptionTodo1 != null) {
      _subscriptionTodo1!.cancel();
    }
  }

  @override
  Future<void> close() {
    // Asegurarse de cancelar la suscripción al cerrar el Bloc
    _cancelSubscription();
    controller.dispose();
    return super.close();
  }

  Leccion encontrarPrimeraLeccionNoEcho(List<Leccion> lecciones) {
  for (int i = 0; i < lecciones.length; i++) {
    var lc=Validators.determinarCon(lecciones[i].es_visto,lecciones[i].es_pregunta,lecciones[i].es_echoo);//determinarCon(lecciones[i].es_visto,lecciones[i].es_pregunta,lecciones[i].es_echoo);
    if (!lc) {
      lecciones[i].index=i+1;
      return lecciones[i];
    }
  }
  // Si no se encuentra ninguna lección sin _es_echo en true, se devuelve una lección vacía o null, según sea necesario.
  return lecciones[0]; // O return null;
}
}