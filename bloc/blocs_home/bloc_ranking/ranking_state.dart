

import '../../../modelos/usuario.dart';

class RankingState {
  final bool isLoad;
  final List<Usuario> listaUsuariosRanking;
   final List<Usuario> listaUsuariosAmigos;

  RankingState({
    required this.isLoad,
    required this.listaUsuariosRanking,
     required this.listaUsuariosAmigos,
  });

  RankingState copyWith({
    bool? isLoad,
    List<Usuario>? listaUsuariosRanking,
    List<Usuario>? listaUsuariosAmigos,
  }) {
    return RankingState(
      isLoad: isLoad ?? this.isLoad,
      listaUsuariosRanking: listaUsuariosRanking ?? this.listaUsuariosRanking,
      listaUsuariosAmigos: listaUsuariosAmigos ?? this.listaUsuariosAmigos,
    );
  }

  static RankingState empty() {
    return RankingState(
      isLoad: false,
      listaUsuariosRanking:[],
      listaUsuariosAmigos: [Usuario.empty,Usuario.empty,Usuario.empty],
    );
  }

  RankingState update({
    bool? isLoad,
    List<Usuario>? listaUsuariosRanking,
    List<Usuario>? listaUsuariosAmigos,
  }) {
    return copyWith(
      isLoad: isLoad,
      listaUsuariosRanking: listaUsuariosRanking,
      listaUsuariosAmigos:listaUsuariosAmigos,
    );
  }

  @override
  String toString() {
    return 'RankingState(isLoad: $isLoad, listaUsuarios: $listaUsuariosRanking)';
  }

  @override
  List<Object?> get props => [isLoad, listaUsuariosRanking,listaUsuariosAmigos];
}