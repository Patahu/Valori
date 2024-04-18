


import '../../../modelos/usuario.dart';

abstract class AuthEvent {}

class AuthInitial extends AuthEvent {}

// Evento para verificar si el email y password
class enterIdUser extends AuthEvent{
  final String idUser;
  enterIdUser({
    required this.idUser,
  });
}

class LoggedIn extends AuthEvent{

}



class enterUsuario extends AuthEvent{
  final Usuario usuario;

  enterUsuario(this.usuario);
}
class LoggedOut extends AuthEvent{}

class AppStarted extends AuthEvent{}