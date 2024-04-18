import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/leccion_progreso.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';

import 'bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AudioBloc extends Bloc<AudioPlayerEvent, AudioState> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  AudioPlayer _audioPlayer = AudioPlayer();
  AudioBloc() :super(AudioState.empty()) {
    on<IniciarAudio>(escucharElAudio);

  }

 

  FutureOr<void> escucharElAudio(IniciarAudio event, Emitter<AudioState> emit) async {
        try {
          // Get a reference to the audio file in Firebase Storage
          final reference = _storage.refFromURL(event.urlAudio);

          // Get a downloadable URL for the audio file
          final downloadUrl = await reference.getDownloadURL();

          // Play the audio using the downloadable URL
          await _audioPlayer.play(UrlSource(downloadUrl));
          emit(AudioState.playing()); // Update state to indicate playing
        } catch (error) {
          print('Error playing audio: $error');
          emit(AudioState.errorAudio(error.toString())); // Update state with error
        }

  }

  @override
  Future<void> close() async {
    try {
      await _audioPlayer.stop(); // Stop audio playback before closing
    } catch (error) {
      print('Error stopping audio player: $error');
    }
    await super.close();
  }


  
}

