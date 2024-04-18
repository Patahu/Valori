

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/ui/ranking_screen/ranking_base.dart';

import '../../bloc/blocs_home/bloc_ranking/bloc.dart';

import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';
import 'perfil_pantalla.dart';

class PerfilBase extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        bottom: false,
        child: MultiBlocProvider(
          providers: [
      
            BlocProvider<LeccionProgresoBloc>(
                create: (BuildContext context) => LeccionProgresoBloc()),
            BlocProvider<AprendeBloc>(
                create: (BuildContext context) => AprendeBloc()..add(BuscarAprende())
            ),
            BlocProvider<RankingBloc>(
                  create: (BuildContext context) => RankingBloc()..add(initAmigos()),
              ),
      
                         BlocProvider<HabilidadBloc>(
                create: (context) => HabilidadBloc()..add(BuscarHabilidadGlobal()),
              ),
              BlocProvider<LeccionProgresoHabilidadBloc>(
                create: (context) => LeccionProgresoHabilidadBloc()..add(BuscarHabilidadProgresoGlobal()),
              ),
      
          ],
          child: PerfilScreen(),
        ),
      ),
    );
  }
}