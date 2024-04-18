




import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class VisorBloc extends Bloc<VisorEvent, VisorState> {

  VisorBloc() : super(VisorState.empty()) {
 
    on<VisorHome>(verHome);
    on<VisorRanking>(verRanking);
    on<VisorPerfil>(verPerfil);
    on<VisorNinguno>(verNiguno);

  }
  FutureOr<void> verNiguno(VisorNinguno event, Emitter<VisorState> emit) async {
    emit(state.activaNone());
  }

  FutureOr<void> verHome(VisorHome event, Emitter<VisorState> emit) async {
    emit(state.activaHome());
  }
  FutureOr<void> verRanking(VisorRanking event, Emitter<VisorState> emit) async {
    emit(state.activaRanking());
  }
  FutureOr<void> verPerfil(VisorPerfil event, Emitter<VisorState> emit) async {
    emit(state.activaPerfil());
  }
}
