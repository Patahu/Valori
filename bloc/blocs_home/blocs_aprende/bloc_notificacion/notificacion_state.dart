
import '../../../../modelos/leccion.dart';

class NotificacionState  {
  final bool isLoad;
  final bool isNueva;  
  final bool isTodo;
  final List<Leccion> leccionesNuevas;
  final List<Leccion> leccionesTodo;


  NotificacionState({
    required this.isLoad,
    required this.isNueva,
    required this.isTodo,
    required this.leccionesNuevas,
    required this.leccionesTodo,

  });

  NotificacionState copyWith({
    bool? isLoad,
    bool? isNueva,
    bool? isTodo,
    List<Leccion>? leccionesNuevas,
    List<Leccion>? leccionesTodo,

  }) {
    return NotificacionState(
      isLoad: isLoad ?? this.isLoad,
      isNueva: isNueva ?? this.isNueva,
      isTodo: isTodo ?? this.isTodo,
      leccionesNuevas: leccionesNuevas ?? this.leccionesNuevas,
      leccionesTodo: leccionesTodo ?? this.leccionesTodo,

    );
  }

  static NotificacionState empty() {
    return NotificacionState(
      isLoad: false,
      isNueva:false,
      isTodo: false,
      leccionesNuevas: [],
      leccionesTodo:[],

    );
  }



  @override
  String toString() {
    return '''VisorState(
      isLoad: $isLoad,
       leccionesNuevas: $leccionesNuevas,
       leccionesTodo: $leccionesTodo,
         ''';
  }

  @override
  List<Object?> get props => [isLoad, leccionesNuevas,leccionesTodo,isTodo,isNueva]; // Incluir el nuevo atributo en la lista de props
}