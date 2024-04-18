

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/ui/ranking_screen/ranking_base.dart';

import '../../bloc/blocs_home/bloc_ranking/bloc.dart';

import 'package:flutter/material.dart';

import '../../bloc/blocs_home/bloc_resume/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../modelos/habilidad.dart';
import '../../modelos/resume.dart';
import 'resume_screen.dart';

class ResumeBase extends StatelessWidget {
  final List<Resume> resumen;
  final int color;
  final String tipo;
  const ResumeBase({super.key,required this.resumen, required this.color, required this.tipo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ResumeBloc>(
              create: (BuildContext context) => ResumeBloc()..add(initResume(resumen)),
          ),
 
        ],
        child: ResumeScreen(leccion: 5,color: color,resumen: resumen,tipo: tipo,),
      ),
    );
  }
}