

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/leccion_progreso.dart';
import 'package:valorix/src/modelos/resume.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';

import '../../../../modelos/leccion.dart';
import '../../../../modelos/resultado.dart';
import '../../../../modelos/usuario.dart';
import '../../../../modelos/validators.dart';
import 'bloc.dart';


import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class YoutubePlayerBloc extends Bloc<YoutubePlayerEvent, YoutubePlayerState> {
  late YoutubePlayerController controller;
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  late Function() _listener;
  late Leccion _leccion;
  final int porcentajeVer=80; // PORCENTAJE MINIMO PARA DECIRSE QUE EL VIDEO FUE VISTO
  final int aumento=10; // CANTIDAD DE RECOMPENSA POR EL VIDEO
  YoutubePlayerBloc() :super(YoutubePlayerState.empty()) {

      on<LoadVideo>(lvideo);
      on<PlayVideo>(pvideo);
      on<PauseVideo>(pauvideo);
      on<UpdatePlayerEvent>(cumplioVisto);
      on<iniciarVideo>(initvideo);
      on<ChangSound>(changeSound);
  }

  FutureOr<void> initvideo(iniciarVideo event, Emitter<YoutubePlayerState> emit) async {
    _leccion=event.leccion;
    var id = YoutubePlayer.convertUrlToId(
                        event.leccion.video,
                      ) ??
                      '';
   
    controller = YoutubePlayerController(
    initialVideoId: id,
              flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
          ),
     );
   // Listener para el tiempo de reproducción del video
  
    controller.setVolume(50);
  


    bool variable= true;
  
    // Inicializar el listener y guardarlo en una variable
    _listener = () {
      final position = controller.value.position.inSeconds;
      final duration = controller.value.metaData.duration.inSeconds;
      if (position % 2 == 0 && variable) {
        variable = false;
        // Lógica que deseas ejecutar cuando la posición es par
        add(UpdatePlayerEvent(duration: duration, position: position));
      }
      if (position % 2 != 0) {
        variable = true;
      }
    };

    if(!_leccion.es_visto){
      controller.addListener(_listener);
      emit(state.copyWith(isLoad: true));
    }else{
      emit(state.copyWith(isLoad: true,isResume: true));
    }




    
   
  }
  FutureOr<void> lvideo(LoadVideo event, Emitter<YoutubePlayerState> emit) async {
    controller.load(event.videoId);

  }

  FutureOr<void> pvideo(PlayVideo event, Emitter<YoutubePlayerState> emit) async {
      

    
    controller.play();

  }

  FutureOr<void> pauvideo(PauseVideo event, Emitter<YoutubePlayerState> emit) async {
      controller.pause();

  }

  FutureOr<void> changeSound(ChangSound event, Emitter<YoutubePlayerState> emit) async {
      //controller.pause();
      print('sonido actual----------------------------**********************: ${event.sound}');
    

     
      controller.setVolume(event.sound.toInt());
  
      emit(state.copyWith(esVolumen: true,volumen: event.sound));
  }
  FutureOr<void> cumplioVisto(UpdatePlayerEvent event, Emitter<YoutubePlayerState> emit) async {
    
      print("-------------------------"+((event.position/event.duration)*100>porcentajeVer).toString());
      var porcentajeVisto=(event.position/event.duration)*100;
      if(porcentajeVisto>=porcentajeVer){
        controller.removeListener(_listener);
        final user = await _firebaseAuthDataUser.getUsuario();

        
        if(_leccion.es_echoo || _leccion.es_visto){
          final progresado=await _firebaseAuthDataUser.datosLeccionProgresado(_leccion.id,user.id);
          await _firebaseAuthDataUser.modificarLeccionProgreso(true,progresado!.fue_echo,progresado.id);
        }else{
          await _firebaseAuthDataUser.crearLeccionProgresoVideo(true, _leccion.id_aptitud, _leccion.id_habilidad, _leccion.id, user.id);
          //crearLeccionProgreso
        }
        await _firebaseAuthDataUser.ingresarProgreso(aumento,user); ///AUMENTO ESTA AQUI S
        final res = Resume(correctas: 0, 
        incorrectas: 0, 
        puntajeCorrectas: aumento,
         puntajeIncorrectas: 0,
          numeroOrden: 0,
          tipo: 'video',
          indexTemporal: _leccion.indexTemporal
          );
        emit(state.copyWith(isResume: true,resume:res ));

      }
      //controller.removeListener(_listener);
  }


  @override
  YoutubePlayerState get initialState => YoutubePlayerState.empty();

  @override
  Future<void> close() {
    try {
      // Elimina el listener antes de desechar el controlador
      //controller.removeListener(_listener);
      //controller.dispose();
    } catch (e) {
      print('--------Error al eliminar el controlador: $e');
    }
    return super.close();
  }


  
}

