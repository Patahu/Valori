


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/ui/login/pantalla_login.dart';


import '../../bloc/bloc_portador_imagen/bloc.dart';
import '../../bloc/blocs_home/bloc_visor_home/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_login/bloc_login_screen/bloc.dart';
import 'pantalla_cambiador.dart';


class cambiadorBase extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:           MultiBlocProvider(providers: [
           BlocProvider<CambiadorBloc>(
                create: (context) => CambiadorBloc(),
              ),
              BlocProvider<PortadorImagenBloc>(
              create: (context) => PortadorImagenBloc()..add(InicarPortadorImagen())),   
              //PortadorImagenBloc
            BlocProvider<VisorBloc>(
              create: (context) => VisorBloc()),     
          ], child: const cambiador()),
      /*BlocProvider<CambiadorBloc>(
        
        create: (context) => CambiadorBloc(),
        child: cambiador(),
      )*/
  

    );
  }
}