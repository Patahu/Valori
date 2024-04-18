import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';


import '../../../../modelos/resultado.dart';

import 'bloc.dart';

class LeccionProgresoHabilidadBloc extends Bloc<LeccionProgresoHabilidadEvent, LeccionProgresoHabilidadState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();



  LeccionProgresoHabilidadBloc() : super(LeccionProgresoHabilidadState.empty()) {
    on<iniciarVistaHabilidadProgreso>(busLeccionProgreso);
    on<BuscarHabilidadProgresoGlobal>(busLeccionGlobales);

   

  }
  FutureOr<void> busLeccionGlobales(BuscarHabilidadProgresoGlobal event, Emitter<LeccionProgresoHabilidadState> emit) async {
      print('------------------------------------------INICIAMOS');
      emit(state.copyWith(esCargado: false,esCargando: true));
    final user = await _firebaseAuthDataUser.getUsuario();
    final resultados = await _firebaseAuthDataUser.obtenerCantidadInterseccionHabilidadGlobal(user.id);

    resultados.forEach((res) {
      print('------------------------------------------ID de Aptitud: ${res.idResultado}, inter: ${res.enProgreso}, total: ${res.total}');
    });
    var dic = <String, Resultado>{};
    for (var res in resultados) {
      dic[res.idResultado] = res;
    }

    emit(state.copyWith(resultados:dic,esCargado: true,esCargando: false));


  }
  FutureOr<void> busLeccionProgreso(iniciarVistaHabilidadProgreso event, Emitter<LeccionProgresoHabilidadState> emit) async {

    final user = await _firebaseAuthDataUser.getUsuario();
    final resultados = await _firebaseAuthDataUser.obtenerCantidadInterseccionHabilidad(user.id,event.idAprende);
    var dic = <String, Resultado>{};
    for (var res in resultados) {
      dic[res.idResultado] = res;
    }

    emit(state.copyWith(resultados:dic,esCargado: true,esCargando: false));


  }




  



}
