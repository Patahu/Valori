


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_pregunta_crear/bloc.dart';
import '../../modelos/ejercicio.dart';
import '../../modelos/habilidad.dart';
import '../../modelos/leccion.dart';
import 'barraDropBox.dart';
import 'leccion_base_historias.dart';
import 'mi_boton_mp3.dart';

class crearEjerciciosScreen extends StatelessWidget {
  const crearEjerciciosScreen({
    super.key,
    required this.preguntaLeccionCrearBloc,
    required this.habilidad,
    required this.pregunta,
    required this.leccion,
    required this.alternativa,
    required this.alternativa1,
    required this.alternativa2,
    required this.alternativa3,

  });
    final Leccion leccion;
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;
  final Habilidad habilidad;
  final TextEditingController pregunta;
  final TextEditingController alternativa;
  final TextEditingController alternativa1;
  final TextEditingController alternativa2;
  final TextEditingController alternativa3;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PreguntaLeccionCrearBloc,PreguntaCrearState>(
      listener: (context,state){
        if(state.isLoading){
                  ScaffoldMessenger.of(context)
        // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
        // ignore: deprecated_member_use
          ..showSnackBar(SnackBar(
            
            content: Container(
                 height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Ingresando... '),
                  CircularProgressIndicator(),
                ],
              ),
            ),
            backgroundColor:Color.fromARGB(255, 141, 197, 243).withOpacity(0.1),
          ));
        }
      },
      bloc: preguntaLeccionCrearBloc,
        builder:(context,state){
          if(state.isLoad){
            return Container(
             
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            preguntaLeccionCrearBloc.add(IngresarLeccionToEjercicios(leccion));

                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                            minimumSize: Size(MediaQuery.of(context).size.width * 0.90, 50), // Tamaño mínimo del botón
                            primary: Colors.white, // Color de fondo
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Bordes curvos
                              side: BorderSide(color: Color(habilidad.color)), // Color del borde
                            ),
                          ),
                          child: Text(
                            'Agregar pregunta',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100+(state.ejercicios!.isEmpty?0:state.ejercicios!.length*100),
                    child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.ejercicios!.length,
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(height: 10); // Espacio entre elementos de la lista
                                  },
                                  itemBuilder: (BuildContext context, int index) {
                                    final ejercicio = state.ejercicios![index];
                                    return barra_ejercicio(
                                      ejercicio: ejercicio,
                                      color: habilidad.color,
                                      preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,
                            
                            );
                      },
                    ),
                  ),

                ],
              ),
            );


          }else if(state.isSeleccionarImagen){
            return preguntaSeleccionarImagen(habilidad: habilidad,state: state,pregunta: pregunta, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,);

          }else if(state.isSeleccionarAlt){
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 SizedBox(height: 25,),
                  barraNumeroDePregunta(numero: state.ejercicios!.length,),
                               SizedBox(height: 25,),
                barraDropBox(state: state, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
                                                    Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
               
                              Text(
                                'Pregunta y contexto',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                                   Text(
                                'Pregunta',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                                 
                                ),
                              ),
                               SizedBox(height: 10,),
                     
                              TextField(
                                controller: pregunta,
                                decoration: InputDecoration(
                                  hintText: 'Ingresa la pregunta',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),
                                  SizedBox(height: 25,),
                              Text(
                                'Texto (Opcional)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                                 
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                              TextField(
                                controller: alternativa,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Ingresa el texto',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                              
                            SizedBox(height: 10,),
                              Text(
                                'Imagen (Opcional)',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                                 
                                ),
                              ),

                              MiBoton2(preguntaLeccionCrearBloc: preguntaLeccionCrearBloc, index: 0, isRespuesta: false,),
                               
                              SizedBox(height: 10,),
                                          Text(
                                'Alternativas',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               SizedBox(height: 10,),
                                                                              Text(
                                'Respuesta correcta',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                              TextField(
                                controller: alternativa1,
                                decoration: InputDecoration(
                                  hintText: 'Respuesta correcta',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                                SizedBox(height: 10,),
                                                                              Text(
                                'Alternativa incorrecta',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                          TextField(
                                controller: alternativa2,
                                decoration: InputDecoration(
                                  hintText: 'Alternativa incorrecta',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),
                              SizedBox(height: 10,),
                                                                              Text(
                                'Alternativa incorrecta',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                                                                              TextField(
                                controller: alternativa3,
                                decoration: InputDecoration(
                                  hintText: 'Alternativa incorrecta',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                              Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          preguntaLeccionCrearBloc.add(AgregarPreguntaLeccionSeleccionAlt(
                                            pregunta.text,
                                            alternativa1.text,
                                            alternativa2.text,
                                            alternativa3.text,
                                            alternativa.text,

                                          ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Tamaño mínimo del botón
                                          primary: Colors.white, // Color de fondo
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            side: BorderSide(color: Color(habilidad.color)), // Color del borde
                                          ),
                                        ),
                                        child: Text(
                                          'Agregar',
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                               
                      ],
                    ),
                  ),
                
                ],
              ),
            );

          }
          else if(state.isAudio){
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                                                      SizedBox(height: 25,),
                barraNumeroDePregunta(numero: state.ejercicios!.length,),
                               SizedBox(height: 25,),
                barraDropBox(state: state, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
              Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*SizedBox(height: 25,),
                              Text(
                                'Inicio de la oración',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),*/
                                                  
                          

     
                                          Text(
                                'Pares',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               SizedBox(height: 10,),
                                                                              Text(
                                'Primer audio',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                              MiBotonMP3(index: 0, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
                         
                          SizedBox(height: 10,),
                          TextField(
                                controller: pregunta,
                                decoration: InputDecoration(
                                  hintText: 'Ingrese el par del audio',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                              SizedBox(height: 10,),
                              Text(
                                'Segundo audio',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                              MiBotonMP3(index: 1, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
                                      
                          SizedBox(height: 10,),
            
                          TextField(
                                controller: alternativa,
                                decoration: InputDecoration(
                                  hintText: 'Ingrese el par del audio',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),
                              SizedBox(height: 10,),
                                                                              Text(
                                'Tercer audio',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),

                              MiBotonMP3(index: 2, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
           
                          SizedBox(height: 10,),                   
                         
                          TextField(
                                controller: alternativa1,
                                decoration: InputDecoration(
                                  hintText: 'Ingrese el par del audio',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                                   SizedBox(height: 25,),
                                                                                         Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          
                                          preguntaLeccionCrearBloc.add(AgregarAudios(
                                            'Selecciona los pares',[pregunta.text,alternativa.text,alternativa1.text]
                                          ));
                                          
                                          // Acción al presionar el botón
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Tamaño mínimo del botón
                                          primary: Colors.white, // Color de fondo
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            side: BorderSide(color: Color(habilidad.color)), // Color del borde
                                          ),
                                        ),
                                        child: Text(
                                          'Agregar',
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
      
                      ],
                    ),
                  ),
                ],
              ),
            );

          }
          else if(state.isCompletar){


            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25,),
                  barraNumeroDePregunta(numero: state.ejercicios!.length,),

                               SizedBox(height: 25,),
                barraDropBox(state: state, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
              
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25,),
                              Text(
                                'Inicio de la oración',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                              TextField(
                                controller: pregunta,
                                decoration: InputDecoration(
                                  hintText: 'Ingresa inicio',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),
                              SizedBox(height: 10,),
                                          Text(
                                'Alternativas',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               SizedBox(height: 10,),
                                                                              Text(
                                'Respuesta correcta',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                                                                              TextField(
                                controller: alternativa,
                                decoration: InputDecoration(
                                  hintText: 'Respuesta correcta',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                                SizedBox(height: 10,),
                                                                              Text(
                                'Alternativa incorrecta',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                               TextField(
                                controller: alternativa1,
                                decoration: InputDecoration(
                                  hintText: 'Alternativa incorrecta',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),
                              SizedBox(height: 10,),
                                                                              Text(
                                'Alternativa incorrecta',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Lato',
                            
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                                                                              TextField(
                                controller: alternativa2,
                                decoration: InputDecoration(
                                  hintText: 'Alternativa incorrecta',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                                   SizedBox(height: 25,),
                              Text(
                                'Resto de la oración(Opcional)',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                                  
                              SizedBox(height: 10,),
                              TextField(
                                controller: alternativa3,
                                decoration: InputDecoration(
                                  hintText: 'Resto de la oración',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),

                                                      Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          
                                          preguntaLeccionCrearBloc.add(AgregarPreguntaLeccionOrdenar(
                                            pregunta.text,
                                            alternativa.text,
                                            alternativa1.text,
                                            alternativa2.text,
                                            alternativa3.text,



                                            ));
                                          
                                          // Acción al presionar el botón
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Tamaño mínimo del botón
                                          primary: Colors.white, // Color de fondo
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            side: BorderSide(color: Color(habilidad.color)), // Color del borde
                                          ),
                                        ),
                                        child: Text(
                                          'Agregar',
                                          style: TextStyle(fontSize: 15, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                      ],
                    ),
                  ),
                ],
              ),
              
            );
          }
          else if(state.isOrdenar){

            return Container(
              child: Column(
                     
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(height: 25,),
              barraNumeroDePregunta(numero: state.ejercicios!.length,),


 
                  SizedBox(height: 25,),
                
                  barraDropBox(state: state, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
                
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inicio de la oración',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10,),
                        TextField(
                          controller: pregunta,
                          decoration: InputDecoration(
                            hintText: 'Ingresa inicio',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                        ),
                        SizedBox(height: 10,),
                                    Text(
                          'Resto de la oración',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        state.isIngresarAlternativaOrdenar ?
                        Column(
                          children: [
                            TextField(
                              controller: alternativa,
                              decoration: InputDecoration(
                                hintText: 'Ingresa alternativa',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                            ),
                                                    Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          preguntaLeccionCrearBloc.add(IngresarAlternativa(pregunta.text,alternativa.text,false));
                                          //BlocProvider.of<PreguntaLeccionCrearBloc>(context).add(CrearPreguntaSeleccionarImagen());
                            
                                          // Acción al presionar el botón
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                          minimumSize: Size(50, 50), // Tamaño mínimo del botón
                                          primary: Colors.white, // Color de fondo
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            
                                          ),
                                        ),
                                        child: Text(
                                          'Agregar',
                                          style: TextStyle(fontSize: 15, color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ):
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.98,
                              height: 50,
                              child: Wrap(
                                          spacing: 5,
                              runSpacing: 5,
                                  alignment: WrapAlignment.center,
                            
                              children: _buildBotonesCuadradosRespuesta(context, state.listaRespuestaOrdenar!),
                                      ),
                            ),
                                          SizedBox(height: 10,),
                        Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          alternativa.text='';
                                          preguntaLeccionCrearBloc.add(IngresarAlternativaOrdenar());
                                          //BlocProvider.of<PreguntaLeccionCrearBloc>(context).add(CrearPreguntaSeleccionarImagen());
                            
                                          // Acción al presionar el botón
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                          minimumSize: Size(50, 50), // Tamaño mínimo del botón
                                          primary: Colors.white, // Color de fondo
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            
                                          ),
                                        ),
                                        child: Text(
                                          'Agregar palabra',
                                          style: TextStyle(fontSize: 15, color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ],
                        ),


          

                        Padding(
                                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          preguntaLeccionCrearBloc.add(AgregarPreguntaLeccionDB(pregunta.text));
                            
                                          // Acción al presionar el botón
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Tamaño mínimo del botón
                                          primary: Colors.white, // Color de fondo
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            side: BorderSide(color: Color(habilidad.color)), // Color del borde
                                          ),
                                        ),
                                        child: Text(
                                          'Agregar',
                                          style: TextStyle(fontSize: 18, color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                )


                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }
        );
  }

  List<Widget> _buildBotonesCuadradosRespuesta(BuildContext context, List<String> respuestas) {
    List<Widget> botones = [];
    int _contador=0;
    for(String value in respuestas){
      botones.add(
          BotonCuadradoPreguntaR(
            texto: value, // Utiliza el key del mapa como texto
            preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,
            index: _contador,
 
          ),
      );

      _contador++;

    }
    /*respuestas.forEach((value) {
            botones.add(
          BotonCuadradoPreguntaR(
            texto: value, // Utiliza el key del mapa como texto
            preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,
            index: _contador,
          ),
        );

    });*/

    return botones;
  }


  
}

class barraNumeroDePregunta extends StatelessWidget {
  final int numero;
  const barraNumeroDePregunta({
    super.key,
    required this.numero
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10 ),
            child: Text(
              'Pregunta ${numero+1}',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold
                
              ),
            ),
          );
  }
}


class BotonCuadradoPreguntaR extends StatelessWidget {
  final String texto;
  final int index;
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;


  const BotonCuadradoPreguntaR({
    Key? key,
    required this.texto,

    required this.index,
    required this.preguntaLeccionCrearBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Color.fromARGB(255, 97, 97, 97), // Color del borde
              width: 2, // Ancho del borde
            ),
          ),
        child: ElevatedButton(
          onPressed:(){
              preguntaLeccionCrearBloc.add(EliminarAlternativaOrdenar(index));

          },
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, // Fondo transparente para que el contenedor controle el color de fondo
              elevation: 0, // Sin sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          child: Text(
            texto,
            style: TextStyle(fontSize: 15,
            color: Color.fromARGB(255, 97, 97, 97),
            ),
            
          ),
        ),
      ),
    );
  }
}



class preguntaSeleccionarImagen extends StatelessWidget {
  preguntaSeleccionarImagen({
    super.key,
    required this.habilidad,
    required this.state,
    required this.pregunta,
    required this.preguntaLeccionCrearBloc,

  });

  final Habilidad habilidad;

  final PreguntaCrearState state;
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;
  final TextEditingController pregunta;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                                    SizedBox(height: 25,),
          barraNumeroDePregunta(numero: state.ejercicios!.length,),

                                                 SizedBox(height: 25,),
          barraDropBox(state: state, preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,),
        
           Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pregunta',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10,),
                TextField(
                  controller: pregunta,
                  decoration: InputDecoration(
                    hintText: 'Ingresa la pregunta',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  style: TextStyle(decoration: TextDecoration.none), // Para desactivar el subrayado del texto
                ),
                SizedBox(height: 10,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Column(
                    
                    children: [
                       Text(
                                'Respuesta correcta',
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                      MiBoton(preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,index: 1,isRespuesta: true,),
                    ],
                  ),
              
                   Column(
                    
                    children: [
                       Text(
                                'Respuesta incorrecta',
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                      MiBoton(preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,index: 2,isRespuesta: false),
                    ],
                  ),
                  ],
                ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Column(
                    
                    children: [
                       Text(
                                'Respuesta incorrecta',
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                      MiBoton(preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,index: 3,isRespuesta: false),
                    ],
                  ),
                
                   Column(
                    
                    children: [
                       Text(
                                'Respuesta incorrecta',
                                style: TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                      MiBoton(preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,index: 4,isRespuesta: false),
                    ],
                  ),
                  ],
                ),

                Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  preguntaLeccionCrearBloc.add(AgregarImagenes(pregunta.text));
                                  //BlocProvider.of<PreguntaLeccionCrearBloc>(context).add(CrearPreguntaSeleccionarImagen());
                    
                                  // Acción al presionar el botón
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Tamaño mínimo del botón
                                  primary: Colors.white, // Color de fondo
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), // Bordes curvos
                                    side: BorderSide(color: Color(habilidad.color)), // Color del borde
                                  ),
                                ),
                                child: Text(
                                  'Agregar',
                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )


              ],
            ),
          ),
        ],
      ),
    );
  }
}


class MiBoton extends StatefulWidget {
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;
  final int index;
  final bool isRespuesta;
  const MiBoton({super.key, required this.preguntaLeccionCrearBloc,required this.index,required this.isRespuesta});
  @override
  _MiBotonState createState() => _MiBotonState();
}

class _MiBotonState extends State<MiBoton> {
  File? imagenSeleccionada;
  late PreguntaLeccionCrearBloc _preguntaLeccionCrearBloc;
  late int _index;
  late bool _isRespuesta;
  Future<void> seleccionarImagen() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      
      setState(() {
        imagenSeleccionada = File(image.path);
        _preguntaLeccionCrearBloc.add(IngresarAlternativa('$_index',image.path,_isRespuesta));
      });
      
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _preguntaLeccionCrearBloc=widget.preguntaLeccionCrearBloc;
    _index=widget.index;
    _isRespuesta=widget.isRespuesta;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 15),
      child: Container(
        height: MediaQuery.of(context).size.width*.4+ (imagenSeleccionada !=null?MediaQuery.of(context).size.width*.07:0),
        width: MediaQuery.of(context).size.width*.4,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await seleccionarImagen();
                // Actualizar el estado del widget para mostrar la imagen seleccionada
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(100, 100),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: imagenSeleccionada == null ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15,),
                  Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Image.asset(
                                'lib/icon/carga_nube.png',
                              ),
                      ),
                    ),
                  ),
                  Text(
                    'Presiona para subir una imagen',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                SizedBox(height: 15,),
                ],
              ):Container(
                height: MediaQuery.of(context).size.width*.35,
                width: MediaQuery.of(context).size.width*.35,
                child: Image.file(imagenSeleccionada!)),
              
            ),
            SizedBox(height: 5,),
            imagenSeleccionada !=null? Container(
            height: 20,
            child: TextButton( // Use TextButton for transparency
              onPressed: () async {
                imagenSeleccionada = null;
                setState(() {});
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(10, 10),
                primary: Colors.transparent, // Transparent background
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
         
              ),
              child: Text('Eliminar foto',style: TextStyle(
                color: Colors.blue,
                  fontFamily: 'Lato',
                fontSize: 15
              ),),
            ),
          )
          :Container(),
          ],
        ),
      ),
    );
  }
}




class MiBoton2 extends StatefulWidget {
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;
  final int index;
  final bool isRespuesta;
  const MiBoton2({super.key, required this.preguntaLeccionCrearBloc,required this.index,required this.isRespuesta});
  @override
  _MiBotonState2 createState() => _MiBotonState2();
}

class _MiBotonState2 extends State<MiBoton2> {
  File? imagenSeleccionada;
  late PreguntaLeccionCrearBloc _preguntaLeccionCrearBloc;
  late int _index;
  late bool _isRespuesta;
  Future<void> seleccionarImagen() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      
      setState(() {
        imagenSeleccionada = File(image.path);
        _preguntaLeccionCrearBloc.add(IngresarAlternativa('$_index',image.path,_isRespuesta));
      });
      
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _preguntaLeccionCrearBloc=widget.preguntaLeccionCrearBloc;
    _index=widget.index;
    _isRespuesta=widget.isRespuesta;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 15),
      child: Container(
        height: MediaQuery.of(context).size.width*.3+ (imagenSeleccionada !=null?MediaQuery.of(context).size.width*.07:0),
        width: MediaQuery.of(context).size.width*.95,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await seleccionarImagen();
                // Actualizar el estado del widget para mostrar la imagen seleccionada
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(100, 100),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: imagenSeleccionada == null ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15,),
                  Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Image.asset(
                                'lib/icon/carga_nube.png',
                              ),
                      ),
                    ),
                  ),
                  Text(
                    'Presiona para subir una imagen',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                SizedBox(height: 15,),
                ],
              ):Container(
                height: MediaQuery.of(context).size.width*.35,
                width: MediaQuery.of(context).size.width*.35,
                child: Image.file(imagenSeleccionada!)),
              
            ),
            SizedBox(height: 5,),
            imagenSeleccionada !=null? Container(
            height: 20,
            child: TextButton( // Use TextButton for transparency
              onPressed: () async {
                imagenSeleccionada = null;
                setState(() {});
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(10, 10),
                primary: Colors.transparent, // Transparent background
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
         
              ),
              child: Text('Eliminar foto',style: TextStyle(
                color: Colors.blue,
                  fontFamily: 'Lato',
                fontSize: 15
              ),),
            ),
          )
          :Container(),
          ],
        ),
      ),
    );
  }
}


class barra_ejercicio extends StatelessWidget {
  final Ejercicio ejercicio;
  final int color;
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;


  const barra_ejercicio({
    Key? key,
    required this.ejercicio,
    required this.color,
    required this.preguntaLeccionCrearBloc

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardHabilidad(aprende));
        //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccionGlobal(habilidad));
        // Acción al hacer clic en el botón
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
        minimumSize: Size(double.infinity, 100), // Ajusta el tamaño del botón según tus necesidades
        padding: EdgeInsets.only(left: 10, right: 10), // Elimina el espacio alrededor del contenido del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width ,
            decoration: BoxDecoration(
              color: Color(color),
              borderRadius: BorderRadius.circular(20.0), // Ajusta el radio según tus preferencias
            ),
            child: Container(),
          ),

          Container(
            height: 120,
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:10,top: 5),
                  child: Container(
                    
                    width: MediaQuery.of(context).size.width*0.15,
                    height: 120,
                                decoration: BoxDecoration(
                              color: Color(color),
                              borderRadius: BorderRadius.circular(20.0), // Ajusta el radio según tus preferencias
                            ),
                   
                    child: Column(
                            
                      children: [
                        ElevatedButton(
                             onPressed: () {                          
                                preguntaLeccionCrearBloc.add(SumarRestarCantidadRepeteciciones(ejercicio.idEjercicio,1));           
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                minimumSize: Size(50, 30), // Tamaño mínimo del botón
                                primary: Colors.white, // Color de fondo
                
                              ),
                              child: Text(
                                    '+',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                         ),
                        ),
                       Text(
                                   '${ejercicio.repeticion}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Lato',
                                       fontWeight: FontWeight.bold,
                                  
                                  ),
                                ),
                        ElevatedButton(
                             onPressed: () {           
                                preguntaLeccionCrearBloc.add(SumarRestarCantidadRepeteciciones(ejercicio.idEjercicio,-1));               
                                                    
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                minimumSize: Size(50, 30), // Tamaño mínimo del botón
                                primary: Colors.white, // Color de fondo
                
                              ),
                              child: Text(
                                    '-',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                         ),
                        ),
                
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  height: 100,
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                 
                      Text(
                                 ejercicio.pregunta,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                maxLines: 1, // Limitar el texto a una sola línea
                              ),
                                      Text(
                        ejercicio.tipo,
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       Padding(
                                      padding: const EdgeInsets.only(bottom: 1, top: 1),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                          
                                              preguntaLeccionCrearBloc.add(EliminarPregunta(ejercicio.idEjercicio));
                                      
                                              
                                              // Acción al presionar el botón
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                              minimumSize: Size(50, 40), // Tamaño mínimo del botón
                                              primary: Colors.white, // Color de fondo
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                side: BorderSide(color: Color(color)), // Color del borde
                                              ),
                                            ),
                                            child: Text(
                                              'Eliminar pregunta',
                                              style: TextStyle(fontSize: 15, color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                    ],
                  ),
                ),
                
          
                               
                /*usuario.esPsicologo
                    ? Column(
                        children: [
                          // Ajusta el espacio entre los botones según sea necesario
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0, // Ajusta el ancho del borde según sea necesario
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                //BlocProvider.of<AprendeBloc>(context).add(ModificarAprende(aprende));
                                // Acciones que deseas realizar cuando se toca el botón de editar
                              },
                              icon: Icon(Icons.edit),
                              iconSize: 30.0,
                              color: Colors.blue,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints.tightFor(
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                          ),
                          // Botón delete
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0, // Ajusta el ancho del borde según sea necesario
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                //BlocProvider.of<AprendeBloc>(context).add(ElimnarAprende(aprende.id));
                                // Acciones que deseas realizar cuando se toca el botón de eliminar
                              },
                              icon: Icon(Icons.delete),
                              iconSize: 30.0,
                              color: Colors.red,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              padding: EdgeInsets.all(0),
                              constraints: BoxConstraints.tightFor(
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),*/
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
