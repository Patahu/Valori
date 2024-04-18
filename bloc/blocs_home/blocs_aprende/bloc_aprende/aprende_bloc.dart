

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../../modelos/aprende.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class AprendeBloc extends Bloc<AprendeEvent, AprendeState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  StreamSubscription? _subscriptionTodo1;

  AprendeBloc() : super(AprendeState.empty()) {
    on<BuscarAprende>(busAprende);
    on<UpdaAprende>(updaLista);
    on<CrearAprende>(crearAprende);
    on<VolverAprende>(volverAprende);
    on<IngresarAprende>(ingreAprender);
    on<ActualizarCFAprende>(updaFC);
    on<ModificarAprende>(modificarAprende);
    on<ElimnarAprende>(eliminarAprender);
    on<ActualizarAprende>(updateAprender);
  }

  FutureOr<void> eliminarAprender(ElimnarAprende event, Emitter<AprendeState> emit) async {
   
    _firebaseAuthDataUser.eliminarAprende(event.id);

    //emit(state.update(isNewMessaging: true, aprenderes: event.aprenderes));
  }

  FutureOr<void> updateAprender(ActualizarAprende event, Emitter<AprendeState> emit) async {
   
    _firebaseAuthDataUser.actualizarAprendeDb(event.nombre,event.numero,event.imagen,event.id);
    emit(state.update(isCrearAprender: false,isActualizarFC: false,isActualizarAprender: false));
    //emit(state.update(isNewMessaging: true, aprenderes: event.aprenderes));
  }
  FutureOr<void> modificarAprende(ModificarAprende event, Emitter<AprendeState> emit) async {
    
    final us=Aprende(id:event.aprende.id,nombre: event.aprende.nombre,color: event.aprende.color,imagen: event.aprende.imagen);
    emit(state.update(isActualizarAprender: true,aprende: us));
  }
  FutureOr<void> updaFC(ActualizarCFAprende event, Emitter<AprendeState> emit) async {
    emit(state.update(isActualizarFC: true));
  }
  FutureOr<void> ingreAprender(IngresarAprende event, Emitter<AprendeState> emit) async {
    _firebaseAuthDataUser.crearAprendeDb(event.numero,Timestamp.now(),event.imagen,event.nombre);
    emit(state.update(isCrearAprender: false,isActualizarFC: false,isActualizarAprender: false));
    //emit(state.update(isNewMessaging: true, aprenderes: event.aprenderes));
  }

  FutureOr<void> busAprende(BuscarAprende event, Emitter<AprendeState> emit) async {
    // Cancelar la suscripción existente antes de establecer una nueva
    _cancelSubscription();

    _subscriptionTodo1 = _firebaseAuthDataUser.datosAprende().listen((aprenderes) {
      add(UpdaAprende(aprenderes));
    });
  }

  FutureOr<void> updaLista(UpdaAprende event, Emitter<AprendeState> emit) async {
    emit(state.update(isNewMessaging: true, aprenderes: event.aprenderes));
  }


  FutureOr<void> crearAprende(CrearAprende event, Emitter<AprendeState> emit) async {

    emit(state.update(isCrearAprender: true));
  }
  FutureOr<void> volverAprende(VolverAprende event, Emitter<AprendeState> emit) async {

    emit(state.update(isCrearAprender: false,isActualizarFC: false,isActualizarAprender: false));
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
