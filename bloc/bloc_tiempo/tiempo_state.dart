

class TiempoState {
  final bool isCronometroActivo;
  final String tiempoCronometro;

  TiempoState({
    required this.isCronometroActivo,
    required this.tiempoCronometro,
  });

  TiempoState copyWith({
    bool? isCronometroActivo,
    String? tiempoCronometro,
  }) {
    return TiempoState(
      isCronometroActivo: isCronometroActivo ?? this.isCronometroActivo,
      tiempoCronometro: tiempoCronometro ?? this.tiempoCronometro,
    );
  }
  factory TiempoState.empty() {
    return TiempoState(
      isCronometroActivo: false,
      tiempoCronometro: "00:00",
    );
  }
  TiempoState update({
    bool? isCronometroActivo,
    String? tiempoCronometro,
  }) {
    return copyWith(
      isCronometroActivo: isCronometroActivo,
      tiempoCronometro: tiempoCronometro,
    );
  }
}
