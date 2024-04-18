import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/ui/ranking_screen/ranking_base.dart';

import '../../bloc/blocs_home/bloc_ranking/bloc.dart';

import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_notificacion/bloc.dart';
import 'notificacion_base.dart';


class NotificacionBase extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: MultiBlocProvider(
        providers: [

          BlocProvider<NotificacionBloc>(create: (context) =>NotificacionBloc()..add(BuscarNotificaciones())
            ),

        ],
        child: NotificacionScreen(),
      ),
    );
  }
}