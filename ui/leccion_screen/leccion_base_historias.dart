

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import 'package:valorix/src/bloc/blocs_home/blocs_aprende/bloc_leccion/bloc.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/modelos/leccion.dart';
import 'package:valorix/src/ui/habilidad_screen/crear_habilidades.dart';



import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/bloc_portador_imagen/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_pregunta_crear/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../../modelos/usuario.dart';
import '../home_screen/actua_screen.dart';
import 'barraDropBox.dart';


import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'crearEjerciciosScreen.dart';

class LeccionScreenHistorias extends StatefulWidget {
  final Habilidad habilidad;

  const LeccionScreenHistorias({super.key, required this.habilidad});

  @override
  State<LeccionScreenHistorias> createState() => _leccionState();
}

class _leccionState extends State<LeccionScreenHistorias> {
  
 
  final TextEditingController titulo = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController enlace = TextEditingController();
  final TextEditingController imagen= TextEditingController();
  String _imagenFondo='';
  late LeccionBloc _leccionBloc;
  late PortadorImagenBloc _portadorImagenBloc;
  late PreguntaLeccionCrearBloc _preguntaLeccionCrearBloc;
  Habilidad get habilidad =>widget.habilidad;

 
  @override
  void initState() {
    _leccionBloc = BlocProvider.of<LeccionBloc>(context);
    _portadorImagenBloc = BlocProvider.of<PortadorImagenBloc>(context);
    _preguntaLeccionCrearBloc=BlocProvider.of<PreguntaLeccionCrearBloc>(context);
    super.initState();
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.white,
  body: SafeArea(
     bottom: false,
        child: BlocConsumer<LeccionBloc, LeccionState>(
          listener: (context,state){

            
          },
          builder: (context,state){
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
                                        habilidad.nombre,
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

                                          
                  BlocBuilder<PortadorImagenBloc, PortadorImagenState>(
                  
                      builder: (context,state){
                        if(state.isLoadAll){
                            var randomIndex = Random().nextInt(state.fotosPaisaje.length);
                             
                            _imagenFondo=state.fotosPaisaje[randomIndex];
                            if(imagen.text.isEmpty){
                              var randomIndex2 = Random().nextInt(state.fotosHistoria.length);
                              imagen.text=state.fotosHistoria[randomIndex2];

                            }
                            
                            return Container();
                        }
                        return Container();
                      },
                        
                      ),
              
                    Container(
                      height: MediaQuery.of(context).size.height*0.83,
                      child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is Authenticated) {
                              final stateF = state as Authenticated;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  BlocConsumer<LeccionBloc, LeccionState>(
                                    listener: (context, state){
                              
                                    },
                          
                                    builder: (context,state){
                                      if( state.isLoadLeccion){
                                        final imprimir=state.leccion;
                                        return Container(
                                          width: MediaQuery.of(context).size.width*0.97,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                    
                                            children: [
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
                                            ClipRRect( // Utilizar ClipRRect para bordes curvos alrededor de la imagen
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width*0.95,
                                                height: 100+(stateF.usuario.esPsicologo?50:0),
                                                child: Image.network(
                                                  
                                                  _imagenFondo, // URL de la imagen
                                                  fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                ),
                                              ),
                                            ),
                                            !stateF.usuario.esPsicologo ?
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.97,
                                              height: 50,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  
                                                  Row(
                                                    children: [
                                                      Padding(
                                                    padding: const EdgeInsets.only(left: 20),
                                                    child: Text("${imprimir.index}",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                                                  ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20),
                                                        child: Text("${imprimir.nombre}",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                                                      ),
                                                    ],
                                                  ),
                          
                                                ],
                                              ),
                                            ):Container(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20,top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                if(stateF.usuario.esPsicologo){
                                                  //CrearLeccion
                                                  titulo.text='';
                                                  descripcion.text='';
                                                  enlace.text='';
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  crearLecion1( titulo: titulo,descripcion: descripcion,enlace: enlace,imagen: imagen,
                                                      leccionBloc: _leccionBloc, habilidad: habilidad,portadorImagenBloc: _portadorImagenBloc, preguntaLeccionCrearBloc: _preguntaLeccionCrearBloc,)),
                                                  );
                                              
                                                  BlocProvider.of<LeccionBloc>(context).add(CrearLeccion());


                                                }else{
                                                 //imprimir.indexTemporal=index;
                                                      if(imprimir.es_video){
                                                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardVideo(imprimir));
                                                      }else if(imprimir.es_pregunta){
                                                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(imprimir));
                                                      }
                                                }
                                                // Acción al presionar el botón
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.97, 50), // Tamaño mínimo del botón
                                                primary: Color(habilidad.color), // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                ),
                                              ),
                                              child:stateF.usuario.esPsicologo ? Text(
                                                'Crear nueva lección',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ):imprimir.index > 1 ? Text(
                                                'Continuar',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                                
                                              ):Text(
                                                'Empezar',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),                      
                      
                                              Padding(
                                                padding: EdgeInsets.only(left: 10), // Padding de 10 píxeles a la izquierda
                                                child: Text(
                                                  "Biblioteca",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),


                                                Container(
                                      height: MediaQuery.of(context).size.height*.45,
          
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        childAspectRatio: stateF.usuario.esPsicologo? 0.7:1.2,
                                        children: List.generate(state.lecciones.length, (index) {
                                          final leccion = state.lecciones[index];
                                          return SizedBox(
                                            height: 5,
                                            width: 5,
                                            child: 
                                            
                                            
                                            ElevatedButton(
                                              onPressed: () {
                                                //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
                                                //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardVideo(leccion));
                                                      leccion.indexTemporal=index;
                                                      if(leccion.es_video){
                                                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardVideo(leccion));
                                                      }else if(leccion.es_pregunta){
                                                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(leccion));
                                                      }


                                                // Acción al hacer clic en el botón
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.transparent,
                                                elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                                minimumSize: Size(100, 80), // Ajusta el tamaño del botón según tus necesidades
                                                padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                ),
                                              ),
                                              child: Stack(
                                                alignment: AlignmentDirectional.bottomStart,
                                                children: [

                                                Container(
                                                    height: 160+(stateF.usuario.esPsicologo?60:0),
                                                    width: 170,
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
                                                    height: 160+(stateF.usuario.esPsicologo?60:0),
                                                    width: 170,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                  
                                                      children: [
                                                  
                                                        Container(
                                                          height: 80,
                                                          width: 80,

                                                          child: Image.network(
                                                            leccion.imagen, // URL de la imagen
                                                            fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                          ),
                                                        )
                                                        ,
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Container(
                                                                width: 145, // Ancho del contenedor
                                                                child: Center(
                                                                  child: Text(
                                                                    leccion.nombre,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 15,
                                                                      fontFamily: 'Lato',
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                    overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                    maxLines: 2, // Limitar el texto a una sola línea
                                                                  ),
                                                                ),
                                                              )
                                                  
                                                            ],
                                                          ),
                                                        ),
                                                              stateF.usuario.esPsicologo
                                                                    ? Column(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width: 150.0,
                                                                            height: 40.0,
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                                                              border: Border.all(
                                                                                color: Color(habilidad.color),
                                                                                width: 1.0, // Ajusta el ancho del borde según sea necesario
                                                                              ),
                                                                            ),
                                                                            child: TextButton(
                                                                              onPressed: () {
                                                                                //EliminarLeccion

                                                                                //SecondRouteEliminar
                                                                                leccion.indexTemporal=index;
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) =>  SecondRouteEliminar1(habilidad: habilidad
                                                                                  , leccion: leccion,leccionBLoc: _leccionBloc,
                                                                                  )),
                                                                                );
                                                                               

                                                                                //BlocProvider.of<HabilidadBloc>(context).add(ElimnarHabilidad(habilidad.id));
                                                                                // Acciones que deseas realizar cuando se toca el botón de eliminar
                                                                              },
                                                                              child: Text(
                                                                                'Eliminar',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 15.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 15,),
                                                                          // Ajusta el espacio entre los botones según sea necesario
                                                                          Container(
                                                                            width: 150.0,
                                                                            height: 40.0,
                                                                            decoration: BoxDecoration(
                                                                              color: Color(habilidad.color),
                                                                              borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                                                              border: Border.all(
                                                                                color: Colors.white,
                                                                                width: 1.0, // Ajusta el ancho del borde según sea necesario
                                                                              ),
                                                                            ),
                                                                            child: TextButton(
                                                                              onPressed: () {
                                                                                leccion.indexTemporal=index;
                                                                                titulo.text='';
                                                                                descripcion.text='';
                                                                                enlace.text='';
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) =>  crearLecion1( titulo: titulo,descripcion: descripcion,enlace: enlace,imagen: imagen,
                                                                                    leccionBloc: _leccionBloc, habilidad: habilidad,portadorImagenBloc: _portadorImagenBloc, preguntaLeccionCrearBloc: _preguntaLeccionCrearBloc,)),
                                                                                );
                                                                                BlocProvider.of<LeccionBloc>(context).add(ActualizarLeccion(leccion: leccion));
                                                                                //BlocProvider.of<HabilidadBloc>(context).add(ModificarHabilidad(habilidad));
                                                                                // Acciones que deseas realizar cuando se toca el botón de editar
                                                                              },
                                                                              child: Text(
                                                                                'Editar',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 15.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // Botón delete
                                                                          
                                                                        ],
                                                                      )
                                                                    : Container(),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            ,
                                          );
                                        }),
                                      ),
                                    ),
                                              /*Container(
                                                height: MediaQuery.of(context).size.height*.43,
                    
                                                child: ListView.separated(
                                                  itemCount: state.lecciones!.length,
                                                  separatorBuilder: (BuildContext context, int index) {
                                                    return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                  },
                                                  itemBuilder: (BuildContext context, int index) {
                                                    final leccion = state.lecciones![index];
                                                    return ElevatedButton(
                                                    onPressed: () {
                                                      //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
                                                      
                                                      leccion.indexTemporal=index;
                                                      if(leccion.es_video){
                                                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardVideo(leccion));
                                                      }else if(leccion.es_pregunta){
                                                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(leccion));
                                                      }
                                                      //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardVideo(leccion));
                                                print("---------------------------y");
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
                                                          height: 80+(stateF.usuario.esPsicologo?50:0),

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
                                                          height: 80+(stateF.usuario.esPsicologo?50:0),

                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    child: Center(child: Text(index.toString()
                                                                    ,style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 20,
                                                                              fontFamily: 'Lato',
                                                                              fontWeight: FontWeight.bold,
                                                                            ),    
                                                                    )),
                                                                  ),
                                                                  Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      border: Border.all(
                                                                        color: Colors.grey, // Color del borde
                                                                        width: 1, // Ancho del borde
                                                                      ),
                                                                    ),
                                                                    child: ClipOval(
                                                                      child: Image.network(
                                                                          leccion.imagen, // URL de la imagen
                                                                          fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                        ),
                                                                    ),
                                                                  )
                                                                  ,
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 5),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Container(
                                                                          width: 170, // Ancho del contenedor
                                                                          child: Text(
                                                                            leccion.nombre,
                                                                            style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
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
                                                                            leccion.duracion_video,
                                                                            style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 17,
                                                                              fontFamily: 'Lato',
                                                                            ),
                                                                            overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                            maxLines: 1, // Limitar el texto a una sola línea
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                              height: 50,
                                                                              width: 50,
                                                                            child: determinarIcono(leccion.es_visto,leccion.es_pregunta,leccion.es_echoo),
                                                                      ),
                                                                ],
                                                              ),
                                                              SizedBox(height: 10,),
                                                              stateF.usuario.esPsicologo
                                                                    ? Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width: 150.0,
                                                                            height: 40.0,
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                                                              border: Border.all(
                                                                                color: Color(habilidad.color),
                                                                                width: 1.0, // Ajusta el ancho del borde según sea necesario
                                                                              ),
                                                                            ),
                                                                            child: TextButton(
                                                                              onPressed: () {
                                                                                //EliminarLeccion

                                                                                //SecondRouteEliminar
                                                                                leccion.indexTemporal=index;
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) =>  SecondRouteEliminar1(habilidad: habilidad
                                                                                  , leccion: leccion,leccionBLoc: _leccionBloc,
                                                                                  )),
                                                                                );
                                                                               

                                                                                //BlocProvider.of<HabilidadBloc>(context).add(ElimnarHabilidad(habilidad.id));
                                                                                // Acciones que deseas realizar cuando se toca el botón de eliminar
                                                                              },
                                                                              child: Text(
                                                                                'Eliminar',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(width: 15,),
                                                                          // Ajusta el espacio entre los botones según sea necesario
                                                                          Container(
                                                                            width: 150.0,
                                                                            height: 40.0,
                                                                            decoration: BoxDecoration(
                                                                              color: Color(habilidad.color),
                                                                              borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                                                              border: Border.all(
                                                                                color: Colors.white,
                                                                                width: 1.0, // Ajusta el ancho del borde según sea necesario
                                                                              ),
                                                                            ),
                                                                            child: TextButton(
                                                                              onPressed: () {
                                                                                leccion.indexTemporal=index;
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) =>  crearLecion1( titulo: titulo,descripcion: descripcion,enlace: enlace,imagen: imagen,
                                                                                    leccionBloc: _leccionBloc, habilidad: habilidad,portadorImagenBloc: _portadorImagenBloc,)),
                                                                                );
                                                                                BlocProvider.of<LeccionBloc>(context).add(ActualizarLeccion(leccion: leccion));
                                                                                //BlocProvider.of<HabilidadBloc>(context).add(ModificarHabilidad(habilidad));
                                                                                // Acciones que deseas realizar cuando se toca el botón de editar
                                                                              },
                                                                              child: Text(
                                                                                'Editar',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 16.0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // Botón delete
                                                                          
                                                                        ],
                                                                      )
                                                                    : Container(),
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
                                              ),*/
                                            ],
                                          ),
                                        );
                                      }/*else if(state.isCrearLeccion){
                                  
                                        
                                        return crearaHabilidades(id: widget.habilidad.id,);
                                      }
                                      else if(state.isActualizarLeccion){
                                        return crearaHabilidades(
                                          id: state.leccion!.id,
                                          nombreController:TextEditingController(text: "${state.leccion!.nombre}"),
                                          tipo: "Actualizar",
                                          imagen: state.leccion!.imagen,);
                                      }*/
                            
                                                
                                      return Container();
                                    },
                                  ),
                              
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                    ),
                ],
                    );
          },
        ),
    ),
  );

  }
    Widget determinarIcono(bool es_visto, bool es_pregunta, bool es_echo) {
    if (es_pregunta && es_visto && es_echo) {
      return _buildIconContainer(Icons.replay, Colors.black);
    } else if (es_pregunta && !es_visto && !es_echo) {
      return _buildIconContainer(Icons.play_arrow, Color(habilidad.color));
    } else if (!es_pregunta && es_visto) {
      return _buildIconContainer(Icons.replay, Colors.black);
    } else if (es_echo && !es_visto) {
      return _buildIconContainer(Icons.replay, Colors.black);
    }else {
      return _buildIconContainer(Icons.play_arrow, Color(habilidad.color));
    }
  }

  Widget _buildIconContainer(IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: iconColor), // Color del borde
        shape: BoxShape.circle, // Forma circular del contenedor
      ),
      child: Icon(icon, color: iconColor), // Icono de reproducción
    );
  }

}

class crearLecion1 extends StatelessWidget {
crearLecion1({
    super.key,

    required this.leccionBloc,
    required this.habilidad,
    required this.portadorImagenBloc,
    required this.titulo,
    required this.descripcion,
    required this.enlace,
    required this.imagen,
    required this.preguntaLeccionCrearBloc,
 
  });

  final TextEditingController titulo ;
  final TextEditingController descripcion ;
  final TextEditingController enlace ;
  final TextEditingController imagen;

  final LeccionBloc leccionBloc;
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;
  final TextEditingController pregunta=TextEditingController();
  final TextEditingController alternativa=TextEditingController();
  final TextEditingController alternativa1=TextEditingController();
  final TextEditingController alternativa2=TextEditingController();
  final TextEditingController alternativa3=TextEditingController();
  late PortadorImagenBloc portadorImagenBloc;

  final Habilidad habilidad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LeccionBloc, LeccionState>(
          listener: (context,state){

          },

          bloc: leccionBloc,
          builder: (context,state) {
          

          if(state.success){
            return SecondRoute1(
                index: state.isCrearLeccion ? state.lecciones.length:state.leccionCM.indexTemporal,
              habilidad: habilidad,
              titulo: titulo.text,
              descripcion: descripcion.text,
              tipo:state.isCrearLeccion ? 'Creada':'Editada',
              );
          }
          else if(state.isActualizarLeccion || state.isCrearLeccion){
            preguntaLeccionCrearBloc.add(InitialLoadEjercicios(state.leccionCM.id));
               if(titulo.text.isEmpty && descripcion.text.isEmpty && enlace.text.isEmpty){
                  titulo.text=state.leccionCM.nombre;
                  descripcion.text=state.leccionCM.descripcion;
                  enlace.text=state.leccionCM.video;
                  leccionBloc.add(CargarVideo(enlace: enlace.text));
             
              }
          
              return ListView(
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
                                                'lib/icon/cruz.png', // Ruta de la imagen
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
                                  child: !state.isActualizarLeccion ?Text(
                                    'Crear nueva historia',
                                    style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),
                                    
                                  ):Text(
                                    'Editar historia',
                                    style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),
                                    
                                  ),
                                ),
                              ],
                 ),
                ),
               Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView(
                    children: [
          
                      
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Título',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 97, 97, 97)
                              ),
                            ),
                            TextField(
                              controller: titulo,
                              decoration: InputDecoration(
                                hintText: 'Ingresa el título',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 97, 97, 97),
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 97, 97, 97),
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 97, 97, 97),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                            ),
                          ],
                        ),
                      ),
                     Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Descripción',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 97, 97, 97),
                              ),
                            ),
                            TextField(
                              controller: descripcion,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Escribe la descripción',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 97, 97, 97),
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 97, 97, 97),
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 97, 97, 97),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                            ),
                          ],
                        ),
                      ),
                        
                       Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enlace del vídeo',
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 97, 97, 97)
                              ),
                            ),
         
                            TextField(
                              controller: enlace, // Asigna el controlador al TextField
                              readOnly: true, // Desactiva la interacción con el teclado
                              decoration: InputDecoration(
                                hintText: 'Pega el enlace del vídeo de la lección',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color(habilidad.color),
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
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.paste),
                                  onPressed: pegarEnlace, // Llama a la función para pegar el enlace
                                ),
                              ),
                              style: TextStyle(decoration: TextDecoration.none,fontSize: 11,fontWeight: FontWeight.bold), // Para desactivar el subrayado del texto
                            ),
          
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                                           
                                       
                      
                    /*BlocBuilder<PortadorImagenBloc, PortadorImagenState>(
                      bloc: portadorImagenBloc,
                      builder: (context,state){
                        if(state.isLoadAll){
                            var randomIndex = Random().nextInt(state.fotosPaisaje.length);
                            imagen.text=state.fotosPaisaje[randomIndex];
                            return Container();
                        }
                        return Container();
                      },
                        
                      ),*/
                      SizedBox(height: 10,),

                      BlocBuilder<LeccionBloc, LeccionState>(
                        bloc: leccionBloc,
                        builder: (context,state){
                          if(state.isLoadVideo){
                            return Column(
                                children: [
                                  IgnorePointer(
                                    ignoring: true, // Desactiva la interacción con el widget y sus descendientes
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: Container(
                                        height: 200,
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        child: YoutubePlayerBuilder(
                                          player: YoutubePlayer(
                                            controller: leccionBloc.controller,
                                          ),
                                          builder: (context, player) {
                                            return Container(
                                              child: player,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                      personajeTipo1(portadorImagenBloc: portadorImagenBloc, leccionBloc: leccionBloc, habilidad: habilidad),

                       SizedBox(height: 25,),
                                    Text(
                                            'Preguntas de la historia',
                                            style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          
                                    SizedBox(height: 15,),
                                          Text(
                                            'Añade preguntas para la historia.',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Lato',
                                              color: Color.fromARGB(255, 97, 97, 97)
                                              
                                            ),
                                          ),
                                    SizedBox(height: 25,),
                        crearEjerciciosScreen(preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,
                         habilidad: habilidad,
                          pregunta: pregunta,
                          leccion: state.leccionCM,
                          alternativa: alternativa,
                          alternativa1: alternativa1,
                          alternativa2: alternativa2,
                          alternativa3: alternativa3,
                          ),
                          SizedBox(height: 150,),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20,top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
          
                                  onPressed: state.isCanCreate ?() {
                                    if(state.isActualizarLeccion){
                                             leccionBloc.add(ActualizarLeccionDB(
                                              descripcion: descripcion.text,
                                      titulo: titulo.text,
                                      enlace: enlace.text,
                                      id_aptitud: '',
                                      habilidad: habilidad,
                                      imagen: imagen.text,
                                      ));
          
                                    }else{
                                      leccionBloc.add(IngresarLeccion(descripcion: descripcion.text,
                                      titulo: titulo.text,
                                      enlace: enlace.text,
                                      id_aptitud: '',
                                      habilidad: habilidad,
                                      imagen: imagen.text,
                                      tipo: '2',
                                      ));
          
                                    }
                                
                                    // Acción al presionar el botón
                                  }:null,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                    minimumSize: Size(MediaQuery.of(context).size.width*0.8, 50), // Tamaño mínimo del botón
                                    primary: Color(habilidad.color), // Color de fondo
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20), // Bordes curvos
                                    ),
                                  ),
                                  child: !state.isActualizarLeccion ?Text(
                                    'Crear historia',
                                    style: TextStyle(fontSize: 15,color: Colors.black),
                                    
                                  ):Text(
                                    'Editar historia',
                                    style: TextStyle(fontSize: 15,color: Colors.black),
                                    
                                  ),
                                ),
                              ],
                            ),
                              ),
                                ],
                            );
                          }
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2), // Color de fondo semitransparente
                                    borderRadius: BorderRadius.circular(20.0), // Bordes curvos
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                        Icon(
                                        Icons.play_circle_fill, // Icono de "Play"
                                        size: 60, // Tamaño del icono
                                        color: Colors.black, // Color del icono
                                      ),
                                      Icon(
                                        Icons.not_interested, // Icono de "No es video"
                                        size: 100, // Tamaño del icono
                                        color: Colors.red, // Color del icono
                                      ),
                                    
                                    ],
                                  ),
                                ),
                
                              ),
                              personajeTipo1(portadorImagenBloc: portadorImagenBloc, leccionBloc: leccionBloc, habilidad: habilidad),
                                                   Padding(
                            padding: const EdgeInsets.only(bottom: 20,top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
          
                                  onPressed: state.isCanCreate ?() {
                                    if(state.isActualizarLeccion){
                                             leccionBloc.add(ActualizarLeccionDB(
                                              descripcion: descripcion.text,
                                      titulo: titulo.text,
                                      enlace: enlace.text,
                                      id_aptitud: '',
                                      habilidad: habilidad,
                                      imagen: imagen.text,
                                      ));
          
                                    }else{
                                      leccionBloc.add(IngresarLeccion(descripcion: descripcion.text,
                                      titulo: titulo.text,
                                      enlace: enlace.text,
                                      id_aptitud: '',
                                      habilidad: habilidad,
                                      imagen: imagen.text,
                                      tipo: '2',
                                      ));
          
                                    }
                                
                                    // Acción al presionar el botón
                                  }:null,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                    minimumSize: Size(MediaQuery.of(context).size.width*0.8, 50), // Tamaño mínimo del botón
                                    primary: Color(habilidad.color), // Color de fondo
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20), // Bordes curvos
                                    ),
                                  ),
                                  child: !state.isActualizarLeccion ?Text(
                                    'Crear lección',
                                    style: TextStyle(fontSize: 15,color: Colors.black),
                                    
                                  ):Text(
                                    'Actualizar',
                                    style: TextStyle(fontSize: 15,color: Colors.black),
                                    
                                  ),
                                ),
                              ],
                            ),
                        ),
                            ],
                          );
                        }
                      ),

 
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                titulo.text='';
                                descripcion.text='';
                                enlace.text='';
                                //leccionBloc.add(VolverLeccion());
                                  Navigator.pop(context);      

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
                                'Cancelar',
                                style: TextStyle(fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ],
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
      ),
    );


  }
    void pegarEnlace() async {
    // Obtener el texto del portapapeles
    ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    String? enlacePegado = clipboardData?.text;

    // Verificar si hay texto en el portapapeles antes de pegarlo
    if (enlacePegado != null) {
      // Pegar el texto en el TextField
      enlace.text = enlacePegado;

      // Imprimir el enlace pegado

      leccionBloc.add(CargarVideo(enlace: enlace.text));
      print('Enlace pegado: $enlacePegado');

    }
  }


}

class personajeTipo1 extends StatelessWidget {
  const personajeTipo1({
    super.key,
    required this.portadorImagenBloc,
    required this.leccionBloc,
    required this.habilidad,
  });

  final PortadorImagenBloc portadorImagenBloc;
  final LeccionBloc leccionBloc;
  final Habilidad habilidad;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortadorImagenBloc, PortadorImagenState>(
                          bloc: portadorImagenBloc,
                          builder: (context,state) {
                            if(state.isLoadAll){
                                        return  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5,),
                                            Text(
                                              'Personaje',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontFamily: 'Lato',
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 97, 97, 97)
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                                                height: MediaQuery.of(context).size.height*.55,
                                                                width: MediaQuery.of(context).size.width*0.8,
                                                                child: GridView.count(
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                            crossAxisCount: 4,
                                                                            childAspectRatio: 1.0,
                                                                            children: List.generate(state.fotosHistoria.length, (index) {
                                                                              final leccion = state.fotosHistoria[index];
                                                                              return BlocBuilder<LeccionBloc,LeccionState>(
                                                                                bloc: leccionBloc,
                                                                                builder: (context,state2){
                                                                                  if(state2.leccionCM.imagen==leccion){
                                                                                    return SizedBox(
                                                                                        height: 5,
                                                                                        width: 5,
                                                                                        child: ElevatedButton(
                                                                                            onPressed: () {
                                                                              
                                                                                              leccionBloc.add(IngresarImagenLeccion(imagen:leccion));


                                                                                              // Acción al hacer clic en el botón
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              primary: Colors.transparent,
                                                                                              elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                                                                              minimumSize: Size(100, 80), // Ajusta el tamaño del botón según tus necesidades
                                                                                              padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                              ),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              alignment: AlignmentDirectional.bottomStart,
                                                                                              children: [

                                                                                              Container(
                                                                                                  height: 140,
                                                                                                  width: 170,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                      border: Border.all(
                                                                                                              color: Color(habilidad.color),
                                                                                                              width: 2.0,
                                                                                                            ),
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
                                                                                                  height: 90,
                                                                                                  width: 100,
                                                                                                  child: Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        height: 50,
                                                                                                        width: 50,

                                                                                                        child: Image.network(
                                                                                                          leccion, // URL de la imagen
                                                                                                          fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                                        ),
                                                                                                      )
                                                                                                      

                                                                                      
                                                                                                    ],
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                      );
              
                                                                                  }else{
                                                                                    return SizedBox(
                                                                                        height: 5,
                                                                                        width: 5,
                                                                                        child: ElevatedButton(
                                                                                            onPressed: () {
                                                                                              //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
                                                                                              leccionBloc.add(IngresarImagenLeccion(imagen:leccion));


                                                                                              // Acción al hacer clic en el botón
                                                                                            },
                                                                                            style: ElevatedButton.styleFrom(
                                                                                              primary: Colors.transparent,
                                                                                              elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                                                                              minimumSize: Size(100, 80), // Ajusta el tamaño del botón según tus necesidades
                                                                                              padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                              ),
                                                                                            ),
                                                                                            child: Stack(
                                                                                              alignment: AlignmentDirectional.bottomStart,
                                                                                              children: [

                                                                                              Container(
                                                                                                  height: 140,
                                                                                                  width: 170,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                      border: Border.all(
                                                                                                              color: Colors.white,
                                                                                                              width: 2.0,
                                                                                                            ),
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
                                                                                                  height: 90,
                                                                                                  width: 100,
                                                                                                  child: Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        height: 50,
                                                                                                        width: 50,

                                                                                                        child: Image.network(
                                                                                                          leccion, // URL de la imagen
                                                                                                          fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                                        ),
                                                                                                      )
                                                                                                      

                                                                                      
                                                                                                    ],
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                      );
                                                                                  }
                                                                                  
              
                                                                  }
                                                            );
                                                                  
                                                                              
                                                        }),
                                      ),
                                  ),
                                          ],
                                        );
                            }
                            return Container();
                    
                          }
                        );
  }
}



class SecondRouteEliminar1 extends StatelessWidget {
  final Habilidad habilidad;
  final Leccion leccion;
  final LeccionBloc leccionBLoc;
  const SecondRouteEliminar1({super.key,required this.leccionBLoc,required this.leccion,required this.habilidad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          color: Color(habilidad.color).withOpacity(.5),
          child: Column(
        
                crossAxisAlignment: CrossAxisAlignment.center,
        
                      children: [
                        SizedBox(height: 50,),
                        Center(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10), // Ajusta el valor para cambiar la curvatura de los bordes
                            ),
                            child: Center(child: Text('Leccion ${leccion.indexTemporal+1}',style: TextStyle(
                                  fontSize: 15, fontFamily: 'Lato',
                                ))),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Container(
                          width: MediaQuery.of(context).size.width*.8,
                          height: MediaQuery.of(context).size.height*.7,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10), // Ajusta el valor para cambiar la curvatura de los bordes
                            ),
                            child: Column(
                           
                              children: [
                                  SizedBox(height: 50,),
                                Container(
                                  height: 120,
                                  child: Image(image: AssetImage('lib/icon/rogar.png'))),
                                SizedBox(height: 20,),
                                Text('¿Quieres eliminar una lección?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight:FontWeight.bold,
                                  fontSize: 21, fontFamily: 'Lato',
                                  
                                ),),
                                SizedBox(height: 10,),
          
          
                                //---------------------------------------------------
          
                                           Text('${leccion.nombre} ',style: TextStyle(
                                            fontWeight:FontWeight.bold,
                                  fontSize: 17, fontFamily: 'Lato',
                                ),),
                                    SizedBox(height: 10,),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding de 10 en ambas direcciones
                                    child: Text(
                                      '${leccion.descripcion}',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Lato',
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
                                                       
                                              Navigator.pop(context);       
                                              leccionBLoc.add(EliminarLeccion(leccion: leccion));
                                              //Navigator.pop(context);                                        // Acción al presionar el botón
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                            minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                                            primary: Color(habilidad.color), // Color de fondo
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            ),
                                          ),
                                          child: Text(
                                            'Eliminar elección',
                                            style: TextStyle(fontSize: 15,color: Colors.white),
                                            
                                          ),
                                        ),
                                      ],
                                    ),
                                ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20, top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                 
                                              Navigator.pop(context);      

                                            // Acción al presionar el botón
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                            minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50), // Tamaño mínimo del botón
                                            primary: Colors.white, // Color de fondo
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20), // Bordes curvos
                                              side: BorderSide(color: Color(habilidad.color)), // Color del borde
                                            ),
                                          ),
                                          child: Text(
                                            'Cancelar',
                                            style: TextStyle(fontSize: 15, color: Colors.black),
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

class SecondRoute1 extends StatelessWidget {
  final Habilidad habilidad;
  final String titulo;
  final int index;
  final String tipo;
  final String descripcion;
  const SecondRoute1({super.key,
  required this.tipo,
  required this.index, required this.habilidad, required this.titulo,required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          color: Color(habilidad.color).withOpacity(.5),
          child: Column(
        
                crossAxisAlignment: CrossAxisAlignment.center,
        
                      children: [
                        SizedBox(height: 50,),
                        Center(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10), // Ajusta el valor para cambiar la curvatura de los bordes
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  Icon(
                                Icons.check,
                                color: Color(habilidad.color), // Set the icon color to green
                              ),
                              SizedBox(width: 10,),
                                Center(child: Text('Leccion ${index+1}')),
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
                                Text('$tipo',style: TextStyle(
                                  fontWeight:FontWeight.bold,
                                  fontSize: 21, fontFamily: 'Lato',
                                ),),
                                SizedBox(height: 10,),
          
          
                                //---------------------------------------------------
          
                                           Text('${titulo} ',style: TextStyle(
                                            fontWeight:FontWeight.bold,
                                  fontSize: 17, fontFamily: 'Lato',
                                ),),
                                    SizedBox(height: 10,),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0), // Padding de 10 en ambas direcciones
                                    child: Text(
                                      '$descripcion',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Lato',
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
                                            
                                              Navigator.pop(context);                                        // Acción al presionar el botón
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                            minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                                            primary: Color(habilidad.color), // Color de fondo
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            ),
                                          ),
                                          child: Text(
                                            'Continuar',
                                            style: TextStyle(fontSize: 15,color: Colors.white),
                                            
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






/*
        BlocBuilder<PreguntaLeccionCrearBloc,PreguntaCrearState>(
          builder:(context,state){
            if(state.isSeleccionarImagen){
              return preguntaSeleccionarImagen(habilidad: habilidad,state: state,pregunta: pregunta,);

            }else if(state.isCompletar){

              return Container(
                child: Column(
                  children: [
                      SizedBox(height: 10,),
                    barraDropBox(state: state,),
                  
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10 ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inicio de la oración',
                            style: TextStyle(
                              fontSize: 20,
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
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            style: TextStyle(decoration: TextDecoration.none), // Para desactivar el subrayado del texto
                          ),
                          SizedBox(height: 10,),
                                      Text(
                            'Resto de la oración',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
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
                                            style: TextStyle(fontSize: 15, color: Colors.green),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                          Padding(
                                    padding: const EdgeInsets.only(bottom: 20, top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
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
            return  Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<PreguntaLeccionCrearBloc>(context).add(CrearPreguntaSeleccionarImagen());
    
                  // Acción al presionar el botón
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.97, 50), // Tamaño mínimo del botón
                  primary: Colors.white, // Color de fondo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Bordes curvos
                    side: BorderSide(color: Color(habilidad.color)), // Color del borde
                  ),
                ),
                child: Text(
                  'Agregar pregunta',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ],
          ),
        );
          }
          ),
*/ 