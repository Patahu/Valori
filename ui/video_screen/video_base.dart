




import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_video/bloc.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modelos/habilidad.dart';
import '../../modelos/leccion.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final Habilidad habilidad;
  final Leccion leccion;
  final Aprende aprende;
  const YoutubePlayerScreen({super.key, required this.habilidad, required this.leccion, required this.aprende});
  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerBloc _youtubePlayerBloc;
  late int color;
  @override
  void initState() {
    super.initState();
    _youtubePlayerBloc = BlocProvider.of<YoutubePlayerBloc>(context);
    color=widget.habilidad.color==0 ? widget.aprende.color:widget.habilidad.color;
  }

  @override
  void dispose() {
    
    //_youtubePlayerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                        if(widget.habilidad.alcance=="aptitud"){
                                          BlocProvider.of<CambiadorBloc>(context).add(backLecciones());

                                        }else{
                                          BlocProvider.of<CambiadorBloc>(context).add(backLeccionesGlobal());

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
                                  ],
                                ),
                              Center(
                                child: Text(
                                  widget.habilidad.nombre,
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
                              widget.leccion.nombre,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.leccion.descripcion,
                                style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Lato',
                                     
                                    ),
                                textAlign: TextAlign.center, // Alinea el texto al centro
                              ),
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

                  BlocConsumer<YoutubePlayerBloc, YoutubePlayerState>(
                    listener:(context,state){
                      if(state.isResume){
                        if(state.resume.tipo.isNotEmpty){
                          print("ENTRA UN NUEVO RESUMEN POR ESTE MEDIOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                          BlocProvider.of<CambiadorBloc>(context).add(agregarResumen(state.resume));

                        }
                 
                      }
        
                    },   
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

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(iconData), // Icono que cambia según el valor del volumen
                                Container(
                                  
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
                            ),
                                        
                            Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 55),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: state.isResume ? () {
                                          if (widget.leccion.alcance == 'habilidad' ) {
                                            print("MANDADDOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                                            BlocProvider.of<CambiadorBloc>(context).add(cambiarToResumen());
                                            // Acción cuando isResume es true y alcance es 'habilidad'
                                          } else {
                                            //agregarResumen
                                            //BlocProvider.of<CambiadorBloc>(context).add(agregarResumen(state.resume));
                                            BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(widget.leccion));
                                          }
                                        } : null, // Desactiva el botón si isResume es false
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                          minimumSize: Size(MediaQuery.of(context).size.width * 0.97, 50), // Tamaño mínimo del botón
                                          primary: Color(color), // Color de fondo
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Bordes curvos
                                          ),
                                        ),
                                        child: Text(
                                          widget.leccion.es_pregunta ? 'Resolver ejercicios':'Continuar'  ,
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),


  
                ],),
              )
              
  
              ],
            ),
          ),

        );
  }
}