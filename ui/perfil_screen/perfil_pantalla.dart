

import 'package:flutter/material.dart';
import 'package:valorix/src/modelos/habilidad.dart';

import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/bloc_ranking/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs_home/bloc_visor_home/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../../modelos/usuario.dart';
import '../home_screen/aprende_screen.dart';
import '../home_screen/pantalla_home.dart';
import 'aprende_screen.dart';
class PerfilScreen extends StatefulWidget {

  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilState();
}

class _PerfilState extends State<PerfilScreen> {
  

  @override
  void initState() {

    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    'Mi perfil',
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
                
                 BlocBuilder<AuthBloc, AuthState>(
                   builder: (context, state){
                    if(state is Authenticated){
                      final stateF = state as Authenticated;
                      return Container(
                        height: MediaQuery.of(context).size.height*.8,

                        child: ListView(
                          
                          children: [
                            PodioItem(posicion: 1, radio: 50, usuario: stateF.usuario,),
                            Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "Aprende",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                            ),
                            BlocConsumer<AprendeBloc, AprendeState>(
                                listener: (context, state){
                      
                                  //iniciarVistaProgreso()
                                },
                        
                                builder: (context,state){
                                  if( state.isNewMessaging ){
                                    BlocProvider.of<LeccionProgresoBloc>(context).add(iniciarVistaProgreso());
                                    return Container(
                                    
                                      height: 150,
                                      width: MediaQuery.of(context).size.width,
                                      child:GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                          crossAxisCount: 2,
                                          childAspectRatio:1.2,
                                          children: List.generate(state.aprenderes!.length, (index) {
                                                       final aprende = state.aprenderes![index];
                                          return barra_aprende1(
                                            aprende: aprende,
                                            usuario: stateF.usuario,
                                          );
                      
                                          })));
                                     
                                  }
                                
                                          
                                  return Container();
                                },
                              ),
                    BlocConsumer<HabilidadBloc, HabilidadState>(
                                listener: (context, state){
                      
                                  //iniciarVistaProgreso()
                                },
                        
                                builder: (context,state){
                                  if( state.isLoadHabilidad ){
                                    //BlocProvider.of<LeccionProgresoBloc>(context).add(iniciarVistaProgreso());
                                    return Container(
                                    
                                      height: 170,
                                      width: MediaQuery.of(context).size.width,
                                      child:GridView.count(
                                        physics: NeverScrollableScrollPhysics(),
                                          crossAxisCount: 2,
                                          childAspectRatio:1.2,
                                          children:  [
                                                  // Check for "Retos" skill and render the widget
                                                  if (state.habilidades!.any((habilidad) => habilidad.nombre == 'Retos'))
                                                    barra_aprende2(
                                                      habilidad: state.habilidades!.firstWhere((habilidad) => habilidad.nombre == 'Retos'),
                                                      usuario: stateF.usuario,
                                                    ),
                                                    barra_aprende3(
                                                      habilidad: Habilidad.empty3(),
                                                      usuario: stateF.usuario,
                                                    ),
                                             
                                                ],
                                          
                                          ));
                                     
                                  }
                                
                                          
                                  return Container();
                                },
                              ),

                              SizedBox(height: 50,),

                                     Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                      

                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                minimumSize: Size(MediaQuery.of(context).size.width*.96, 50), // Ajusta el tamaño del botón según tus necesidades
                                padding: EdgeInsets.only(left: 10, right: 10), // Elimina el espacio alrededor del contenido del botón
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                              },
                              child: Text("Cerrar sesión"),
                            ),
                          ],
                        ),
                         SizedBox(height: 50,),
                   Padding(
                                        padding: EdgeInsets.only(left: 15,bottom: 15,top: 15),
                                        child: Text(
                                          "Amigos",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                          ),



                                              BlocBuilder<RankingBloc,RankingState>(
                      builder: (context,state){
                        if(state.isLoad){
                            return Column(
                              children: [
                              
                                Container(
                                                    height:30+(state.listaUsuariosAmigos.length)*85,
                        
                                                    child: ListView.separated(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemCount: state.listaUsuariosAmigos.length, 
                                                      separatorBuilder: (BuildContext context, int index) {
                                                        return SizedBox(height: 0); // Espacio entre elementos de la lista
                                                      },
                                                      itemBuilder: (BuildContext context, int index) {
                                                        final usuarios = state.listaUsuariosAmigos[index];
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
                                                                                usuarios.nombres+' '+usuarios.apellidos,
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
                      );
                    }
                    return Container();
                   }),

         
        
      
                    ],
                  ),
      ),
  );
  }
  
  }




  class PodioItem extends StatelessWidget {
  final Usuario usuario;
  final int posicion;
  final double radio;
  const PodioItem({Key? key, required this.usuario, required this.posicion, required this.radio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // Fondo con gradiente para el borde
          
        Container(
          width: radio + 80, // El doble del radio más el ancho del borde
          height: radio + 80, // El doble del radio más el ancho del borde
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1,
              colors: [
                Colors.white, // Color transparente en el centro
                Color(4278245019).withOpacity(0.3), // Color verde con opacidad
                Color(4278245019).withOpacity(0.1),
                Colors.transparent, // Color transparente para mezcla suave
              ],
              stops: [0.0, 0.3,0.43, 1.0], // Stops para controlar la transición
            ),
          ),
        ),

         Container(
          width: radio + 65, // El doble del radio más el ancho del borde
          height: radio + 65, // El doble del radio más el ancho del borde
          decoration: BoxDecoration(
            border: Border.all(color: Color(4278245019), width: 4),
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: ClipOval(
              child: Container(
                height: radio + 54,
                width: radio + 60,
                child: Image.network(
                        usuario.imagen, // URL de la imagen
                        fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                      ),
              ),
            ),
          ),
        ),
          ],
        ),
        SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${usuario.nombres} ${usuario.apellidos}',
                      style: TextStyle(fontSize: 17),
                    ),
                SizedBox(height: 20,),
                    Text(
                      '${usuario.progreso}',
                      style: TextStyle(fontSize: 21,color: Color(4278245019),fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 30,),
                  ],
                )
               
      ],
    );
  }
}