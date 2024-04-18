

import 'package:youtube_player_flutter/youtube_player_flutter.dart';


import '../../../../modelos/resume.dart';
// Importa la clase Resume si aún no lo has hecho

class YoutubePlayerState {
  final PlayerState playerState;
  final YoutubeMetaData videoMetaData;
  final bool isPlayerReady;
  final bool isMuted;
  final bool esVolumen;
  final double volumen;
  final bool isLoad;
  final Resume resume; // Nuevo atributo
  final bool isResume; // Nuevo atributo

  YoutubePlayerState({
    required this.playerState,
    required this.videoMetaData,
    required this.isPlayerReady,
    required this.isMuted,
    required this.esVolumen,
    required this.volumen,
    required this.isLoad,
    required this.resume, // Agregar el nuevo atributo
    required this.isResume, // Agregar el nuevo atributo
  });

  factory YoutubePlayerState.empty() {
    return YoutubePlayerState(
      playerState: PlayerState.unknown,
      videoMetaData: YoutubeMetaData(),
      isPlayerReady: false,
      isMuted: false,
      esVolumen: true,
      volumen: 50.0,
      isLoad: false,
      resume: Resume.empty(), // Valor por defecto para el nuevo atributo
      isResume: false, // Valor por defecto para el nuevo atributo
    );
  }

  YoutubePlayerState copyWith({
    PlayerState? playerState,
    YoutubeMetaData? videoMetaData,
    bool? isPlayerReady,
    bool? isMuted,
    bool? esVolumen,
    double? volumen,
    bool? isLoad,
    Resume? resume, // Agregar el nuevo atributo
    bool? isResume, // Agregar el nuevo atributo
  }) {
    return YoutubePlayerState(
      playerState: playerState ?? this.playerState,
      videoMetaData: videoMetaData ?? this.videoMetaData,
      isPlayerReady: isPlayerReady ?? this.isPlayerReady,
      isMuted: isMuted ?? this.isMuted,
      esVolumen: esVolumen ?? this.esVolumen,
      volumen: volumen ?? this.volumen,
      isLoad: isLoad ?? this.isLoad,
      resume: resume ?? this.resume, // Agregar el nuevo atributo
      isResume: isResume ?? this.isResume, // Agregar el nuevo atributo
    );
  }
}