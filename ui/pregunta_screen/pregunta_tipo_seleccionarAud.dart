



import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import '../../modelos/ejercicio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:audioplayers/audioplayers.dart';



import 'package:flutter/material.dart';

import '../../modelos/ejercicio.dart';

class PreguntaTipoSeleccionarAut extends StatelessWidget {
  final Ejercicio ejercicio;
  final Map<String,String> respueta;
  PreguntaTipoSeleccionarAut({required this.ejercicio, required this.respueta});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:        Center(
              child: Text(
                ejercicio.pregunta,
                style: TextStyle(
                  fontSize: 21,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                ),
               ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildBotonesCuadrados(context, ejercicio.alternativas,respueta),
              ),
                            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildBotonesCuadrados2(context, ejercicio.alternativas,respueta),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBotonesCuadrados(BuildContext context, Map<String, String> alternativas, Map<String, String> respuestas) {
  List<Widget> botones = [];
  final colores=[4294937216, 4278245019, 4285358586];
  int _contador=0;
  if(respueta.isNotEmpty){
      alternativas.forEach((key, value) {
            int color=4285358586;
            bool encuentra=false;
            int numero=0;
            respuestas.forEach((key1, value1) { 
            final orden=value1.substring(0,1);
            final texto=value1.substring(1,value1.length);
            if(value==texto){
              encuentra=true;
              numero=int.parse(orden);
            }
          });
          if(encuentra){
            print("SI ESTAAAAAAAAAAAAAAAAAA");
            if(key!='0' && value!=''){
                  color=colores[numero];
          
                }
                botones.add(
                  BotonCuadrado(
                    imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
                    value: value,
                    numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
                    color: color,
                    llave:key,
                  ),
                );
            }else{
              botones.add(
                BotonCuadrado(
                  imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
                  value: value,
                  numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
                  color: 0,
                  llave:key,
                ),
              );
            }
        botones.add(SizedBox(height: 5,));
      });

    }else{
      alternativas.forEach((key, value) {
      int color=4285358586;
      if (respuestas.containsValue(value)) {
      botones.add(
        BotonCuadrado(
          imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: color,
          llave:key,
        ),
      );
      } else {
      botones.add(
        BotonCuadrado(
          imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: 0,
          llave:key,
        ),
          );
        }
        botones.add(SizedBox(height: 5,));
      });
    }

    return botones;
  }

  List<Widget> _buildBotonesCuadrados2(BuildContext context, Map<String, String> alternativas, Map<String, String> respuestas) {
  List<Widget> botones = [];
  final colores=[4294937216, 4278245019, 4285358586];
  int _contador=0;
  if(respueta.isNotEmpty){
      alternativas.forEach((key, value) {
            int color=4285358586;
            bool encuentra=false;
            int numero=0;
            respuestas.forEach((key1, value1) { 
            final orden=key1.substring(0,1);
            final texto=key1.substring(1,key1.length);
            if(key==texto){
              encuentra=true;
              numero=int.parse(orden);
            }
          });
          if(encuentra){
            print("SI ESTAAAAAAAAAAAAAAAAAA");
            if(key!='0' && value!=''){
                  color=colores[numero];
          
            }
              botones.add(
                  BotonCuadrado2(
                    imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
                    value: value,
                    numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
                    color: color,
                    llave:key,
                  ),
              );
            }else{
              botones.add(
                BotonCuadrado2(
                  imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
                  value: value,
                  numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
                  color: 0,
                  llave:key,
                ),
              );
            }
        botones.add(SizedBox(height: 5,));
      });

    }else{
      alternativas.forEach((key, value) {
      int color=4285358586;
      if (respuestas.containsKey(key)) {
      botones.add(
        BotonCuadrado2(
          imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: color,
          llave:key,
        ),
      );
      } else {
      botones.add(
        BotonCuadrado2(
          imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: 0,
          llave:key,
        ),
          );
        }
        botones.add(SizedBox(height: 5,));
      });
    }


      return botones;
    }
}





class BotonCuadrado extends StatelessWidget {
  final String imagePath;
  final String value;
  final int numero;
  final int color;
  final String llave;
  const BotonCuadrado({
    Key? key,
    required this.imagePath,
    required this.value,
    required this.numero,
    required this.color,
    required this.llave
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 40, // Ancho fijo del primer botón
              height: 40,
               decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
              child: TextButton(
                onPressed: () {
                  // Acción al presionar el botón
                  BlocProvider.of<EjercicioBloc>(context).add(IniciarAudio(urlAudio:value));
                  
                 //BlocProvider.of<EjercicioBloc>(context).add(UIngresarRespuestaOrdenar(llave,value));
                },
                style: TextButton.styleFrom(
                  primary: Color(color), // Color del texto
                  backgroundColor: Colors.white, // Color de fondo del botón
       
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Icon(Icons.volume_up,color: Colors.black,),
              ),
            ),
            SizedBox(
              width: 60, // Ancho fijo del segundo botón
              child: TextButton(
                onPressed: () {
                  // Acción al presionar el botón
                  //BlocProvider.of<EjercicioBloc>(context).add(IniciarAudio(urlAudio:value));
                  BlocProvider.of<EjercicioBloc>(context).add(UIngresarRespuestaOrdenar('0',value));
                },
                style: TextButton.styleFrom(
                  primary: Colors.transparent, // Color del texto
                  backgroundColor: Color(color), // Color de fondo del botón
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(''),
              ),
            )
          ],
        ),
      )

    ;
  }
}


class BotonCuadrado2 extends StatelessWidget {
  final String imagePath;
  final String value;
  final int numero;
  final int color;
  final String llave;
  const BotonCuadrado2({
    Key? key,
    required this.imagePath,
    required this.value,
    required this.numero,
    required this.color,
    required this.llave
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.black, // Color del borde
              width: 1, // Ancho del borde
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              // Acción al presionar el botón
              //BlocProvider.of<EjercicioBloc>(context).add(IniciarAudio(urlAudio:value));
              BlocProvider.of<EjercicioBloc>(context).add(UIngresarRespuestaOrdenar(llave,''));
            },
            style: ElevatedButton.styleFrom(
              primary: Color(color), // Fondo transparente para que el contenedor controle el color de fondo
              elevation: 0, // Sin sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
                  llave,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black
                    ),
                ),
          ),
        );
  }
}