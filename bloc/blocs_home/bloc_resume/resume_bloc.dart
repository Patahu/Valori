




import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  late List<Resume> _listaRes;
  int _contador=0;
  ResumeBloc() : super(ResumeState.empty()) {
    on<initResume>(iniciarResum);
    on<continuarResume>(contin);
    on<videoResume>(resumeVideo);
    on<rollResume>(roll);
    on<ejercicioResume>(resumeEjercicio);

  }
  FutureOr<void> contin(continuarResume event, Emitter<ResumeState> emit) async {
    final user=await _firebaseAuthDataUser.getUsuario();
    final listaUsuario= await _firebaseAuthDataUser.datosRankingFoto();
    int contador=1;
    Usuario buscado=Usuario.empty;
    
    listaUsuario.forEach((value){
      if(user.id==value.id){
        buscado=value;
        buscado.puesto=contador;
      }
      contador++;

    });
    emit(state.copyWith(isResumeRanking: true,isLoad: false,usuario: buscado,isVideoResume:false));
  }
  FutureOr<void> iniciarResum(initResume event, Emitter<ResumeState> emit) async {
    _listaRes=event.resumenes;
    _contador=0;
    add(rollResume());
  }


  FutureOr<void> roll(rollResume event, Emitter<ResumeState> emit) async {
      print("ROLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL*--*-*----------- "+_listaRes.length.toString()+":"+_contador.toString());
      if(_listaRes.length>_contador){
        
        final red=_listaRes[_contador];

        if(red.tipo=='ejercicio'){
          add(ejercicioResume(red));

        }else if(red.tipo=='video'){
          add(videoResume(red));
        }
        _contador++;
      }else{
        print("GGGGGGGGGGGG");
        add(continuarResume());
      }
  }
  FutureOr<void> resumeVideo(videoResume event, Emitter<ResumeState> emit) async {
    emit(state.copyWith(isResumeRanking: false,isLoad: false,isVideoResume: true,resumen: event.resumen));
  }

    FutureOr<void> resumeEjercicio(ejercicioResume event, Emitter<ResumeState> emit) async {
    emit(state.copyWith(isResumeRanking: false,isLoad: true,isVideoResume: false,resumen: event.resumen));
  }





}
