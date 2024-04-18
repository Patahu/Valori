import '../../../modelos/usuario.dart';

abstract class RankingEvent {}


class initRanking extends RankingEvent{
}


class UpdateRanking extends RankingEvent{
  final List<Usuario> usuarios;
  UpdateRanking(this.usuarios);
  @override
  List<Object> get props => [usuarios];
}


class initAmigos extends RankingEvent{
}


class UpdateAmigos extends RankingEvent{
  final List<Usuario> usuarios;
  UpdateAmigos(this.usuarios);
  @override
  List<Object> get props => [usuarios];
}
