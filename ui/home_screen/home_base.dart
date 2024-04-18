import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/ui/login/pantalla_login.dart';


import '../../bloc/blocs_home/bloc_ranking/bloc.dart';
import '../../bloc/blocs_home/bloc_ver_reporte_psicologo/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_notificacion/bloc.dart';
import '../../bloc/blocs_login/bloc_login_screen/bloc.dart';
import 'pantalla_home.dart';




class HomeBase extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: MultiBlocProvider(
        providers: [

          BlocProvider<LeccionProgresoBloc>(
              create: (BuildContext context) => LeccionProgresoBloc()..add(iniciarVistaProgreso())),
          BlocProvider<AprendeBloc>(
              create: (BuildContext context) => AprendeBloc()..add(BuscarAprende())
          ),
          BlocProvider<RankingBloc>(
              create: (BuildContext context) => RankingBloc()..add(initRanking())
          ),
           BlocProvider<HabilidadBloc>(
              create: (context) => HabilidadBloc()..add(BuscarHabilidadGlobal()),
            ),
            BlocProvider<LeccionProgresoHabilidadBloc>(
              create: (context) => LeccionProgresoHabilidadBloc()..add(BuscarHabilidadProgresoGlobal()),
            ),
            BlocProvider<ReportePsicologBloc>(create: (context) =>ReportePsicologBloc()..add(iniciarVistaReportePsicolog())
            ),
            BlocProvider<NotificacionBloc>(create: (context) =>NotificacionBloc()..add(BuscarNotificaciones())
            ),
        ],
        child: Home(),
      ),
    );
  }
}