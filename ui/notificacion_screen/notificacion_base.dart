
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_notificacion/bloc.dart';
import '../../modelos/validators.dart';

class NotificacionScreen extends StatefulWidget {

  const NotificacionScreen({super.key});
  @override
  _NotificacionScreenState createState() => _NotificacionScreenState();
}

class _NotificacionScreenState extends State<NotificacionScreen> {
    final DateFormat dateFormat = DateFormat('MMM',);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Container(
                                height: MediaQuery.of(context).size.height*0.1,
                                          color: Colors.white,
                                          child: Stack(
                                            children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 10,),
                                                        InkWell(
                                                          onTap: () {
                                                             BlocProvider.of<CambiadorBloc>(context).add(backHome());
                                                          //leccionBloc.add(loadEspecialRerporteEjercicios());
                                                        // Acciones que deseas realizar cuando se toca el botón
                                                          },
                                                          child: Center(
                                                            child: Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border: Border.all(
                                                                  color: Colors.grey, // Color del borde
                                                                  width: 1, // Ancho del borde
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Image.asset(
                                                                  'lib/icon/back.png', // Ruta de la imagen
                                                                  width: 25, // Ajusta el tamaño de la imagen según sea necesario
                                                                  height: 25,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ),
                                                      ],
                                                    ),
                                                  Center(
                                                    child: Text(
                                                      'Notificaciones',
                                                      style: TextStyle(
                                                        fontSize: 21,
                                                        fontFamily: 'Lato',
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                  ),
            BlocBuilder<NotificacionBloc,NotificacionState>(
              builder: (context,state) {
                if(state.isTodo){
            return Column(
                                  children: [
                                   
      
                        
                                Container(
                                height: MediaQuery.of(context).size.height*0.7,
                                width: MediaQuery.of(context).size.width*0.97,
                                child: ListView(
                                                      
                              
                                                      children: [
                                                        Padding(
                                        padding: const EdgeInsets.only(bottom: 20,top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                
                                      

                                                       BlocProvider.of<NotificacionBloc>(context).add(CambiarNuevas());
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Colors.white, // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), 
                                                  side: BorderSide(color: Color(4278245019)),
                                                  // Bordes curvos
                                                ),
                                              ),
                                              child:Text(
                                                'Nuevas',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ),
                                            ),
                                           ElevatedButton(
                                              onPressed: () {
                                                
                                    
                                                    BlocProvider.of<NotificacionBloc>(context).add(CambiarTodos());

                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Color(4278245019), // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                 
                                                ),
                                              ),
                                              child:Text(
                                                'Todas',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),   
                                                                  Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black.withOpacity(0.2), // Color de la sombra
                                                        spreadRadius: 2, // Propaga la sombra
                                                        blurRadius: 4, // Difumina la sombra
                                                        offset: Offset(0, 2), // Desplazamiento de la sombra
                                                      ),
                                                    ],
                                                  ),
                                                  child:  Column(
                                                    children: [
      
      
                                                    ],
                                                  ),
                                                ),
                                                              
                                
      
                                                       Container(
                                                          height: MediaQuery.of(context).size.height,
                              
                                                          child: ListView.separated(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: state.leccionesTodo.length,
                                                            separatorBuilder: (BuildContext context, int index) {
                                                              return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                            },
                                                            itemBuilder: (BuildContext context, int index) {
                                                              final leccion = state.leccionesTodo[index];
       
                                                              return ElevatedButton(
                                                              onPressed: () {
                                                                //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
                                                                
                                                          
                                                                
                                                                //BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(leccion));
                                                                //  titulo.text='';
                                                                 // descripcion.text='';
                                                                  
                                                                 // leccionBloc.add(IngresarActualizarLeccion(leccion: leccion));
                                                                  //leccionBloc.add(ActualizarLeccion(leccion: leccion));
                                                                leccion.indexTemporal=index;
                                                            
                                                                BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(leccion));
                                                                print("---------------------------y");
                                                                // Acción al hacer clic en el botón
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                primary: Colors.white,
                                                                elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                                                minimumSize: Size(double.infinity, 80), // Ajusta el tamaño del botón según tus necesidades
                                                                padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                ),
                                                              ),
                                                              child: Stack(
                                                                alignment: AlignmentDirectional.bottomStart,
                                                                children: [
      
                                                                Container(
                                                                    height: 100,
      
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors.black.withOpacity(0.2), // Color de la sombra
                                                                          spreadRadius: 2, // Propaga la sombra
                                                                          blurRadius: 4, // Difumina la sombra
                                                                          offset: Offset(0, 2), // Desplazamiento de la sombra
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Container(),
                                                                  ),
      
                                                                  Container(
                                                                    height: 100,
      
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [

                                                                            Container(
                                                                              height: 50,
                                                                              width: 50,
                                                                        
                                                                              child: Image.network(
                                                                                  leccion.imagen, // URL de la imagen
                                                                                  fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                ),
                                                                            )
                                                                            ,
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                        width: 170, // Ancho del contenedor
                                                                                        child: Text(
                                                                                          leccion.nombre,
                                                                                          textAlign: TextAlign.start,
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontSize: 15,
                                                                                            fontFamily: 'Lato',
                                                                                         
                                                                                          ),
                                                                                          overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                                          maxLines: 3, // Limitar el texto a una sola línea
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(height: 10,),
                                                                                      Container(
                                                                                        width: 170, // Ancho del contenedor
                                                                                        child:Text(  textAlign: TextAlign.start,
                                                                                          '${leccion.fecha_ingresada.toDate().day} ${Validators.fechasEspa[leccion.fecha_ingresada.toDate().month]} ${leccion.fecha_ingresada.toDate().year}',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 97, 97, 97)),),
                                                                                      ),
                                                                              ],
                                                                            ),
                                                                            !leccion.es_echoo ?
                                                                            Container(
                                                                                height: 15,
                                                                                width: 15,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  color: Color(4278245019)
                                                                                ),
                                                                              ):Container(
                                                                                height: 15,
                                                                                width: 15,
                                                                              ),
      
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 10,),
                                                                        
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                              
                                                              /*barra_leccion(
                                                                index: index,
                                                                leccion: leccion,
                                                                usuario: stateF.usuario,
                                                                color: aprende.color,
                                                              );*/
                                                            },
                                                          ),
                                                        ),
                                   
                                                                          
                                                      ],
                                                    ),
                                  ),
                                  ],
                                );
              
                }else if(state.isNueva){
                
                  return Column(
                                  children: [
                          
                        
                                Container(
                                height: MediaQuery.of(context).size.height*0.7,
                                width: MediaQuery.of(context).size.width*0.97,
                                child: ListView(
                                                      
                              
                                                      children: [
                                                        Padding(
                                        padding: const EdgeInsets.only(bottom: 20,top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                    
                                                BlocProvider.of<NotificacionBloc>(context).add(CambiarNuevas());
                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Color(4278245019), // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), 
                                                  
                                                  // Bordes curvos
                                                ),
                                              ),
                                              child:Text(
                                                'Nuevas',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ),
                                            ),
                                           ElevatedButton(
                                              onPressed: () {

                                                //CambiarNuevas
                                                
                                  
                                             BlocProvider.of<NotificacionBloc>(context).add(CambiarTodos());

                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Colors.white, // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                  side: BorderSide(color: Color(4278245019)),
                                                 
                                                ),
                                              ),
                                              child:Text(
                                                'Todas',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),   
                                                                  Container(
                                
                                                  child:  Column(
                                                    children: [
      
      
                                                    ],
                                                  ),
                                                ),
                                                              
                                
      
                                                       Container(
                                                          height: MediaQuery.of(context).size.height,
                              
                                                          child: ListView.separated(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: state.leccionesNuevas.length,
                                                            separatorBuilder: (BuildContext context, int index) {
                                                              return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                            },
                                                            itemBuilder: (BuildContext context, int index) {
                                                              final leccion = state.leccionesNuevas[index];
       
                                                              return ElevatedButton(
                                                              onPressed: () {
                                                       
                                                                leccion.indexTemporal=index;
                                                            
                                                                BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(leccion));
                                                                print("---------------------------y");
                                                                // Acción al hacer clic en el botón
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                primary: Colors.white,
                                                                elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                                                minimumSize: Size(double.infinity, 80), // Ajusta el tamaño del botón según tus necesidades
                                                                padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(20.0),
                                                                ),
                                                              ),
                                                              child: Stack(
                                                                alignment: AlignmentDirectional.bottomStart,
                                                                children: [
      
                                                                Container(
                                                                    height: 100,
      
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors.black.withOpacity(0.2), // Color de la sombra
                                                                          spreadRadius: 2, // Propaga la sombra
                                                                          blurRadius: 4, // Difumina la sombra
                                                                          offset: Offset(0, 2), // Desplazamiento de la sombra
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Container(),
                                                                  ),
      
                                                                  Container(
                                                                    height: 100,
      
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [

                                                                            Container(
                                                                              height: 50,
                                                                              width: 50,
                                                                        
                                                                              child: Image.network(
                                                                                  leccion.imagen, // URL de la imagen
                                                                                  fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                ),
                                                                            )
                                                                            ,
                                                                            Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                Container(
                                                                                        width: 170, // Ancho del contenedor
                                                                                        child: Text(
                                                                                          leccion.nombre,
                                                                                          textAlign: TextAlign.start,
                                                                                          style: TextStyle(
                                                                                            color: Colors.black,
                                                                                            fontSize: 15,
                                                                                            fontFamily: 'Lato',
                                                                                         
                                                                                          ),
                                                                                          overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                                          maxLines: 3, // Limitar el texto a una sola línea
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(height: 10,),
                                                                                      Container(
                                                                                        width: 170, // Ancho del contenedor
                                                                                        child:Text(  textAlign: TextAlign.start,
                                                                                          '${leccion.fecha_ingresada.toDate().day} ${Validators.fechasEspa[leccion.fecha_ingresada.toDate().month]} ${leccion.fecha_ingresada.toDate().year}',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 97, 97, 97)),),
                                                                                      ),
                                                                              ],
                                                                            ),
                                                                            !leccion.es_echoo ?
                                                                            Container(
                                                                                height: 15,
                                                                                width: 15,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                  color: Color(4278245019)
                                                                                ),
                                                                              ):Container(
                                                                                height: 15,
                                                                                width: 15,
                                                                              ),
      
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: 10,),
                                                                        
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                              
                                                              /*barra_leccion(
                                                                index: index,
                                                                leccion: leccion,
                                                                usuario: stateF.usuario,
                                                                color: aprende.color,
                                                              );*/
                                                            },
                                                          ),
                                                        ),
                                   
                                                                          
                                                      ],
                                                    ),
                                  ),
                                  ],
                                );
              
                }
                return Container();
              
              }
            ),
          ],
        ),
      ),
    );
  }

}