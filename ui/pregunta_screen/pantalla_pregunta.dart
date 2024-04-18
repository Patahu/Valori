import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/bloc/bloc_tiempo/bloc.dart';
import 'package:valorix/src/ui/ranking_screen/ranking_base.dart';

import '../../bloc/blocs_home/bloc_ranking/bloc.dart';

import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_video/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/habilidad.dart';
import '../../modelos/leccion.dart';
import 'pregunta_base.dart';

class PreguntaBase extends StatelessWidget {
  final Habilidad habilidad;
  final Leccion leccion;
  final Aprende aprende;
  const PreguntaBase({required this.habilidad,required this.leccion, required this.aprende});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: 

          MultiBlocProvider(
        providers: [

        BlocProvider<EjercicioBloc>(
              create: (BuildContext context) => EjercicioBloc()..add(BuscarEjercicio(leccion)),
              
          ),
          BlocProvider<TiempoBloc>(
              create: (BuildContext context) => TiempoBloc()
          ),
 

        ],
        child: PreguntaScreen(aprende: aprende,leccion: leccion,habilidad: habilidad,),
      )
    );
  }
}