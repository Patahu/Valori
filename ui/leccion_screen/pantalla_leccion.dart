

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_video/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/habilidad.dart';
import 'leccion_base_valores.dart';

class LeciconesBase extends StatelessWidget {
  final Habilidad habilidad;
  final Aprende aprende;
  const LeciconesBase({required this.habilidad, required this.aprende});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color:Colors.white24,
          ),
            MultiBlocProvider(providers: [
      BlocProvider<LeccionBloc>(
            create: (context) => LeccionBloc()..add(BuscarLeccion(habilidad.id)),
          ),
            BlocProvider<YoutubePlayerBloc>(
              create: (context) => YoutubePlayerBloc()),     
          ], child:  LeccionScreen(habilidad: habilidad,aprende: aprende,))
          ,
        ],
      ),
    );
  }
}