import 'dart:math';

import 'package:flutter/material.dart';

import '../../bloc/bloc_portador_imagen/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import '../../modelos/ejercicio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modelos/habilidad.dart';
class PreguntaTipoOrdenar extends StatelessWidget {
  final Ejercicio ejercicio;
  final Habilidad habilidad;
  final Map<String,String> respueta;

  PreguntaTipoOrdenar({required this.ejercicio,required this.respueta, required this.habilidad});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.95,
      child: ListView(
        
        children: [
          SizedBox(height: 20,),
          Center(
            child: Text(
              'Responde ordenando las palabras de los botones',
              style: TextStyle(
                fontSize: 21,
                 fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
               ),
               textAlign: TextAlign.center,
             ),
           ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<PortadorImagenBloc, PortadorImagenState>(
                      builder: (context,state){
                        if(state.isLoadAll){
                          if(habilidad.tipo=='cuadro'){
                            var randomIndex = Random().nextInt(state.fotosHistoria.length);
                            final image=state.fotosHistoria[randomIndex];
                            return Container(
                                height: 50,
                                width: 50,
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
              
              Container(
                width:MediaQuery.of(context).size.width*.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Cambiar la posición de la sombra según sea necesario
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right:70.0,bottom: 10,top: 10,left: 10),
                child: Text(
                  ejercicio.pregunta,
                  style: TextStyle(
                    fontSize: 17, // Cambiar el tamaño de la fuente según sea necesario
                  ),
                ),
              ),
        ),
            ],
          ),
    SizedBox(height: 100,),
          
    Container(
      width: MediaQuery.of(context).size.width * 0.98,
      height: 2, // Altura de la línea encima del Container principal
      color: Colors.grey, // Color de la línea encima del Container principal
    ),
    SizedBox(height: 10,),
          Container(
              width: MediaQuery.of(context).size.width*0.98,
              height: 120,
              child: Wrap(
                           spacing: 5,
              runSpacing: 5,
                   alignment: WrapAlignment.center,
            
              children: _buildBotonesCuadradosRespuesta(context, respueta),
                      ),
            ),
                Container(
      width: MediaQuery.of(context).size.width * 0.98,
      height: 2, // Altura de la línea encima del Container principal
      color: Colors.grey, // Color de la línea encima del Container principal
    ),
     SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width*0.98,
            height: 120,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildBotonesCuadrados(context, ejercicio.alternativas, respueta)
                        .sublist(0, ejercicio.alternativas.length), // Primeros dos elementos
                  ),
 

                ],
              ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBotonesCuadrados(BuildContext context, Map<String, String> alternativas, Map<String, String> respuestas) {
  List<Widget> botones = [];

  alternativas.forEach((key, value) {
    if (respuestas.containsKey(key)) {
      botones.add(
        Container(
          color: Colors.white,
        
        ),
      );
    } else {
      botones.add(
        BotonCuadrado(
          texto: value, // Utiliza el key del mapa como texto
          numero: key , // Obtiene el índice del key
          funcion:  () {
            BlocProvider.of<EjercicioBloc>(context).add(UIngresarRespuestaOrdenar(key,value));
      
          },
        ),
      );
    }

  });

  return botones;
}
  List<Widget> _buildBotonesCuadradosRespuesta(BuildContext context, Map<String, String> respuestas) {
  List<Widget> botones = [];

  respuestas.forEach((key, value) {
          botones.add(
        BotonCuadrado(
          texto: value, // Utiliza el key del mapa como texto
          numero: key , // Obtiene el índice del key
          funcion:  () {
            BlocProvider.of<EjercicioBloc>(context).add(UEliminarRespuestaOrdenar(key));
      
          }
        ),
      );

  });

  return botones;
}
}





class BotonCuadrado extends StatelessWidget {
  final String texto;
  final String numero;
  final Function() funcion;
  const BotonCuadrado({
    Key? key,
    required this.texto,
    required this.numero,
    required this.funcion
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.black, // Color del borde
              width: 2, // Ancho del borde
            ),
          ),
        child: ElevatedButton(
          onPressed:funcion,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, // Fondo transparente para que el contenedor controle el color de fondo
              elevation: 0, // Sin sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          child: Text(
            texto,
            style: TextStyle(fontSize: 12,
            color: Colors.black,
            ),
            
          ),
        ),
      ),
    );
  }
}
