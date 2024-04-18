
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../modelos/leccion.dart';
abstract class YoutubePlayerEvent {}

class LoadVideo extends YoutubePlayerEvent {
  final String videoId;

  LoadVideo(this.videoId);
}

class PlayVideo extends YoutubePlayerEvent {}

class PauseVideo extends YoutubePlayerEvent {}
class ChangSound extends YoutubePlayerEvent {
  final double sound;
  ChangSound({
    required this.sound,

  });
}

class iniciarVideo extends YoutubePlayerEvent {
  final Leccion leccion;
  iniciarVideo({
    required this.leccion,


  });
}

class UpdatePlayerEvent extends YoutubePlayerEvent {
  final int position;
  final int duration;


  UpdatePlayerEvent({
    required this.position,
    required this.duration,

  });
}


