
import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../firebase/aut_usuario/firebase_auth_servicio.dart';
import '../../../modelos/usuario.dart';
import 'bloc.dart';






class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirbaseAuthDataUser _firebaseAuthDataUser =new FirbaseAuthDataUser();
  final FirebaseAuthService _firebaseAuthService =new FirebaseAuthService();
  StreamSubscription? _subscriptionUser=null;
  AuthBloc() : super(Uninitialized()) {
    on<enterIdUser>(authData);
    on<enterUsuario>(getDataUser);
    on<AppStarted>(appStartedToState);
    on<LoggedOut>(mapLoggedOutToState);
  }
  FutureOr<void> authData(enterIdUser event, Emitter<AuthState> emit) async {
    print('authData');

   if (_subscriptionUser != null) {
      _subscriptionUser!.cancel();
    }

    _subscriptionUser = _firebaseAuthDataUser.datosUsuario(event.idUser).listen((usuarioEncontrado) {
      add(enterUsuario(usuarioEncontrado));
      // Aquí puedes realizar las operaciones necesarias con los datos del pedido específico
    });
  }

  FutureOr<void> getDataUser(
      enterUsuario event, Emitter<AuthState> emit) {
    print('++++++++++getDataUser');
    emit(Authenticated(usuario:event.usuario));
  }


  FutureOr<void> appStartedToState(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final isSignedIn = await _firebaseAuthService.isSignedIn();
      if (isSignedIn) {
        final user = await _firebaseAuthDataUser.getUsuario();
        add(enterIdUser(idUser: user.id));
        emit(Authenticated(usuario:user));
      } else {
        emit(unauthenticated());
      }
    } catch (_) {
      emit(unauthenticated());
    }
  }

  FutureOr<void> mapLoggedOutToState(LoggedOut event, Emitter<AuthState> emit) async {
    emit(unauthenticated());
    _firebaseAuthService.signOut();
  }

}
