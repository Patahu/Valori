

import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_pregunta_crear/bloc.dart';


class barraDropBox extends StatelessWidget {
  const barraDropBox({
    super.key,
    required this.state,
    required this.preguntaLeccionCrearBloc
  });
  final PreguntaCrearState state;
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tipo',style: TextStyle(color: Colors.grey,  fontSize: 11,
                                    fontFamily: 'Lato',))
                                    ,SizedBox(height: 10,),
          DropdownButtonFormField(
            value: state.tipo,
            decoration: InputDecoration(

              labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                borderRadius:BorderRadius.all(Radius.circular(25.0)) ,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'seleccionar',
                child: Text('Seleccionar imagen',style: TextStyle(color: Colors.grey,  fontSize: 15,
                                    fontFamily: 'Lato',),),
              ),
              DropdownMenuItem(
                value: 'ordenar',
                child: Text('Ordenar las palabras de la oración',style: TextStyle(color: Colors.grey,fontSize: 15,
                                    fontFamily: 'Lato',),),
              ),
              DropdownMenuItem(
                value: 'completar',
                child: Text('Completar la oración',style: TextStyle(color: Colors.grey,fontSize: 15,
                                    fontFamily: 'Lato',),),
              ),
              DropdownMenuItem(
                value: 'audio',
                child: Text('Seleccionar los pares',style: TextStyle(color: Colors.grey,fontSize: 15,
                                    fontFamily: 'Lato',),),
              ),
              DropdownMenuItem(
                value: 'seleccionarAlt',
                child: Text('Responder pregunta',style: TextStyle(color: Colors.grey),),
              ),
            ],
            onChanged: (value) {
              
              preguntaLeccionCrearBloc.add(CambiarTipoPregunta(value!));
              //homeBloc.tipo.text = value!;
              //homeBloc.add(TextChangedEvent(value));
              //cambiarTipoPregunta

            },
          ),
        ],
      ),
    );
  }
}
