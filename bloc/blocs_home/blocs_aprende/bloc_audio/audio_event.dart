abstract class AudioPlayerEvent {}

class LoadAudio extends AudioPlayerEvent {
  final String videoId;

  LoadAudio(this.videoId);
}

class PlayAudio extends AudioPlayerEvent {}

class PauseAudio extends AudioPlayerEvent {}

class IniciarAudio extends AudioPlayerEvent {
  final String urlAudio;
  IniciarAudio({
    required this.urlAudio,


  });
}