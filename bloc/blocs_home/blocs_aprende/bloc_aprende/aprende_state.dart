import '../../../../modelos/aprende.dart';

class AprendeState {
  final bool isNewMessaging;
  final bool isCrearAprender;
  final bool isActualizarFC;
  final bool isActualizarAprender;
  final List<Aprende>? aprenderes;
  final Aprende? aprende; 

  AprendeState({
    required this.isNewMessaging,
    required this.isCrearAprender,
    required this.isActualizarFC,
    required this.isActualizarAprender,
    this.aprenderes,
    this.aprende, 
  });

  factory AprendeState.empty() {
    return AprendeState(
      isNewMessaging: false,
      isCrearAprender: false,
      isActualizarFC: false,
      isActualizarAprender: false,
      aprenderes: [],
      aprende: null, 
    );
  }

  AprendeState copyWith({
    bool? isNewMessaging,
    bool? isCrearAprender,
    bool? isActualizarFC,
    bool? isActualizarAprender,
    List<Aprende>? aprenderes,
    Aprende? aprende,
  }) {
    return AprendeState(
      isNewMessaging: isNewMessaging ?? this.isNewMessaging,
      isCrearAprender: isCrearAprender ?? this.isCrearAprender,
      isActualizarFC: isActualizarFC ?? this.isActualizarFC,
      isActualizarAprender: isActualizarAprender ?? this.isActualizarAprender,
      aprenderes: aprenderes ?? this.aprenderes,
      aprende: aprende ?? this.aprende,
    );
  }

  AprendeState update({
    bool? isNewMessaging,
    bool? isCrearAprender,
    bool? isActualizarFC,
    bool? isActualizarAprender,
    List<Aprende>? aprenderes,
    Aprende? aprende,
  }) {
    return copyWith(
      isNewMessaging: isNewMessaging,
      isCrearAprender: isCrearAprender,
      isActualizarFC: isActualizarFC,
      isActualizarAprender: isActualizarAprender,
      aprenderes: aprenderes,
      aprende: aprende,
    );
  }

  @override
  String toString() {
    return '''
      isNewMessaging: $isNewMessaging,
      isCrearAprender: $isCrearAprender,
      isActualizarFC: $isActualizarFC,
      isActualizarAprender: $isActualizarAprender,
      lista aprenderes: ${aprenderes?.length},
      aprende: $aprende,
    ''';
  }
}


