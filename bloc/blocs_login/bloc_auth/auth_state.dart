

import '../../../modelos/usuario.dart';

abstract class AuthState {}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState{
  final Usuario usuario;
  Authenticated({required this.usuario});
}

class unauthenticated extends AuthState {
  @override
  String toString() => 'No autenticado';
}

class initialUsuario extends AuthState {

  final Usuario usuario;
  initialUsuario(this.usuario);
}
