



import 'package:flutter/material.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/habilidad.dart';
import '../../modelos/usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class barra_aprende1 extends StatelessWidget {
  final Aprende aprende;
  final Usuario usuario;

  const barra_aprende1({
    Key? key,
    required this.aprende,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 120,
          width:MediaQuery.of(context).size.width*.45,
   
         
        ),
        BlocBuilder<LeccionProgresoBloc, LeccionProgresoState>(
          builder: (context, state) {
            if(state.esCargado){
              String s= "${ state.resultados[aprende.id] != null ? state.resultados[aprende.id]!.enProgreso:0} ";
    
              return Container(
                height: 120,
                decoration: BoxDecoration(
                color: Color(aprende.color),
                borderRadius: BorderRadius.circular(20.0), // Ajusta el radio según tus preferencias
              ),
                width:MediaQuery.of(context).size.width*.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 15,bottom: 5),
                               child: Text(
                                               aprende.nombre,
                                               style: TextStyle(
                                                 fontSize: 15,
                                                 fontFamily: 'Lato',
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.black
                                               ),
                                             ),
                             ),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                            s,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                ),
                           ],
                         ),
                         Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,bottom: 20),
                child: Container(
                  height: 60,
                  width: 60,
                
                ),
              ),
            ),
                 
                       ],
                     ),
                  Padding(
                    padding: const EdgeInsets.only(left:15),
                    child: Text(
                            "de ${state.resultados[aprende.id]!= null ? state.resultados[aprende.id]!.total:0} lecciones",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lato',
                              color: Colors.black
                           
                            ),
                          ),
                  ),
                  ],
                ),
              );
            }
            return Container(
              height: 30,
              width: 70,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2, // Ancho de la línea del indicador
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Color del indicador
                  backgroundColor: Colors.transparent, // Color de fondo (transparente en este caso)
                  // Radio del círculo (la mitad del tamaño deseado)
                ),
              ),
            );
    
          }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment:Alignment.topRight,
              child: Image.network(
                    height: 80,
                  width: 80,
                            aprende.imagen, // URL de la imagen
                            fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                          ),
            ),
          )
        
      ],
    );
  }
}



class barra_aprende2 extends StatelessWidget {
  final Habilidad habilidad;
  final Usuario usuario;

  const barra_aprende2({
    Key? key,
    required this.habilidad,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 120,
          width:MediaQuery.of(context).size.width*.45,
   
         
        ),
        BlocBuilder<LeccionProgresoHabilidadBloc, LeccionProgresoHabilidadState>(
          builder: (context, state) {
            if(state.esCargado){
              String s= "${ state.resultados[habilidad.id] != null ? state.resultados[habilidad.id]!.enProgreso:0} ";
          
              return Container(
                height: 120,
                decoration: BoxDecoration(
                color: Color(habilidad.color),
                borderRadius: BorderRadius.circular(20.0), // Ajusta el radio según tus preferencias
              ),
                width:MediaQuery.of(context).size.width*.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 15,bottom: 5),
                               child: Text(
                                               habilidad.nombre,
                                               style: TextStyle(
                                                 fontSize: 15,
                                                 fontFamily: 'Lato',
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.black
                                               ),
                                             ),
                             ),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                            s,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                ),
                           ],
                         ),
                         Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,bottom: 20),
                child: Container(
                  height: 60,
                  width: 60,
                
                ),
              ),
            ),
                 
                       ],
                     ),
                  Padding(
                    padding: const EdgeInsets.only(left:15),
                    child: Text(
                            "completados",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lato',
                              color: Colors.black
                           
                            ),
                          ),
                  ),
                  ],
                ),
              );
            }
            return Container(
              height: 30,
              width: 70,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2, // Ancho de la línea del indicador
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Color del indicador
                  backgroundColor: Colors.transparent, // Color de fondo (transparente en este caso)
                  // Radio del círculo (la mitad del tamaño deseado)
                ),
              ),
            );
    
          }),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment:Alignment.topRight,
              child: Image.network(
                    height: 80,
                  width: 80,
                            habilidad.imagen, // URL de la imagen
                            fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                          ),
            ),
          )
        
      ],
    );
  }
}


class barra_aprende3 extends StatelessWidget {
  final Habilidad habilidad;
  final Usuario usuario;

  const barra_aprende3({
    Key? key,
    required this.habilidad,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 120,
          width:MediaQuery.of(context).size.width*.45,
   
         
        ),
         Container(
                height: 120,
                decoration: BoxDecoration(
                color: Color(habilidad.color),
                borderRadius: BorderRadius.circular(20.0), // Ajusta el radio según tus preferencias
              ),
                width:MediaQuery.of(context).size.width*.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 15,bottom: 5),
                               child: Text(
                                               habilidad.nombre,
                                               style: TextStyle(
                                                 fontSize: 15,
                                                 fontFamily: 'Lato',
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.black
                                               ),
                                             ),
                             ),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                            usuario.top.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                ),
                           ],
                         ),
                         Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,bottom: 20),
                child: Container(
                  height: 60,
                  width: 60,
                
                ),
              ),
            ),
                 
                       ],
                     ),
                  Padding(
                    padding: const EdgeInsets.only(left:15),
                    child: Text(
                            "veces",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lato',
                              color: Colors.black
                           
                            ),
                          ),
                  ),
                  ],
                ),
              ),
            
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment:Alignment.topRight,
              child: Image.network(
                    height: 80,
                  width: 80,
                            habilidad.imagen, // URL de la imagen
                            fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                          ),
            ),
          )
        
      ],
    );
  }
}

