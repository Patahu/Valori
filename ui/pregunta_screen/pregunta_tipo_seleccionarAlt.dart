



import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import '../../modelos/ejercicio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';






import 'package:flutter/material.dart';

import '../../modelos/ejercicio.dart';

class PreguntaTipoSeleccionarAlt extends StatelessWidget {
  final Ejercicio ejercicio;
  final Map<String,String> respueta;
  final int color;
  PreguntaTipoSeleccionarAlt({required this.ejercicio, required this.respueta, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.95,
      child: ListView(
       
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
           SizedBox(height: 20,),
           ejercicio.imagenFuera.isNotEmpty ? ClipRRect( // Utilizar ClipRRect para bordes curvos alrededor de la imagen
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width*0.95,
                                                height: 150,
                                                child: Image.network(
                                            
                                                  ejercicio.imagenFuera, // URL de la imagen
                                                  fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                ),
                                              ),
                                            ):Container(),

        SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      ejercicio.descripcion,
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Lato',
                       
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildBotonesCuadrados(context, ejercicio.alternativas,respueta,color),
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