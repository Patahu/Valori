import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../firebase/aut_usuario/firebase_auth_servicio.dart';
import '../../../modelos/validators.dart';

import 'login_event.dart';
import 'login_state.dart';



class LoginBlocScreen extends Bloc<LoginEvent, LoginState> {
  FirebaseAuthService _firebaseAuthService =new FirebaseAuthService();
  LoginBlocScreen() : super(LoginState.empty()) {
    on<EmailChanged>(mapEmailChangedToState);
    on<PasswordChanged>(mapPasswordChangedToState);
    on<LoginWithCredentialsPressed>(authData);
  }
  FutureOr<void> mapEmailChangedToState(EmailChanged event, Emitter<LoginState> emit) async {
    print("_mapEmailChangedToState");
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  FutureOr<void> mapPasswordChangedToState(PasswordChanged event, Emitter<LoginState> emit) async{
    print("_mapPasswordChangedToState");
    emit(state.update(isPasswordValid: event.password.isNotEmpty));
  }

  FutureOr<void> authData(LoginWithCredentialsPressed event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    try {
      final isSignedIn = await _firebaseAuthService.signInWithEmailAndPassword(event.email,event.password);
      if (isSignedIn != null) {
        emit(LoginState.success(idUsuario:isSignedIn.uid));
      } else {
     
        emit(LoginState.failure());
      }
    } catch (_) {
      print("Ocurrio un error en el bloc authData Login Bloc");
    }
  }

}