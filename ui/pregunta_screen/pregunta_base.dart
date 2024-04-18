
import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/bloc_tiempo/bloc.dart';
import 'package:valorix/src/modelos/habilidad.dart';

import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/bloc_ranking/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_video/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/leccion.dart';
import '../../modelos/usuario.dart';
import '../home_screen/aprende_screen.dart';
import '../home_screen/pantalla_home.dart';
import '../video_screen/pantalla_video.dart';
import 'pantalla_pregunta.dart';
import 'pregunta_tipo_completar.dart';
import 'pregunta_tipo_ordernar.dart';
import 'pregunta_tipo_seleccionar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_ejercicio/bloc.dart';
import 'pregunta_tipo_seleccionarAlt.dart';
import 'pregunta_tipo_seleccionarAud.dart';
class PreguntaScreen extends StatefulWidget {
  final Habilidad habilidad;
  final Aprende aprende;
  final Leccion leccion;
  const PreguntaScreen({ required this.aprende,required this.leccion, required this.habilidad});


  @override
  State<PreguntaScreen> createState() => _PreguntaState();
}

class _PreguntaState extends State<PreguntaScreen> {

  late int color;
  @override
  void initState() {
    
    color=widget.habilidad.color==0 ? widget.aprende.color:widget.habilidad.color;
 
    super.initState();
  }
  Leccion get leccion => widget.leccion;

  String _numero(Map<String,String> alternativas, String aBuscar){
    String res='';
    int contador=1;
    alternativas.forEach((key, value) { 
      if(value==aBuscar){
        print("KEYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"+contador.toString());
        res=contador.toString();
      }
      contador++;
    });
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: siguienteWid(color:color),
     
     
      body: SafeArea(
  
        child: Column(
          children: [
          
            BlocBuilder<EjercicioBloc, EjercicioState>(
              builder: (context, state) {
              final progreso =state.ejercicio !=null ? state.ejercicio!.numeroOrden[0]:1;
              final total =state.ejercicio !=null ? state.ejercicio!.numeroOrden[1]:1;
              final pre="$progreso de $total";
              final tt=total !=0 ? (progreso/total):0;
                return Column(
                  children: [
                    barra_superior(numeroOrden: pre,esVideo: leccion.es_video,tipo: leccion.alcance,),                 
                    barra_ejercicio(tt: tt,color:color),
                  ],
                );
                                    

              },
            ),
            BlocConsumer<EjercicioBloc, EjercicioState>(
              listener: (context,state){
                if (state.isFail) {
                ScaffoldMessenger.of(context)
                // ignore: deprecated_member_use
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                        SnackBar(
                          content: Container(
                            height: 170,
                          
                            decoration: BoxDecoration(
                              color: Color(color).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '¡Incorrecto!',
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  'Respuesta correcta',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  state.ejercicio!.tipo=='seleccionar' ? "Imagen ${_numero(state.ejercicio!.alternativas,state.ejercicio!.respuesta)}":"${state.ejercicio!.respuesta}",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0, // Establece la elevación a 0 para eliminar la sombra
                        ),

                  );
              }
              if (state.isSuccess) {
                        ScaffoldMessenger.of(context)
                // ignore: deprecated_member_use
                  ..hideCurrentSnackBar()
                // ignore: deprecated_member_use
                  ..showSnackBar(SnackBar(
                                           
                    elevation: 0, 
                    content: Container(
                      height: 100,
                      decoration: BoxDecoration(
                              color: Color(color).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                      child: Center(child: Text('¡Correcto!',style: TextStyle(
                        fontSize: 25
                      ),)),
                    ),
                    backgroundColor:    
                    Colors.transparent,
                  ));
              }
              if(state.isLoad){
                BlocProvider.of<TiempoBloc>(context).add(StartTimer());
                //BlocProvider.of<YoutubePlayerBloc>(context).add(iniciarVideo(leccion: state.leccion!));
                //add(iniciarVideo(leccion: leccion)
              }
              if(state.isResume){
                if(state.resume!.tipo.isNotEmpty){
                  BlocProvider.of<CambiadorBloc>(context).add(agregarResumen(state.resume!));
                  BlocProvider.of<CambiadorBloc>(context).add(cambiarToResumen());

                }
             
              }
            },
            
              builder: (context, state){
     
  

              if(state.isSeleccionar){
                
                 return PreguntaTipoSeleccionar(ejercicio: state.ejercicio!,respueta: state.listaRespuestaOrdenar!,color: color,);
                     
               }else if(state.isOrdenar){
                 return PreguntaTipoOrdenar(ejercicio: state.ejercicio!,respueta: state.listaRespuestaOrdenar!,habilidad: widget.habilidad,);
                
               }else if(state.isCompletar){
                return PreguntaTipoCompletar(ejercicio: state.ejercicio!,respueta: state.listaRespuestaOrdenar!,habilidad: widget.habilidad,);
                  
               }else if(state.isSeleccionarAlt){
                return PreguntaTipoSeleccionarAlt(ejercicio: state.ejercicio!,respueta: state.listaRespuestaOrdenar!,color: color,);
                  
               }else if(state.isAudio){
                  return PreguntaTipoSeleccionarAut(ejercicio: state.ejercicio!,respueta: state.listaRespuestaOrdenar!);
                    
               }else if(state.isResume){
                return Container();
               }
               return Container(
               );
              }),
              
          ],
        ),
      ),
  );
  }
  
  }

class leccion_pregunta extends StatelessWidget {
  const leccion_pregunta({
    super.key,
    required this.pre,
    required this.le,
    required YoutubePlayerBloc youtubePlayerBloc,
    required this.ap,
  }) : _youtubePlayerBloc = youtubePlayerBloc;

  final String pre;
  final Leccion le;
  final YoutubePlayerBloc _youtubePlayerBloc;
  final Aprende ap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        barra_superior(numeroOrden: pre,esVideo:le.es_video,tipo: le.alcance,),  

         Container(
            height: MediaQuery.of(context).size.height*0.7,
            child: ListView(
              
              children: 
            [
            BlocBuilder<YoutubePlayerBloc, YoutubePlayerState>(       
                builder: (context, state)  {
                  if(state.isLoad){
                  return Container(
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, 
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          le.nombre,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          le.descripcion,
                          style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Lato',
                              
                              ),
                          textAlign: TextAlign.center, // Alinea el texto al centro
                        ),
                        SizedBox(height: 15,),
                        YoutubePlayerBuilder(
                          
                          player: YoutubePlayer(
                            controller: _youtubePlayerBloc.controller,
                          ),
                          builder: (context, player) {
                            
                            return Container(child: player,);
                          },
                        ),
          
          
          
          
                      ],
                    ),
                  );
          
                }
                return Container();
          
                }
              ),

              BlocBuilder<YoutubePlayerBloc, YoutubePlayerState>(
                builder: (context, state) {
                  if (state.esVolumen) {
                    IconData iconData;
                    if (state.volumen == 0) {
                      iconData = Icons.volume_off; // Icono de silencio si el volumen es 0
                    } else if (state.volumen <= 50) {
                      iconData = Icons.volume_down; // Icono de volumen bajo si el volumen es menor o igual a 50
                    } else {
                      iconData = Icons.volume_up; // Icono de volumen alto si el volumen es mayor a 50
                    }

                    return Row(
                      children: [
                        Icon(iconData), // Icono que cambia según el valor del volumen
                        Expanded(
                          child: Slider(
                            value: state.volumen,
                            onChanged: (re) {
                              BlocProvider.of<YoutubePlayerBloc>(context).add(ChangSound(sound: re));
                            },
                            min: 0,
                            max: 100,
                            divisions: 10,
                            label: state.volumen.toStringAsFixed(1),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),


          
            Padding(
                padding: const EdgeInsets.only(bottom: 20,top: 55),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        //BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio());
                                        // Acción al presionar el botón
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                        minimumSize: Size(MediaQuery.of(context).size.width*0.97, 50), // Tamaño mínimo del botón
                                        primary: Color(ap.color), // Color de fondo
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20), // Bordes curvos
                                        ),
                                      ),
                                      child: Text(
                                        'Resolver ejercicios',
                                        style: TextStyle(fontSize: 18,color: Colors.black),
                                        
                                      ),
                                    ),
                                  ],
                              ),
                )
            ],),
          ),
        //barra_ejercicio(tt: tt),
        //PreguntaTipoSeleccionarAlt(ejercicio: state.ejercicio!,respueta: state.listaRespuestaOrdenar!),
          
      ],
    );
  }
}

class barra_ejercicio extends StatelessWidget {
  final int color;
  const barra_ejercicio({
    super.key,
    required this.tt,
    required this.color
  });

  final num tt;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5), // Ajusta el radio según tus preferencias
        child: LinearProgressIndicator(
          value:tt.toDouble() ,

          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation<Color>(Color(color)),
        ),
      ),
    );
  }
}

class siguienteWid extends StatelessWidget {
  final int color;
  const siguienteWid({
    super.key,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     
       width: MediaQuery.of(context).size.width*0.9,            
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
     
        children: [
          BlocBuilder<EjercicioBloc, EjercicioState>(
            builder: (context, state) {
              return ElevatedButton(
                      onPressed: !state.isFinish ? () {
                        BlocProvider.of<EjercicioBloc>(context).add(comprobarRespuestaPregunta());
                        // Acción al presionar el botón
                      }:null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                        minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                        primary: Color(color), // Color de fondo
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Bordes curvos
                        ),
                      ),
                      child: Text(
                        'Continuar',
                        style: TextStyle(fontSize: 15,color: Colors.black),
                        
                      ),
                    );

            },
          ),

        ],
      ),
                    );
  }
}

class barra_superior extends StatelessWidget {
  final String numeroOrden;
  final bool esVideo;
  final String tipo;
  const barra_superior({
    super.key,
    required this.numeroOrden,
    required this.esVideo,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
               height: 90,
               color: Colors.white,
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                         Container(
                           width: MediaQuery.of(context).size.width*0.2,
                           child: Center(
                             child: InkWell(
                                   onTap: () {
                                    if(tipo=='especial'){
                                      BlocProvider.of<CambiadorBloc>(context).add(backHome());


                                    }else{
                                      if(esVideo){
                                        BlocProvider.of<CambiadorBloc>(context).add(backToCardVideo());
                                      }else{
                                        BlocProvider.of<CambiadorBloc>(context).add(backLeccionesGlobal());
                                      }

                                    }
                                    
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
                           ),
                         ),
                       Container(
                       
                        width: MediaQuery.of(context).size.width*0.65,
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Center(
                               child: Text(
                                 '${numeroOrden}',
                                 style: TextStyle(
                                   fontSize: 17,
                                   fontFamily: 'Lato',
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                       
                                             BlocBuilder<TiempoBloc, TiempoState>(
                              builder: (context, state) {
                                if (state.isCronometroActivo) {
                                  return Container(
                                    width: 90, // Ajusta el ancho según sea necesario
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.access_time), // Icono de reloj
                                        SizedBox(width: 5), // Espacio entre el icono y el texto
                                        Text(
                                          state.tiempoCronometro,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Lato',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Container(
                                  width: 90, // Ajusta el ancho según sea necesario
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.access_time), // Icono de reloj
                                      SizedBox(width: 5), // Espacio entre el icono y el texto
                                      Text(
                                        '00:00',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                                             ),
                           ],
                         ),
                       ),

                     ],
                   ),
                );
  }
}