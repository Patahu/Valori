


import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase/aut_usuario/firebase_data_user.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class RankingBloc extends Bloc<RankingEvent, RankingState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  StreamSubscription? _subscriptionTodo1;
  StreamSubscription? _subscriptionTodo2;

  RankingBloc() : super(RankingState.empty()) {
    on<initRanking>(buscarRanking);
    on<UpdateRanking>(updateLista);
    on<initAmigos>(buscarAmigos);
    on<UpdateAmigos>(updateListaAmigos);
  }
  FutureOr<void> buscarAmigos(initAmigos event, Emitter<RankingState> emit) async {
       // Cancelar la suscripción existente antes de establecer una nueva
    _cancelSubscription();

    _subscriptionTodo2 = _firebaseAuthDataUser.datosPerfilAmiogos().listen((usuarios) {
      add(UpdateAmigos(usuarios));
    });

    //emit(state.update(isNewMessaging: true, aprenderes: event.aprenderes));
  }

  
  FutureOr<void> updateListaAmigos(UpdateAmigos event, Emitter<RankingState> emit) async {
    emit(state.update(isLoad: true, listaUsuariosAmigos: event.usuarios));
  }

  FutureOr<void> buscarRanking(initRanking event, Emitter<RankingState> emit) async {
       // Cancelar la suscripción existente antes de establecer una nueva
    _cancelSubscription();

    _subscriptionTodo1 = _firebaseAuthDataUser.datosRanking().listen((usuarios) {
      add(UpdateRanking(usuarios));
    });

    //emit(state.update(isNewMessaging: true, aprenderes: event.aprenderes));
  }



  FutureOr<void> updateLista(UpdateRanking event, Emitter<RankingState> emit) async {
    emit(state.update(isLoad: true, listaUsuariosRanking: event.usuarios));
  }

  // Método para cancelar la suscripción
  void _cancelSubscription() {
    if (_subscriptionTodo1 != null) {
      _subscriptionTodo1!.cancel();
    }
  if (_subscriptionTodo2 != null) {
      _subscriptionTodo2!.cancel();
    }
  }

  @override
  Future<void> close() {
    // Asegurarse de cancelar la suscripción al cerrar el Bloc
    _cancelSubscription();
    return super.close();
  }
}
