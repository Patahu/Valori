import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/ui/ranking_screen/ranking_base.dart';
import 'package:valorix/src/ui/reporte_screen/reporte_base.dart';

import '../../bloc/blocs_home/bloc_ranking/bloc.dart';

import 'package:flutter/material.dart';

import '../../bloc/blocs_home/bloc_reporte/bloc.dart';
import '../../bloc/blocs_home/bloc_ver_reporte_psicologo/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_pregunta_crear/bloc.dart';
import '../../modelos/usuario.dart';

class ReporteBase extends StatelessWidget {
  final String tipo;

  const ReporteBase({super.key, required this.tipo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child:  MultiBlocProvider(providers: [
   
            BlocProvider<PreguntaLeccionCrearBloc>(
              create: (context) => PreguntaLeccionCrearBloc()),  
            BlocProvider<ReportePsicologBloc>(create: (context) =>ReportePsicologBloc()..add(iniciarVistaReportePsicolog())
            ),
                  BlocProvider<LeccionBloc>(
            create: (context) => LeccionBloc(),
          ),
            BlocProvider<ReporteBloc>(
              create: (context) => ReporteBloc()..add(initReporte(tipo))),
              
          ], child: _getScreen(tipo),
      ),
    )
    
    );
  }

  Widget _getScreen(String tipo) {
  switch (tipo) {
    case 'violencia':
      return ReporteScreen(tipo: tipo);
    case 'valor':
      return ReporteScreen(tipo: tipo);
    case 'ver_reportes':
      return ReporteScreeM(tipo: tipo);
    default:
      return Text('Tipo de reporte no reconocido: $tipo');
  }
}
}