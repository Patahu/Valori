



import 'package:flutter/material.dart';

import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/bloc_ranking/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs_home/bloc_visor_home/bloc.dart';
import '../home_screen/pantalla_home.dart';
class RankingScreen extends StatefulWidget {

  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingState();
}

class _RankingState extends State<RankingScreen> {
  

  @override
  void initState() {

    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
                SafeArea(
                   bottom: false,
                  child: Column(
                    children: [
                
                     Container(
                        height: MediaQuery.of(context).size.height*.1,
                        color: Colors.white,
                        child: Stack(
                          children: [
                                  Row(
                
                                    children: [
                                      SizedBox(width: 10,),
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<CambiadorBloc>(context).add(backHome());
                                        
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
                                    'Ranking',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                              ),
                               Container(
                  height: MediaQuery.of(context).size.height*.8,
                   child: ListView(
                     children: [
                       ClipRRect( // Utilizar ClipRRect para bordes curvos alrededor de la imagen
                               
                        child: Container(
                                decoration: BoxDecoration(
                              color: Colors.transparent, // Color de fondo del contenedor
                              borderRadius: BorderRadius.all(Radius.circular(20.0),),
                              border: Border.all(
                              color: Colors.grey, // Color del borde
                              width: 1.0, // Ancho del borde
                            ),
                            ),
                            width: MediaQuery.of(context).size.width*0.95,
                                                  height: 150,
                                                  child: Image.asset(
                                                    'lib/icon/ranking.png', // Ruta de la imagen
                                                   // Ajustar la imagen para cubrir el área circular
                                  ),
                              ),
                            ),
                      BlocBuilder<RankingBloc,RankingState>(
                        builder: (context,state){
                          if(state.isLoad){
                              return Column(
                                children: [
                                  PodioGanadores(usuarios: state.listaUsuariosRanking),
                                  Container(
                                                      height:30+(state.listaUsuariosRanking.length - 3)*85,
                          
                                                      child: ListView.separated(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount: state.listaUsuariosRanking.length - 3, 
                                                        separatorBuilder: (BuildContext context, int index) {
                                                          return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                        },
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final usuarios = state.listaUsuariosRanking[index + 3];
                                                          return ElevatedButton(
                                                          onPressed: () {
                                                      
                                                            // Acción al hacer clic en el botón
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            primary: Colors.transparent,
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
                                                                height: 70,
                
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
                                                                height: 70,
                
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        Text(
                                                                                 '${index+4}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 15,
                                                                                    fontFamily: 'Lato',
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                  overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                                  maxLines: 1, // Limitar el texto a una sola línea
                                                                                ),
                                                                       Container(
                                                                          height: 60,
                                                                          width: 60,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            border: Border.all(
                                                                              color: Color(4278245019), // Color del borde
                                                                              width: 1, // Ancho del borde
                                                                            ),
                                                                          ),
                                                                          child: ClipOval(
                                                                            child: Image.network(
                                                                                usuarios.imagen, // URL de la imagen
                                                                                fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                              ),
                                                                          ),
                                                                        ),
                                                                        
                                                                        Container(
                                                                          height: 70,
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Container(
                                                                                width: 170, // Ancho del contenedor
                                                                                child: Text(
                                                                                  usuarios.nombres,
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 15,
                                                                                    fontFamily: 'Lato',
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                  overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                                  maxLines: 1, // Limitar el texto a una sola línea
                                                                                ),
                                                                              ),
                                                                           
                                                                              Container(
                                                                                width: 170, // Ancho del contenedor
                                                                                child: Text(
                                                                                  usuarios.progreso.toString(),
                                                                                  style: TextStyle(
                                                                                    color: Color(4278245019),
                                                                                    fontSize: 15,
                                                                                    fontFamily: 'Lato',
                                                                                  ),
                                                                                  overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                                  maxLines: 1, // Limitar el texto a una sola línea
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                
                                                              
                                                                      ],
                                                                    ),
                                                          
                                  
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
                                                )
                                ],
                              );
                          }
                          return Container();
                        }
                        ),
                     ],
                   ),
                               ),
                          
                    ],
                  ),
                ),
  );
  }
  
  }