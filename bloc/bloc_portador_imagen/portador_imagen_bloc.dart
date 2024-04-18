




import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../firebase/aut_usuario/firebase_data_user.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class PortadorImagenBloc extends Bloc<PortadorImagenEvent, PortadorImagenState> {
  final FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  PortadorImagenBloc() : super(PortadorImagenState.empty()) {
 

    on<InicarPortadorImagen>(buscarImagenes);
 

  }

  FutureOr<void> buscarImagenes(InicarPortadorImagen event, Emitter<PortadorImagenState> emit) async {
 
     final lec=await _firebaseAuthDataUser.fotosPortador();
    emit(state.copyWith(
      isLoadAll: true
      ,fotosHistoria: lec['fotoHistoria']
      ,fotosEjercicio: lec['fotoEjercicio']
      ,fotosHabilidad: lec['fotoAprende'],
      fotosPaisaje: lec['fotoPaisaje'],
      fotosReto: lec['fotoReto']
      ),
      );

  }

}
