
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/modelos/validators.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';

import '../../../../modelos/ejercicio.dart';
import '../../../../modelos/leccion.dart';
import '../../../../modelos/resume.dart';
import 'bloc.dart';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
class EjercicioBloc extends Bloc<EjercicioEvent, EjercicioState> {
  final FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  AudioPlayer audioPlayer = AudioPlayer();
  late Leccion _leccion;
  late List<Ejercicio>_idEjercicios;
  //final List<String>_tipoEjercicios=[];
  final List<bool>_respuestaValidated=[];
  Map<String,String> _respuesta={};
  late Ejercicio _ejercicio;
  bool _isAudio=false;
  int _orden=0;
  int _bucleinterno=1;
  int _ordenAudio=0;
  final int aumento=10; // CANTIDAD DE RECOMPENSA PORPREGUNTA BIEN ECHA
  final int incorrecto=-2; // CANTIDAD DE DESCUENTO POR PREGUNTA MAL ECHA
  late Map<String,String> _alternativasCorrectas;
  EjercicioBloc() : super(EjercicioState.empty()) {
    on<BuscarEjercicio>(busEjercicio);
    on<reloadEjercicio>(updaLista);
    on<UpdateEjercicioToLeccion>(cargarEjercicioLeccion);
    on<UpdateEjercicioToEjercicio>(cargarEjercicios);
    on<UIngresarRespuestaOrdenar>(cambioRespuestaOrdenar);
    on<UEliminarRespuestaOrdenar>(cambioRespuestaEliminarOrdenar);
    on<comprobarRespuestaPregunta>(comprobarRespuesta);
    on<IniciarAudio>(escucharElAudio);
  }
  FutureOr<void> escucharElAudio(IniciarAudio event, Emitter<EjercicioState> emit) async {
        print("AUDIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
         /*
        _respuesta.forEach((key, value) { 
          if(value==''){
            _respuesta[key]=event.urlAudio;

          }else{
            _respuesta['0']=event.urlAudio;
          }
        });
        if(_respuesta.isEmpty){
          _respuesta['0']=event.urlAudio;
        }*/
        if(!_isAudio){

              try {
              // Get a reference to the audio file in Firebase Storage
              final reference = _storage.refFromURL(event.urlAudio);

              // Get a downloadable URL for the audio file
              final downloadUrl = await reference.getDownloadURL();
              await audioPlayer.release();
              // Play the audio using the downloadable URL
              await audioPlayer.play(UrlSource(downloadUrl));
              _isAudio=true;
              emit(state.activateAudio(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));
              //emit(AudioState.playing()); // Update state to indicate playing
            } catch (error) {
              print('Error playing audio-----------------------------------: $error');
              //emit(AudioState.errorAudio(error.toString())); // Update state with error
            }
        }else{
          audioPlayer.stop();
          _isAudio=false;
        }


  }

  FutureOr<void> comprobarRespuesta(comprobarRespuestaPregunta event, Emitter<EjercicioState> emit) async {
      if(_ejercicio.tipo=="seleccionar"){
        print("REDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDdddddddddddddddddddddd");
        print(_respuesta);
        if(_respuesta.containsValue(_ejercicio.respuesta)){
          _respuestaValidated.add(true);
          emit(state.copyWith(isSuccess: true,isFail: false,isResume: false));
         
          
        }else{
           _respuestaValidated.add(false);
          emit(state.copyWith(isFail: true,isSuccess: false,isResume: false));

        }
        add(reloadEjercicio());
        //emit(state.activateSeleccionar(ejercicio: _ejercicio));
      }else if(_ejercicio.tipo=="ordenar"){
        String res="";
        _respuesta.forEach((key, value) {
          res+="$value ";
          
        });
        final resFin=_ejercicio.respuesta+" ";
        
        if(resFin==res){
          _respuestaValidated.add(true);
          emit(state.copyWith(isSuccess: true,isFail: false,isResume: false));
        }else{
           _respuestaValidated.add(false);
          emit(state.copyWith(isFail: true,isSuccess: false,isResume: false));

        }
        add(reloadEjercicio());
        //emit(state.activateOrdenar(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));

      }else if(_ejercicio.tipo=="completar"){
        //emit(state.activateCompletar(ejercicio: _ejercicio));
        String res="";
        _respuesta.forEach((key, value) {
          res+="$value ";
          
        });
        final resFin=_ejercicio.respuesta+" ";
        
        if(resFin==res){
          _respuestaValidated.add(true);
          emit(state.copyWith(isSuccess: true,isFail: false,isResume: false));
        }else{
          _respuestaValidated.add(false);
          emit(state.copyWith(isFail: true,isSuccess: false,isResume: false));

        }
        add(reloadEjercicio());

      }else if(_ejercicio.tipo=="seleccionarAlt"){
        String res="";
        _respuesta.forEach((key, value) {
          res+="$value ";
          
        });
        final resFin=_ejercicio.respuesta+" ";
        
        if(resFin==res){
          _respuestaValidated.add(true);
          emit(state.copyWith(isSuccess: true,isFail: false,isResume: false));
        }else{
          _respuestaValidated.add(false);
          emit(state.copyWith(isFail: true,isSuccess: false,isResume: false));

        }
        add(reloadEjercicio());
        //emit(state.activateSeleccionarAlt(ejercicio: _ejercicio));
        
      }else if(_ejercicio.tipo=="audio"){
        String res="";
        final Map<String,String> ff={};
        _respuesta.forEach((key, value) {
          ff[key.substring(1,key.length)]=value.substring(1,value.length);

        });
        final es=verificarElementosEnAmbos(ff,_alternativasCorrectas);
        if(es){
          _respuestaValidated.add(true);
          emit(state.copyWith(isSuccess: true,isFail: false));
        }else{
          _respuestaValidated.add(false);
          emit(state.copyWith(isFail: true,isSuccess: false));

        }
        add(reloadEjercicio());
        //emit(state.activateSeleccionarAlt(ejercicio: _ejercicio));
        
      }
      //_respuesta.remove(event.idAlternativa);
     // emit(state.copyWith(listaRespuestaOrdenar: _respuesta,isOrdenar: true,isSeleccionar: false,isCompletar: false));

  }


  bool verificarElementosEnAmbos(Map<String, String> mapa1, Map<String, String> mapa2) {
    // Verificar si los dos mapas tienen la misma cantidad de elementos
    if (mapa1.length != mapa2.length) {
      return false;
    }
    
    // Iterar sobre las claves del primer mapa
    for (var clave in mapa1.keys) {
      // Verificar si la clave está presente en el segundo mapa
      if (!mapa2.containsKey(clave)) {
        return false;
      }
      
      // Verificar si los valores asociados son iguales
      if (mapa1[clave] != mapa2[clave]) {
        return false;
      }
    }
    
    // Si no se encontraron diferencias, entonces los mapas son iguales
    return true;
  }
  FutureOr<void> cambioRespuestaEliminarOrdenar(UEliminarRespuestaOrdenar event, Emitter<EjercicioState> emit) async {
    _respuesta.remove(event.idAlternativa);
    if(_ejercicio.tipo=="ordenar"){
      emit(state.copyWith(listaRespuestaOrdenar: _respuesta,isOrdenar: true,isSeleccionar: false,isCompletar: false));

    }else if(_ejercicio.tipo=='completar'){
      emit(state.copyWith(listaRespuestaOrdenar: _respuesta,isOrdenar: false,isSeleccionar: false,isCompletar: true));

    }
    

  }
  FutureOr<void> cambioRespuestaOrdenar(UIngresarRespuestaOrdenar event, Emitter<EjercicioState> emit) async {
    
      
      if(_ejercicio.tipo=="seleccionar"){
        _respuesta={};
        print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
        print(event.value);
        _respuesta['${event.key}']=event.value;
        emit(state.activateSeleccionar(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));
      }else if(_ejercicio.tipo=="ordenar"){
        _respuesta['${event.key}']=event.value;
        emit(state.activateOrdenar(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));

      }else if(_ejercicio.tipo=="completar"){
         _respuesta={};
        _respuesta['${event.key}']=event.value;
        emit(state.activateCompletar(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));

      }else if(_ejercicio.tipo=="seleccionarAlt"){
         _respuesta={};
        _respuesta['${event.key}']=event.value;
        emit(state.activateSeleccionarAlt(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));
      }else if(_ejercicio.tipo=="audio"){  
     
        if(_ordenAudio<3){          
           print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
        if(event.key=='0'){ //ES AUDIO
            _respuesta['0']="$_ordenAudio${event.value}";
          }
        if(event.value==''){ // ES ID
              if(_respuesta['0']!=null){ // YA EXISTE AUDIO?  
                final id="$_ordenAudio${event.key}";
                _respuesta[id]=_respuesta['0']!;
                _respuesta.remove('0');
                _ordenAudio++;
                
              }
      
          }
        emit(state.activateAudio(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));
        }

      }
      
  }

  FutureOr<void> busEjercicio(BuscarEjercicio event, Emitter<EjercicioState> emit) async {
    // Cancelar la suscripción existente antes de establecer una nueva

 
  _leccion=event.leccion;
  
  _idEjercicios= await _firebaseAuthDataUser.datosEjerciciosDesdeLeccion(event.leccion.id);
  print("DE TIPO LECCIONCCCCCCCCCCCCZZZZZZZZZZZZZZ  " + _idEjercicios.length.toString());
  if(_idEjercicios.isNotEmpty){
    add(reloadEjercicio());

  }else{
    emit(state.copyWith(isFinish: true));
  }

  


  }
  // ACTUALMENTE EN DESUSO
  FutureOr<void> cargarEjercicioLeccion(UpdateEjercicioToLeccion event, Emitter<EjercicioState> emit) async {
   
   
   final lec=await _firebaseAuthDataUser.datosLeccion(event.ejercicio);
    _respuestaValidated.add(true);
   emit(state.activateLeccion(leccion: lec,ejercicio: _ejercicio));
   
      
  }


  FutureOr<void> cargarEjercicios(UpdateEjercicioToEjercicio event, Emitter<EjercicioState> emit) async {
    // Cancelar la suscripción existente antes de establecer una nueva

       _ejercicio=event.ejercicio;

      _ejercicio.numeroOrden=[_orden,_idEjercicios.length];// ORDEN , TOTAL 
      _alternativasCorrectas=_ejercicio.alternativas;
      final ew= desordenarDiccionario(_ejercicio.alternativas);;
      _ejercicio.alternativas=ew;
      emit(state.activateTime());
      if(_ejercicio.tipo=="seleccionar"){
        emit(state.activateSeleccionar(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));
      }else if(_ejercicio.tipo=="ordenar"){
        emit(state.activateOrdenar(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));

      }else if(_ejercicio.tipo=="completar"){
        emit(state.activateCompletar(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));

      }else if(_ejercicio.tipo=="seleccionarAlt"){
        emit(state.activateSeleccionarAlt(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));
      }else if(_ejercicio.tipo=="audio"){
        emit(state.activateAudio(ejercicio: _ejercicio,listaRespuestaOrdenar: _respuesta));
      }
      
      

  }
  FutureOr<void> updaLista(reloadEjercicio event, Emitter<EjercicioState> emit) async {
    _respuesta={};
    _ordenAudio=0;
    if(_idEjercicios.length>_orden){
      if(_idEjercicios[_orden].repeticion>_bucleinterno){
        add(UpdateEjercicioToEjercicio(_idEjercicios[_orden]));
        _bucleinterno++;
      }else{
        add(UpdateEjercicioToEjercicio(_idEjercicios[_orden]));
        _bucleinterno=1;
        _orden++;
      }      
    }else{
      emit(state.copyWith(isFinish: true));
      int contadorPositivo=0;
      int contadorNegativo=0;    
      print("AUMENTARRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
      print(_respuestaValidated.length);
      for(bool element in _respuestaValidated){
        if(element){
          contadorPositivo++;
        }else{
          contadorNegativo++;
        }
      }
 

      final res= Resume(correctas: contadorPositivo, 
        numeroOrden: 0, 
        puntajeCorrectas: contadorPositivo*aumento, 
        incorrectas: contadorNegativo, 
        puntajeIncorrectas: -contadorNegativo*incorrecto
        ,tipo: 'ejercicio',
         indexTemporal: _leccion.indexTemporal
        );
      final user = await _firebaseAuthDataUser.getUsuario();

        
      if(_leccion.es_echoo || _leccion.es_visto){
        print("ESTA ECHOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
          final progresado=await _firebaseAuthDataUser.datosLeccionProgresado(_leccion.id,user.id);
          await _firebaseAuthDataUser.modificarLeccionProgreso(progresado!.fue_visto,true,progresado.id);
      }else{ print("NOOOOOOOOOOOOO ESTA ECHOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
          await _firebaseAuthDataUser.crearLeccionProgresoPregunta(false, _leccion.id_aptitud, _leccion.id_habilidad, _leccion.id, user.id);
          //crearLeccionProgreso
          
      }
      if(!_leccion.es_echoo){
        await _firebaseAuthDataUser.ingresarProgreso(res.pcorrectas-res.pincorrectas,user); ///AUMENTO ESTA AQUI S

      }
      emit(state.activateResume(resume: res));
    }


  }

  Map<String, String> desordenarDiccionario(Map<String, String> original) {
    // Crear una lista de llaves y desordenarla
    List<String> llaves = original.keys.toList()..shuffle(Random());
    List<String> values = original.values.toList()..shuffle(Random());

    // Crear un nuevo diccionario vacío para almacenar el resultado
    Map<String, String> resultado = {};
    for( int i = 0 ; i < original.length; i++ ) { 
      final key=llaves[i];
      final llave=values[i];
      resultado[key]=llave;
   } 

    print("RRRRRRRRRRRRRRRRR---------------------------------------***************");
    // Imprimir el diccionario resultante
    resultado.forEach((key, value) {
      print('$key: $value');
    });

    // Devolver el diccionario resultante
    return resultado;
  }
  @override
  Future<void> close() async {
    try {
      await audioPlayer.stop(); // Stop audio playback before closing
    } catch (error) {
      print('Error stopping audio player: $error');
    }
    await super.close();
  }

}