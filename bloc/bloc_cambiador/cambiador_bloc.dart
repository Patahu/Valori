
import 'package:flutter/material.dart';
import 'package:valorix/src/modelos/habilidad.dart';

import '../../modelos/aprende.dart';
import '../../modelos/leccion.dart';
import '../../modelos/resume.dart';
import 'bloc.dart';


import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';


// bloc que cambia las imagenes una vez ingresado

class CambiadorBloc extends Bloc<CambiadorEvent, CambiadorState> {
  late Habilidad _habilidad;
  late Aprende _aprende;
  late Leccion _leccion;
  List<Resume> _resumenes=[];
  CambiadorBloc() : super(CambiadorState.empty()) {
    on<cambiarToCardHabilidad>(cambiarCardAprende);
    on<cambiarToCardLeccion>(cambiarCardHabilidad);
    on<backHome>(backHom);
    on<backHabilidades>(backdHabilidad);
    on<cambiarToCardVideo>(cambiarCardVideo);
    on<backLecciones>(backdLeccion);
    on<cambiarToRanking>(cambiarCardRanking);
    on<cambiarToPerfil>(cambiarCardPerfil);
    on<cambiarToInicio>(cambiarCardInicio);
    on<cambiarToEjercicio>(cambiarCardEjercicio);
    on<backToCardVideo>(backVideo);
    on<cambiarToCardLeccionGlobal>(cambiarCardHabilidadGlobal);
    on<backLeccionesGlobal>(backLeccionGlobal);
    on<cambiarToNotificacion>(cambiarCardNotificacion);
    on<cambiarToResumen>(cambiarCardResumen);
    on<agregarResumen>(agregarResum);
    on<cambiarToEjercicioEspecial>(cambiarCardEjercicioEsp);
    on<cambiartToReporte>(cambiarToReporteValor);
  }
  FutureOr<void> agregarResum(
      agregarResumen event, Emitter<CambiadorState> emit) {
    print('+---------agregarResum---------------------------------------------------------------***'+event.resume.toString());
    if(event.resume.tipo=='video'){
      _leccion.es_visto=true;
    }else if(event.resume.tipo=='ejercicio'){
      _leccion.es_echoo=true;
    }
    
    _resumenes.add(event.resume);

  }
  FutureOr<void> cambiarCardResumen(
      cambiarToResumen event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardResumen');
    print(_resumenes.isNotEmpty);
    if(_resumenes.isNotEmpty){
      emit(state.activateResume(resumen: _resumenes));
    }
    
  }
  FutureOr<void> cambiarCardNotificacion(
      cambiarToNotificacion event, Emitter<CambiadorState> emit) {
    print('+---------cambiarToNotificacion');
    _resumenes=[];
    emit(state.activateNotificacion(Habilidad.empty()));
  }
  FutureOr<void> backLeccionGlobal(
      backLeccionesGlobal event, Emitter<CambiadorState> emit) {
    print('+---------backLeccionGlobal');
    _resumenes=[];
    emit(state.activateLeccionGlobal(es_leccion_global:true,habilidad: _habilidad));
  }
    FutureOr<void> cambiarCardHabilidadGlobal(
      cambiarToCardLeccionGlobal event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardHabilidad');
    _habilidad=event.habilidad;
      _resumenes=[];
    emit(state.activateLeccionGlobal(es_leccion_global:true,habilidad: _habilidad));
  }
  FutureOr<void> backVideo(
      backToCardVideo event, Emitter<CambiadorState> emit) {
    print('+---------backVideo');
    emit(state.activateVideo());
    
  }
  FutureOr<void> cambiarCardEjercicio(
      cambiarToEjercicio event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardEjercicio');
    _leccion=event.leccion;
    emit(state.activateEjercicio(leccion: _leccion));
    
  }

  FutureOr<void> cambiarCardEjercicioEsp(
      cambiarToEjercicioEspecial event, Emitter<CambiadorState> emit) {
    print('+-----------------------------------------------------------cambiarCardEjercicio');
    _leccion=event.leccion;
  
    emit(state.activateEjercicio(leccion: _leccion));
    
  }
  FutureOr<void> cambiarCardInicio(
      cambiarToInicio event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardInicio');
    emit(state.activateHome());
    
  }
  FutureOr<void> cambiarCardPerfil(
      cambiarToPerfil event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardPerfil');
    emit(state.activatePerfil());
  }
  FutureOr<void> cambiarCardRanking(
      cambiarToRanking event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardRanking');
    emit(state.activateRanking());
  }
  FutureOr<void> backdLeccion(
      backLecciones event, Emitter<CambiadorState> emit) {
    print('+---------backdLeccion');
      _resumenes=[];
    emit(state.activateLeccion(habilidad: _habilidad));
  }


  FutureOr<void> cambiarToReporteValor(
      cambiartToReporte event, Emitter<CambiadorState> emit) {
    print('+---------cambiarToReporteValor');
    emit(state.activateReporteValor(tipoReporte: event.tipo));
  }


  FutureOr<void> backdHabilidad(
      backHabilidades event, Emitter<CambiadorState> emit) {
    print('+---------backdHabilidad');
    emit(state.activateHabilidad(aprende: _aprende));
  }

  FutureOr<void> cambiarCardHabilidad(
      cambiarToCardLeccion event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardHabilidad');
    _habilidad=event.habilidad;
    _resumenes=[];
    emit(state.activateLeccion(habilidad:event.habilidad));
  }
  FutureOr<void> cambiarCardAprende(
      cambiarToCardHabilidad event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardAprende');
    _aprende=event.aprende;
    emit(state.activateHabilidad(aprende: event.aprende));
  }


  FutureOr<void> backHom(
      backHome event, Emitter<CambiadorState> emit) {
    print('+---------backHom');
    emit(state.activateHome());
  }

  FutureOr<void> cambiarCardVideo(
      cambiarToCardVideo event, Emitter<CambiadorState> emit) {
    print('+---------cambiarCardVideo');
    _leccion=event.leccion;
    emit(state.activateVideo(leccion: _leccion));
  }

}
