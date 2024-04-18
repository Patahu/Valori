


import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../../modelos/aprende.dart';
import '../../../../modelos/habilidad.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabilidadBloc extends Bloc<HabilidadEvent, HabilidadState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  StreamSubscription? _subscriptionTodo1;
  String _imagen='https://firebasestorage.googleapis.com/v0/b/valorixdb.appspot.com/o/ejercicio_imagen%2FfotoAprende%2F0f729c58dac76c7b52150a79ae5de2f7.png?alt=media&token=7491701b-8048-452c-9339-2c6212c8b863';
  HabilidadBloc() : super(HabilidadState.empty()) {
    on<BuscarHabilidad>(busHabilidad);
    on<UpdaHabilidad>(updaLista);

    on<IngresarHabilidad>(ingresarHabilidad);

    on<ModificarHabilidad>(modificarHabilidad);
    on<ElimnarHabilidad>(eliminarHabilidad);
    on<ActualizarHabilidad>(actualizarHabilidad);
    on<BuscarHabilidadGlobal>(busHabilidadGlobal);
    on<IngresarImageHabilidad>(asignarImagen);
    on<CrearHabilidad>(comenzarCrearHabilidad);
  }

  FutureOr<void> comenzarCrearHabilidad(CrearHabilidad event, Emitter<HabilidadState> emit) async {

    emit(state.update(isActualizarHabilidad:false,isSuccess: false,isFail: false ));
  }
  FutureOr<void> asignarImagen(IngresarImageHabilidad event, Emitter<HabilidadState> emit) async {
      print("SE AH ASIGNADO UNA IMAGENNNNNNNNNNNNNNN");
      _imagen=event.url;
    final habil=Habilidad.copyFromIm(state.habilidad!,_imagen);
    emit(state.update(habilidad: habil));
  }
  FutureOr<void> eliminarHabilidad(ElimnarHabilidad event, Emitter<HabilidadState> emit) async {
   
    _firebaseAuthDataUser.eliminarHabilidad(event.id);

    //emit(state.update(isNewMessaging: true, habilidades: event.habilidades));
  }

  FutureOr<void> actualizarHabilidad(ActualizarHabilidad event, Emitter<HabilidadState> emit) async {
   
    _firebaseAuthDataUser.actualizarHabilidadDb(event.nombre,event.imagen,state.habilidad!.id);
    print("IDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD "+event.id);
    emit(state.activateSuccess());
    //emit(state.update(isCrearHabilidad: false,isActualizarFC: false,isActualizarHabilidad: false));
    //emit(state.update(isNewMessaging: true, habilidades: event.habilidades));
  }
  FutureOr<void> modificarHabilidad(ModificarHabilidad event, Emitter<HabilidadState> emit) async {
    
    final us=Habilidad.copyFrom(event.habilidad);
    emit(state.update(isActualizarHabilidad: true,habilidad: us));
  }

  FutureOr<void> ingresarHabilidad(IngresarHabilidad event, Emitter<HabilidadState> emit) async {
    
    print("AQUI-------------------------------");
    _firebaseAuthDataUser.crearHabilidadDb(event.id_aptitud,Timestamp.now(),_imagen,event.nombre);
    emit(state.activateSuccess());
    //emit(state.update(isCrearHabilidad: false,isActualizarFC: false,isActualizarHabilidad: false));
    //emit(state.update(isNewMessaging: true, habilidades: event.habilidades));
  }

  FutureOr<void> busHabilidad(BuscarHabilidad event, Emitter<HabilidadState> emit) async {
    // Cancelar la suscripción existente antes de establecer una nueva
    _cancelSubscription();

    _subscriptionTodo1 = _firebaseAuthDataUser.datosHabilidades(event.idDocumento).listen((habilidades) {
      final listaHabilidad=ordenarLecciones(habilidades);;
      add(UpdaHabilidad(listaHabilidad));
    });
  }
  List<Habilidad> ordenarLecciones(List<Habilidad> habilidades) {
  habilidades.sort(compararLecciones);
  return habilidades;
  }
  int compararLecciones(Habilidad a, Habilidad b) {
    return a.fecha_ingreso.compareTo(b.fecha_ingreso);
  }
  FutureOr<void> busHabilidadGlobal(BuscarHabilidadGlobal event, Emitter<HabilidadState> emit) async {
    // Cancelar la suscripción existente antes de establecer una nueva
    _cancelSubscription();

    _subscriptionTodo1 = _firebaseAuthDataUser.datosHabilidadesGlobales().listen((habilidades) {
      add(UpdaHabilidad(habilidades));
    });
  }
  FutureOr<void> updaLista(UpdaHabilidad event, Emitter<HabilidadState> emit) async {
    emit(state.update(isLoadHabilidad: true, habilidades: event.habilidades,isFail: false,isSuccess: false));
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
