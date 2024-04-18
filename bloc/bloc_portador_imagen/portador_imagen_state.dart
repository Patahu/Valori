
import 'package:equatable/equatable.dart';
class PortadorImagenState extends Equatable {
  final bool isLoadAll;
  final List<String> fotosHabilidad;
  final List<String> fotosHistoria;
  final List<String> fotosEjercicio;
  final List<String> fotosPaisaje; // Nuevo atributo
  final List<String> fotosReto;

  PortadorImagenState({
    required this.isLoadAll,
    required this.fotosHabilidad,
    required this.fotosHistoria,
    required this.fotosEjercicio,
    required this.fotosReto,
    required this.fotosPaisaje, // Incluir el nuevo atributo en el constructor
  });

  PortadorImagenState copyWith({
    bool? isLoadAll,
    List<String>? fotosHabilidad,
    List<String>? fotosHistoria,
    List<String>? fotosEjercicio,
    List<String>? fotosReto,
    List<String>? fotosPaisaje, // Permitir la modificación del nuevo atributo
  }) {
    return PortadorImagenState(
      isLoadAll: isLoadAll ?? this.isLoadAll,
      fotosHabilidad: fotosHabilidad ?? this.fotosHabilidad,
      fotosHistoria: fotosHistoria ?? this.fotosHistoria,
      fotosEjercicio: fotosEjercicio ?? this.fotosEjercicio,
      fotosReto: fotosReto ?? this.fotosReto,
      fotosPaisaje: fotosPaisaje ?? this.fotosPaisaje, // Incluir el nuevo atributo en la copia
    );
  }

  static PortadorImagenState empty() {
    return PortadorImagenState(
      isLoadAll: false,
      fotosHabilidad: [],
      fotosHistoria: [],
      fotosEjercicio: [],
      fotosReto: [],
      fotosPaisaje: [], // Asegurarse de incluir el nuevo atributo aquí
    );
  }



  @override
  String toString() {
    return 'VisorState(isLoadAll: $isLoadAll, fotosHabilidad: ${fotosHabilidad.length}, fotosHistoria: ${fotosHistoria.length}, fotosEjercicio: ${fotosEjercicio.length}, fotosPaisaje: ${fotosPaisaje.length})';
  }

  @override
  List<Object?> get props => [fotosReto,isLoadAll, fotosHabilidad, fotosHistoria, fotosEjercicio, fotosPaisaje]; // Incluir el nuevo atributo en la lista de props
}
