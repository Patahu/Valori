

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_pregunta_crear/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_video/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/habilidad.dart';
import 'leccion_base_valores.dart';
import 'leccion_base_fecha.dart';
import 'leccion_base_historias.dart';
import 'leccion_base_ejercicios.dart';

class LeciconesBaseTipo1 extends StatelessWidget {
  final Habilidad habilidad;

  const LeciconesBaseTipo1({required this.habilidad});
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
            BlocProvider<PreguntaLeccionCrearBloc>(
              create: (context) => PreguntaLeccionCrearBloc()),   
          ], child: _getLeccionScreen(habilidad)),
          /*BlocProvider<LeccionBloc>(
            create: (context) => LeccionBloc()..add(BuscarLeccion(habilidad.id)),
            child: habilidad.tipo=='nivel' ? LeccionScreen2(habilidad: habilidad):LeccionScreen1(habilidad: habilidad),
          ),*/
        ],
      ),
    );
  }
  Widget _getLeccionScreen(Habilidad habilidad) {
  switch (habilidad.tipo) {
    case 'nivel':
      return LeccionScreenEjercicios(habilidad: habilidad);
    case 'cuadro':
      return LeccionScreenHistorias(habilidad: habilidad);
    case 'fecha':
      return LeccionScreenFecha(habilidad: habilidad);
    default:
      return Text('Tipo de habilidad no reconocido: ${habilidad.tipo}');
  }
}
}

