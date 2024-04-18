

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../bloc/blocs_home/bloc_reto/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion/bloc.dart';
import '../../modelos/leccion.dart';
import 'package:image_picker/image_picker.dart';
class retoScreen extends StatelessWidget {
  retoScreen({
    super.key,
    required this.leccion,
    required this.retoBloc,
    required this.fotoFuera,
    required this.color,
    required this.leccionBloc,

  });


  final Leccion leccion;
  final String fotoFuera;
  final TextEditingController pregunta=TextEditingController();
  final RetoBloc retoBloc;
  final LeccionBloc leccionBloc;
  final int color;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RetoBloc,RetoState>(
          bloc: retoBloc,
          builder: (context,state) {
            if(state.success){
              leccionBloc.add(ReiniciarBuscarEspecial());
              return SeRouteReto(color: color,);
            }
            else if(state.esFoto){
                                 return Container(
                          height: MediaQuery.of(context).size.height*.8,
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: ListView(
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
                                      
                                                //dificultad.text='';
                                                //leccionBloc.add(VolverLeccion());
                                                Navigator.pop(context);      
                            
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
                                            '4 de 4',
                                            style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),
                                            
                                          )
                                        ),
                                        
                                      ],
                                              ),
                                              ),
                                        Container(
                          height: 10,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5), // Ajusta el radio según tus preferencias
                            child: LinearProgressIndicator(
                              value: 4/4,
                        
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(color)),
                            ),
                          ),
                                              ),
                                              SizedBox(height: 10,),
                                            Center(
                                                        child: Text(
                                                          'Comparte una foto',
                                                          style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold),
                                                          
                                                        )
                                                      ),
                                                      SizedBox(height: 10,),
                                                          Center(
                                                        child: Text(
                                                          'Envía una foto del reto',
                                                          style: TextStyle(fontSize: 15,color: Colors.black),
                                                          
                                                        )
                                                      ),
                                                       SizedBox(height: 10,),
                                                           MiBotonReto(retoBloc: retoBloc,),    
                                              Container(
                             
                                      width: MediaQuery.of(context).size.width*0.9,            
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    
                                        children: [
                                          ElevatedButton(
                                                      onPressed: retoBloc.imagenReto.isNotEmpty? () {
                                                       retoBloc.add(agregarImagenReto());
                                                       
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
                                                    )
                                        ],
                                      ),
                                                    ),
                                                    
                                      ],
                                    ),
                        );

            }
            else if(state.esAmigos){
            return Column(
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
              
                                              //dificultad.text='';
                                              //leccionBloc.add(VolverLeccion());
                                              Navigator.pop(context);      
                          
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
                                          '3 de 4',
                                          style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),
                                          
                                        )
                                      ),
                                      
                                    ],
                      ),
                      ),
                      Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5), // Ajusta el radio según tus preferencias
                          child: LinearProgressIndicator(
                            value: 3/4,

                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(color)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    Center(
                                                      child: Text(
                                                       '¿Con quiénes completaste el reto?',
                                                        style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold),
                                                        
                                                      )
                                                    ),
                                                    SizedBox(height: 10,),
                                                        Center(
                                                      child: Text(
                                                        'Elige una o varias personas',
                                                        style: TextStyle(fontSize: 15,color: Colors.black),
                                                        
                                                      )
                                                    ),
                                                    SizedBox(height: 10,),
                                                                                          Container(
                                        height: MediaQuery.of(context).size.height*.65,
                                        child: ListView.separated(
                                                        itemCount: state.usuarios.length,
                                                        separatorBuilder: (BuildContext context, int index) {
                                                          return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                        },
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final usuario = state.usuarios[index];
                                                          Color color=Colors.white;
                                                          if(usuario.puesto!=0){
                                                            color=Color(usuario.puesto);
                                                          }
                                                          return ElevatedButton(
                                                          onPressed: () {
                                                            retoBloc.add(ingresarUsuarioRetoParticipo(index));
                                                            //reporteBloc.add(ingresarUsuarioReporteAyudo(index));
                                                            // Acción al hacer clic en el botón
                                                          },
                                                          style: ElevatedButton.styleFrom(
                                                            primary: Colors.transparent,
                                                            elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                                            minimumSize: Size(double.infinity, 80), // Ajusta el tamaño del botón según tus necesidades
                                                            padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(40.0),
                                                            ),
                                                          ),
                                                          child: Stack(
                                                            alignment: AlignmentDirectional.bottomStart,
                                                            children: [
                                      
                                                            Container(
                                                                height: 60,
                                                                decoration: BoxDecoration(
                                                                    color: color.withOpacity(0.5),
                                                                    borderRadius: BorderRadius.circular(40),
                                                                    border: Border.all(
                                                                      color: Colors.grey, // Color del borde
                                                                      width: 2, // Ancho del borde
                                                                    ),
                                                                  ),
                                                  
                                                                child: Container(),
                                                              ),
                                      
                                                              Container(
                                                                height: 60,
                                      
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
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            border: Border.all(
                                                                              color: Color(this.color), // Color del borde
                                                                              width: 1, // Ancho del borde
                                                                            ),
                                                                          ),
                                                                          child: ClipOval(
                                                                            child: Image.network(
                                                                                usuario.imagen, // URL de la imagen
                                                                                fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                              ),
                                                                          ),
                                                                        ),
                                                                        
                                                                            Center(
                                                                              child: Container(
                                                                                  width: 170, // Ancho del contenedor
                                                                                  child: Text(
                                                                                    usuario.nombres,
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
                                      ),
                                                                     
                      Container(
     
                                    width: MediaQuery.of(context).size.width*0.9,            
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                  
                                      children: [
                                        ElevatedButton(
                                                    onPressed: retoBloc.listaAyudo.isNotEmpty ? () {
                                                      //reporteBloc.listaAyudo.isNotEmpty ?
                                                      //reporteBloc.add(continuarReporte(2));
                                                      retoBloc.add(siguienteIngresarFoto());
                                                 
                                                     
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
                                                      style: TextStyle(fontSize: 15,color: Colors.white),
                                                      
                                                    ),
                                                  )
                                      ],
                                    ),
                                                  ),
                                                  
              ],
            );
            }
            else if(state.esPasos){
              return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              Navigator.pop(context); 
                                            //BlocProvider.of<CambiadorBloc>(context).add(backHome());
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
                                        '${leccion.nombre}',
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

                       Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Text(
                           'Pasos',
                           style: TextStyle(
                             fontSize: 21,
                             fontFamily: 'Lato',
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                                    SizedBox(height: 10,),
Container(
                                                    height: MediaQuery.of(context).size.height*.4,
                        
                                                    child: ListView.separated(
                                                      itemCount: leccion.pasos.length,
                                                      separatorBuilder: (BuildContext context, int index) {
                                                        return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                      },
                                                      itemBuilder: (BuildContext context, int index) {
                                                        final pasos = leccion.pasos[index];
                                                        return Container(
                                                          height: 50,
                                                          width: MediaQuery.of(context).size.width*.8,

                                                          child: Column(
                                                         
                                                            children: [
                                                              Row(
                                                               
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                           
                                                                 Padding(
                                                                   padding: const EdgeInsets.only(left:15.0),
                                                                   child: Container(
                                                                      height: 40,
                                                                      width: 30,
                                                                      child: Text(
                                                                        '${index+1}',
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 17,
                                                                          fontFamily: 'Lato',
                                                                          fontWeight: FontWeight.bold
                                                                          
                                                                        ),
                                                                        overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                        maxLines: 1, // Limitar el texto a una sola línea
                                                                      ),
                                                                    ),
                                                                 ),
                                                                
                                                                  Container(
                                                                    height: 40,
                                                                    width: MediaQuery.of(context).size.width*.85,
                                                                    child: Text(
                                                                      pasos,
                                                                      textAlign: TextAlign.start,
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 15,
                                                                        fontFamily: 'Lato',
                                                                        
                                                                        
                                                                      ),
                                                                      overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                      maxLines: 4, // Limitar el texto a una sola línea
                                                                    ),
                                                                  ),

                                                        
                                                                ],
                                                              ),
                                                        
                                
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
                                        SizedBox(height: 50,),
                                                               Padding(
                                                  padding: const EdgeInsets.only(bottom: 20,top: 15),
                                                  child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                              
                                                      onPressed: () {
                                                        retoBloc.add(siguienteRetoAmigos());
                                                       
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                        minimumSize: Size(MediaQuery.of(context).size.width*0.8, 50), // Tamaño mínimo del botón
                                                        primary: Color(color), // Color de fondo
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                        ),
                                                      ),
                                                      child:Text(
                                                        'Continuar',
                                                        style: TextStyle(fontSize: 15,color: Colors.white),
                                                        
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ),
                                                        
                ],
              );
            }
            else if(state.esPrimer){
              return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              Navigator.pop(context); 
                                            //BlocProvider.of<CambiadorBloc>(context).add(backHome());
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
                                        '${leccion.nombre}',
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

                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect( // Utilizar ClipRRect para bordes curvos alrededor de la imagen
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width*0.95,
                                                      height: 450,
                                                      child: Image.network(
                              
                                                        fotoFuera, // URL de la imagen
                                                        fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                      ),
                                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect( // Utilizar ClipRRect para bordes curvos alrededor de la imagen
                                                    borderRadius: BorderRadius.circular(20.0),
                                                    child: Center(
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width*0.9,
                                                        height: 350,
                                                        child: Image.network(
                                                                                  
                                                          leccion.imagen, // URL de la imagen
                                                          fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                        ),
                                                      ),
                                                    ),
                            ),
                          ),
                        ],
                      ),
                       Center(
                                      child: Text(
                                        'Objetivo',
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),

                                     Center(
                                      child: Text(
                                        '${leccion.descripcion}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Lato',
                                     
                                        ),
                                      ),
                                    ),
                                                               Padding(
                                                  padding: const EdgeInsets.only(bottom: 20,top: 15),
                                                  child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                              
                                                      onPressed:  () {
                                                        
                                                        //reporte.listaPractico.values.toList()
                                                        retoBloc.add(siguienteRetoPasos());
                                                        //leccionBloc.add(ContinuarIngresBuDB(abusadores: reporte.listaPractico.values.toList()));
                                                        // Acción al presionar el botón
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                        minimumSize: Size(MediaQuery.of(context).size.width*0.8, 50), // Tamaño mínimo del botón
                                                        primary: Color(color), // Color de fondo
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                        ),
                                                      ),
                                                      child:Text(
                                                        'Continuar',
                                                        style: TextStyle(fontSize: 15,color: Colors.white),
                                                        
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ),
                                                        
                ],
              );

            }
            return Container(

            );
          }
        ),
      ));
      
    }
}


class MiBotonReto extends StatefulWidget {
  final RetoBloc retoBloc;

  const MiBotonReto({super.key, required this.retoBloc});
  @override
  _MiBotonRetoState createState() => _MiBotonRetoState();
}

class _MiBotonRetoState extends State<MiBotonReto> {
  File? imagenSeleccionada;
  late RetoBloc _retoBloc;

  Future<void> seleccionarImagen() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      
      setState(() {
        imagenSeleccionada = File(image.path);
        _retoBloc.add(ingresarFotoReto(image.path));
      });
      
    }
  }
  @override
  void initState() {
  
    _retoBloc=widget.retoBloc;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 15),
      child: Container(
        height: MediaQuery.of(context).size.width*.5+ (imagenSeleccionada !=null?MediaQuery.of(context).size.width*.07:0),
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
                height: MediaQuery.of(context).size.width*.50,
                width: MediaQuery.of(context).size.width*.50,
                child: Image.file(imagenSeleccionada!)),
              
            ),
            SizedBox(height: 5,),
            imagenSeleccionada !=null? Container(
            height: 20,
            child: TextButton( // Use TextButton for transparency
              onPressed: () async {
                imagenSeleccionada = null;
                setState(() {
                  _retoBloc.add(ingresarFotoReto(''));
                });
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



class SeRouteReto extends StatelessWidget {

 

  final int color;
  

  SeRouteReto({super.key,required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(color).withOpacity(.5),
          child: Column(
        
                crossAxisAlignment: CrossAxisAlignment.center,
        
                      children: [
                        SizedBox(height: 80,),
                      Center(
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the icon and text
                            children: [
                              Icon(
                                Icons.check,
                                color: Color(color), // Set the icon color to green
                              ),
                              SizedBox(width: 10), // Add some space between the icon and text
                              Text('Valor',style: TextStyle(
                                fontSize: 15
                              ),),
                            ],
                          ),
                        ),
                      ),
                        SizedBox(height: 50,),
                        Container(
                          width: MediaQuery.of(context).size.width*.8,
                          height: MediaQuery.of(context).size.height*.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10), // Ajusta el valor para cambiar la curvatura de los bordes
                            ),
                            child: Column(
                           
                              children: [
                                  SizedBox(height: 50,),
                                Container(
                                  height: 120,
                                  child: Image(image: AssetImage('lib/icon/idea.png'))),
                                SizedBox(height: 20,),
     
                            
          
          
                                //---------------------------------------------------
          
                                           Text('Reportado',style: TextStyle(
                                            fontWeight:FontWeight.bold,
                                  fontSize: 21, fontFamily: 'Lato',
                                ),),
                                    SizedBox(height: 10,),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding de 10 en ambas direcciones
                                    child: Text(
                                      'Tendrás 10 puntos cuando tu compañero confirme tu práctica',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center, // Centra el texto horizontalmente
                                    ),
                                  ),
                                ),


          
                                       
          
                                //----------------------------------------------------------
          
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 20,top: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            
                                            //leccionBloc.add(VolverLeccion());
                                              
                                              Navigator.pop(context);                                          // Acción al presionar el botón
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                            minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                                            primary: Color(color), // Color de fondo
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            ),
                                          ),
                                          child: Text(
                                            'Seguir aprendiendo ',
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                ),
                              ],
                            ),
                        ),
              
                      ],
                    ),
        ),
      ),
    );
    /*Scaffold(
      backgroundColor: Color(aprende.color).withOpacity(0.9),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );*/
  }
}

