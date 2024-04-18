

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TiempoBloc extends Bloc<TiempoEvent, TiempoState> {
  final Stopwatch _stopwatch = Stopwatch();
  StreamSubscription? _subscription;

  TiempoBloc() : super(TiempoState.empty()) {
    on<StartTimer>(_onStartTimer);
    on<StopTimer>(_onStopTimer);
    on<updateTimer>(_updateTimer);
  }

  FutureOr<void> _onStartTimer(StartTimer event, Emitter<TiempoState> emit)  async {
    _stopwatch.start();
    _subscription ??= Stream.periodic(const Duration(seconds: 1), (_) {
      final elapsedTime = _stopwatch.elapsedMilliseconds;
      final segundosTotales = (elapsedTime / 1000).floor();
      final minutos = (segundosTotales / 60).floor();
      final segundos = segundosTotales % 60;
      final segundosConCero = segundos < 10 ? '0$segundos' : '$segundos';
      final minutosConCero = minutos < 10 ? '0$minutos' : '$minutos';
      final tiempo='$minutosConCero:$segundosConCero';
      return tiempo;
      //return state.copyWith(tiempoCronometro: elapsedTime.toString());
    }).listen((tiempo){
      add(updateTimer(tiempo));

    });
    //emit(state.copyWith(isCronometroActivo: true));
  }
  FutureOr<void> _updateTimer(updateTimer event, Emitter<TiempoState> emit) async {
    emit(state.copyWith(isCronometroActivo: true,tiempoCronometro: event.tiempo));
  }
  FutureOr<void> _onStopTimer(StopTimer event, Emitter<TiempoState> emit) async {
    _stopwatch.stop();
    _subscription?.cancel();
    _subscription = null;
    emit(state.copyWith(isCronometroActivo: false));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}