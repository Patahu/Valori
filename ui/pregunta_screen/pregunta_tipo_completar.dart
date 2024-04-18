

import 'dart:math';

import 'package:flutter/material.dart';

import '../../bloc/bloc_portador_imagen/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import '../../modelos/ejercicio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modelos/habilidad.dart';
class PreguntaTipoCompletar extends StatelessWidget {
  final Ejercicio ejercicio;
  final Map<String,String> respueta;
  final Habilidad habilidad;

  PreguntaTipoCompletar({required this.ejercicio,required this.respueta,required this.habilidad});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
            SizedBox(height: 20,),
            Center(
            child: Text(
              'Completa la oración eligiendo la alternativa correcta',
              style: TextStyle(
                fontSize: 21,
                 fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
               ),
               textAlign: TextAlign.center,
             ),
           ),
              BlocBuilder<PortadorImagenBloc, PortadorImagenState>(
                      builder: (context,state){
                        if(state.isLoadAll){
                          if(habilidad.tipo=='cuadro'){
                            var randomIndex = Random().nextInt(state.fotosHistoria.length);
                            final image=state.fotosHistoria[randomIndex];
                            return Container(
                                height: 90,
                                width: 90,
                                child: Image.network(
                                  image, // URL de la imagen
                                  fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                ),
                              );
                          }else if(habilidad.tipo=='nivel'){
                            var randomIndex = Random().nextInt(state.fotosEjercicio.length);
                            final image=state.fotosEjercicio[randomIndex];
                            return Container(
                                height: 90,
                                width: 90,
                                child: Image.network(
                                  image, // URL de la imagen
                                  fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                ),
                              );
                          }
                        }
                        return Container();
                      },
                        
              ),
                SizedBox(height: 20,),
           Container(

          child: Text(
          
            ejercicio.pregunta,
            textAlign:TextAlign.center,
            style: TextStyle(
              fontSize: 17, // Cambiar el tamaño de la fuente según sea necesario
            ),
          ),
        ),
                  Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildBotonesCuadrados(context, ejercicio.alternativas,respueta,habilidad.color),
          ),
          /*Container(
                          width: MediaQuery.of(context).size.width*0.98,
          height: 50,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              
            children: _buildBotonesCuadradosRespuesta(context, respueta),
                    ),
          ),
          Container(
                          width: MediaQuery.of(context).size.width*0.98,
              height: 50,
            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildBotonesCuadrados(context, ejercicio.alternativas,respueta),
            ),
          ),*/
        ],
      ),
    );
  }

  List<Widget> _buildBotonesCuadrados(BuildContext context, Map<String, String> alternativas, Map<String, String> respuestas, int color) {
  List<Widget> botones = [];
  print("JEEEEEEEEEEEEEEEEEEEEEEEEE"+respuestas.length.toString());
  alternativas.forEach((key, value) {
    if (respuestas.containsKey(key)) {
      botones.add(
        BotonCuadrado(
          imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: Color(color).withOpacity(0.5),
          llave:key,
        ),
      );
    } else {
      botones.add(
        BotonCuadrado(
          imagePath: 'lib/icon/$value.jpg', // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: Colors.white,
          llave:key,
        ),
          );
        }
        botones.add(SizedBox(height: 5,));
      });

      return botones;
    }
}



class BotonCuadrado extends StatelessWidget {
  final String imagePath;
  final String value;
  final int numero;
  final Color color;
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
          width: MediaQuery.of(context).size.width*.95,
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
              BlocProvider.of<EjercicioBloc>(context).add(UIngresarRespuestaOrdenar(llave,value));
            },
            style: ElevatedButton.styleFrom(
              primary: color, // Fondo transparente para que el contenedor controle el color de fondo
              elevation: 0, // Sin sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Row(
              children: [
                Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                        ),
                    ),
              ],
            ),
          ),
        );
  }
}