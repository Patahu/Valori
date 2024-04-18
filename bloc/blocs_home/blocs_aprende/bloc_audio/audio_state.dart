class AudioState {
  final bool isPlaying;
  final String? error;

  AudioState({
    this.isPlaying = false,
    this.error,
  });

  // Función para actualizar el estado a "reproduciendo"
  factory AudioState.playing() {
    return AudioState(
      isPlaying: true,
      error: null,
    );
  }
  factory AudioState.empty()  {
    return AudioState();
  }

  // Función para actualizar el estado a "pausado"
  factory AudioState.paused() {
    return AudioState(
      isPlaying: false,
      error: null,
    );
  }

  // Función para actualizar el estado con un error
  factory AudioState.errorAudio(String error) {
    return AudioState(
      isPlaying: false,
      error: error,
    );
  }
}
