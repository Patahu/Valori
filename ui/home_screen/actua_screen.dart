

import 'package:flutter/material.dart';

import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_notificacion/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class barra_estado_screen extends StatelessWidget {
  const barra_estado_screen({
    super.key,
    required this.stateF,
  });

  final Authenticated stateF;
  Widget _mostrarNumero(int numero) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Center(
        child: Text(
          numero > 9 ? '9+' : numero.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.1,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "¡Hola " + stateF.usuario.nombres + "!",
              style: TextStyle(
                fontSize: 21,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(


            children: [
              Text(
                stateF.usuario.progreso.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Color(4278245019),
                ),
              ),
              SizedBox(width: 10,),
              BlocBuilder<NotificacionBloc,NotificacionState>(

                builder: (context,state) {
                  if(state.isLoad){
                    return Container(
                      height: 50,
                      width: 50,
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () {
            BlocProvider.of<CambiadorBloc>(context).add(cambiarToNotificacion());

                            },
                            icon: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'lib/icon/notificacion.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: _mostrarNumero(state.leccionesNuevas.length),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container(
                      height: 50,
                      width: 50,
                      child: Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                                          BlocProvider.of<CambiadorBloc>(context).add(cambiarToNotificacion());

                            },
                            icon: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'lib/icon/notificacion.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: _mostrarNumero(0),
                          ),
                        ],
                      ),
                    );
                }
              ),

              SizedBox(width: 10,)
            ],
          ),
        ],
      ),
    );
  }
}