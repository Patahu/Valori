


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_video/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/habilidad.dart';
import '../../modelos/leccion.dart';
import 'video_base.dart';


class videoBase extends StatelessWidget {
  final Habilidad habilidad;
  final Leccion leccion;
  final Aprende aprende;
  const videoBase({required this.habilidad,required this.leccion, required this.aprende});
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
                create: (context) => LeccionBloc(),
              ),
            BlocProvider<YoutubePlayerBloc>(
              create: (context) => YoutubePlayerBloc()..add(iniciarVideo(leccion: leccion))),     
          ], child: YoutubePlayerScreen(habilidad:habilidad ,leccion: leccion,aprende:aprende))
        ],
      ),
    );
  }
}