





import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import '../../modelos/ejercicio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';

import '../../modelos/ejercicio.dart';

class PreguntaTipoSeleccionar extends StatelessWidget {
  final Ejercicio ejercicio;
  final Map<String,String> respueta;
  final int color;
  PreguntaTipoSeleccionar({required this.ejercicio, required this.respueta,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           SizedBox(height: 20,),
          Center(
            child: Text(
              ejercicio.pregunta,
              style: TextStyle(
                fontSize: 21,
                 fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
               ),
               textAlign: TextAlign.center,
             ),
           ),
          Container(
            width: MediaQuery.of(context).size.width*0.98,
            height: 220,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildBotonesCuadrados(context, ejercicio.alternativas, respueta,color)
                        .sublist(0, 2), // Primeros dos elementos
                  ),
                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildBotonesCuadrados(context, ejercicio.alternativas, respueta,color)
                        .sublist(2, 4), // Siguientes dos elementos
                  ),

                ],
              ),
          ),
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
          imagePath: value, // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: Color(color).withOpacity(0.5),
          llave:key,
        ),
      );
    } else {
      botones.add(
        BotonCuadrado(
          imagePath: value, // Utiliza el value del mapa como imagePath
          value: value,
          numero: alternativas.keys.toList().indexOf(key) , // Obtiene el índice del key
          color: Colors.white,
          llave:key,
        ),
          );
        }

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
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black, // Color del borde
              width: 1, // Ancho del borde
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              // Acción al presionar el botón
              print("LAVEEEEEEEEEEEEEEEEEEEEEE----------------------------"+value);
              BlocProvider.of<EjercicioBloc>(context).add(UIngresarRespuestaOrdenar(llave,value));
            },
            style: ElevatedButton.styleFrom(
              primary: color, // Fondo transparente para que el contenedor controle el color de fondo
              elevation: 0, // Sin sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.network(
                            imagePath, // URL de la imagen
                            fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                          ), // Reemplaza la ruta de la imagen por la tuya
                ),
                Text(
                  '${numero+1}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black
                    ),
                ),
              ],
            ),
          ),
        );
  }
}