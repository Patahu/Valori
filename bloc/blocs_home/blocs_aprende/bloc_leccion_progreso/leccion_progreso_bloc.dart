import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/leccion_progreso.dart';
import '../../../../firebase/aut_usuario/firebase_data_user.dart';

import '../../../../modelos/leccion.dart';
import '../../../../modelos/resultado.dart';
import '../../../../modelos/usuario.dart';
import 'bloc.dart';

class LeccionProgresoBloc extends Bloc<LeccionProgresoEvent, LeccionProgresoState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();



  LeccionProgresoBloc() : super(LeccionProgresoState.empty()) {
    on<iniciarVistaProgreso>(busLeccionProgreso);

   

  }

  FutureOr<void> busLeccionProgreso(iniciarVistaProgreso event, Emitter<LeccionProgresoState> emit) async {

    final user = await _firebaseAuthDataUser.getUsuario();
    final resultados = await _firebaseAuthDataUser.obtenerCantidadInterseccion(user.id);


    var dic = <String, Resultado>{};
    for (var res in resultados) {
      dic[res.idResultado] = res;
    }

    emit(state.copyWith(resultados:dic,esCargado: true,esCargando: false));


  }




  



}
