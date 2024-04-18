
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/ui/habilidad_screen/pantalla_habilidad.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';

class HabilidadBase extends StatelessWidget {
  final Aprende aprende;
  const HabilidadBase({required this.aprende});
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
            BlocProvider<HabilidadBloc>(
              create: (context) => HabilidadBloc()..add(BuscarHabilidad(aprende.id)),
            ),
            BlocProvider<LeccionProgresoHabilidadBloc>(
              create: (context) => LeccionProgresoHabilidadBloc()..add(iniciarVistaHabilidadProgreso(aprende.id)),
            ),
          ], child: HabilidadScreen(aprende: aprende,))
        ],
      ),
    );
  }
}