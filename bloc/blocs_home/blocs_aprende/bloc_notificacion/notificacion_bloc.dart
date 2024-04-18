




import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/usuario.dart';


import '../../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../../modelos/leccion.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class NotificacionBloc extends Bloc<NotificacionEvent, NotificacionState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  StreamSubscription? _subscriptionTodo1;
  late Usuario _user;
  NotificacionBloc() : super(NotificacionState.empty()) {

    on<BuscarNotificaciones>(loadNotifacaciones);
    on<UpdaNotificacionLeccion>(actualizarNotificacinesVista);
    on<CambiarTodos>(camTodos);
    on<CambiarNuevas>(camNuevas);


  }
FutureOr<void> camNuevas(CambiarNuevas event, Emitter<NotificacionState> emit) async {
    emit(state.copyWith(isTodo: false,isNueva: true));

  }
  FutureOr<void> camTodos(CambiarTodos event, Emitter<NotificacionState> emit) async {
    emit(state.copyWith(isTodo: true,isNueva: false));

  }
  FutureOr<void> actualizarNotificacinesVista(UpdaNotificacionLeccion event, Emitter<NotificacionState> emit) async {
    final listaProgreso=await _firebaseAuthDataUser.datosLeccionesProgresoEspecial(_user.id);
    List<Leccion> leccionesVer=[];
    List<Leccion> leccionesVerNuevas=[];
      event.lecciones.forEach((element) {
        leccionesVer.add(element);
      });
      
        listaProgreso.forEach((leccionProgreso) {
        leccionesVer.forEach((leccion) {
          if(leccionProgreso.id_leccion==leccion.id){
            leccion.es_echoo=leccionProgreso.fue_echo;
            leccion.es_visto=leccionProgreso.fue_visto;
       

            //leccion.es_pregunta=leccionProgreso.es_pregunta;
          }   

        });
      });
      leccionesVer.forEach((element){
        if(!element.es_echoo){
          leccionesVerNuevas.add(element);
        }
      });

      
    
    emit(state.copyWith(leccionesNuevas: leccionesVerNuevas,leccionesTodo:leccionesVer ,isLoad: true,isNueva: true));
  }
  FutureOr<void> loadNotifacaciones(BuscarNotificaciones event, Emitter<NotificacionState> emit) async {
    _cancelSubscription();
    _user = await _firebaseAuthDataUser.getUsuario();
    _subscriptionTodo1 = _firebaseAuthDataUser.datosRetosEjercicios(_user.id).listen((lecciones) {
      
      final leccionesOrdenadas = ordenarLecciones(lecciones);
      add(UpdaNotificacionLeccion(leccionesOrdenadas));
    });

  }

  
  List<Leccion> ordenarLecciones(List<Leccion> lecciones) {
  lecciones.sort(compararLecciones);
  return lecciones;
  }
  int compararLecciones(Leccion a, Leccion b) {
    return b.fecha_ingresada.compareTo(a.fecha_ingresada);
  }
  // Método para cancelar la suscripción
  void _cancelSubscription() {
    if (_subscriptionTodo1 != null) {
      _subscriptionTodo1!.cancel();
    }
  }
    @override
  Future<void> close() {
    // Asegurarse de cancelar la suscripción al cerrar el Bloc
    _cancelSubscription();
 
    return super.close();
  }


}
