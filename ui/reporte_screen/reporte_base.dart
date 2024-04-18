

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/blocs_home/bloc_ver_reporte_psicologo/bloc.dart';




import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/bloc_portador_imagen/bloc.dart';
import '../../bloc/blocs_home/bloc_reporte/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_pregunta_crear/bloc.dart';
import '../../modelos/habilidad.dart';
import '../../modelos/reporte.dart';
import '../leccion_screen/crearEjerciciosScreen.dart';
import '../leccion_screen/leccion_base_ejercicios.dart';





class ReporteScreen extends StatefulWidget {
  final String tipo;

  const ReporteScreen({super.key, required this.tipo});

  @override
  State<ReporteScreen> createState() => _reporteScreenState();
}

class _reporteScreenState extends State<ReporteScreen> {
  
 
  final TextEditingController titulo = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController imagen= TextEditingController();
  String _imagenFondo='https://firebasestorage.googleapis.com/v0/b/valorixdb.appspot.com/o/ejercicio_imagen%2FfotoPaisaje%2F89d91cc49d6a84010bb6aa81c503e227.jpg?alt=media&token=f74845e7-1bf9-4f2a-b488-8e23df6b8d3e';
 
  String get tipo =>widget.tipo;
 
  late ReporteBloc _reporteBloc;


 
  @override
  void initState() {
    _reporteBloc= BlocProvider.of<ReporteBloc>(context);
    super.initState();
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.white,
  body: SafeArea(
     bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

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
                                        tipo=='valor'?'Reporta un valor ':'Reportar una violencia ',
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
                 /*BlocBuilder<PortadorImagenBloc, PortadorImagenState>(
                  
                      builder: (context,state){
                        if(state.isLoadAll){
                            var randomIndex = Random().nextInt(state.fotosPaisaje.length);
                            _imagenFondo=state.fotosPaisaje[randomIndex];
                            if(imagen.text.isEmpty){
                              var randomIndex2 = Random().nextInt(state.fotosEjercicio.length);
                              imagen.text=state.fotosEjercicio[randomIndex2];

                            }
                            return Container();
                        }
                        return Container();
                      },
                        
                      ),*/
              
                    Container(
                      height: MediaQuery.of(context).size.height*0.76,
                      child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
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
                                                  height: 150,
                                                  child: Image.network(
                                                            
                                                    _imagenFondo, // URL de la imagen
                                                    fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                  ),
                                                ),
                                              ),
                                                  
                                            ],
                                          ),
                                        ),
                                    ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20,top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  crearReporteScreen(reporteBloc: _reporteBloc,tipo: tipo,)),
                                                  );
                                                  _reporteBloc.add(cambiarToAyudoPractico());
                                                  _reporteBloc.add(buscarAmigosReporte());
           

                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.97, 50), // Tamaño mínimo del botón
                                                primary: Color(4278245019), // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                ),
                                              ),
                                              child:Text(
                                                'Reportar',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),                      
                      
                                              Padding(
                                                padding: EdgeInsets.only(left: 10), // Padding de 10 píxeles a la izquierda
                                                child: Text(
                                                  "Mis reportes",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              BlocBuilder<ReporteBloc,ReporteState>(
                                                builder:(context,state){
                                                  if(state.isLoad){
                                                    return Container(
                                                    height: MediaQuery.of(context).size.height*.38,
                        
                                                    child: ListView.separated(
                                                      itemCount: state.reportes.length,
                                                      separatorBuilder: (BuildContext context, int index) {
                                                        return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                      },
                                                      itemBuilder: (BuildContext context, int index) {
                                                        final reporte = state.reportes[index];
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
                                                                            color: Colors.grey, // Color del borde
                                                                            width: 1, // Ancho del borde
                                                                          ),
                                                                        ),
                                                                        child: ClipOval(
                                                                          child: Image.network(
                                                                              reporte.usuario.imagen, // URL de la imagen
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
                                                                                reporte.usuario.nombres,
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
                                                                                convertirListaAString(reporte.listaValor),
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
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

  String convertirListaAString(Map<String,Habilidad> listaValores) {
    String resultado = "";
    listaValores.forEach((key, value) {
       resultado += value.nombre + " ";
    });
    return resultado.trim();
  }


}



class ReporteScreeM extends StatefulWidget {
  final String tipo;

  const ReporteScreeM({super.key, required this.tipo});

  @override
  State<ReporteScreeM> createState() => _reporteScreenStateM();
}

class _reporteScreenStateM extends State<ReporteScreeM> {
  
 
  final TextEditingController titulo = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController imagen= TextEditingController();
 
  String get tipo =>widget.tipo;
 

  late LeccionBloc _leccionBloc;
  late PortadorImagenBloc _portadorImagenBloc;
  late PreguntaLeccionCrearBloc _preguntaLeccionCrearBloc;

 
  @override
  void initState() {
    _portadorImagenBloc = BlocProvider.of<PortadorImagenBloc>(context);
    _preguntaLeccionCrearBloc=BlocProvider.of<PreguntaLeccionCrearBloc>(context);
    _leccionBloc= BlocProvider.of<LeccionBloc>(context);
    super.initState();
  }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.white,
  body: SafeArea(
     bottom: false,
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
                                        'Reportes de violencia ',
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
                      height: MediaQuery.of(context).size.height*0.76,
                      child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                  
                      
                                              
                                              BlocBuilder<ReportePsicologBloc,ReportePsicologState>(
                                                builder:(context,state){
                                                  if(state.esCargadoTodo){
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20,top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                
                                                /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  crearReporteScreen(reporteBloc: _reporteBloc,tipo: tipo,)),
                                                  );*/
                                                  //_reporteBloc.add(cambiarToAyudoPractico());
                                                  //_reporteBloc.add(buscarAmigosReporte());
                                                  BlocProvider.of<ReportePsicologBloc>(context).add(iniciarVistaReportePsicolog());
 

                                                    ///

                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Colors.white, // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), 
                                                  side: BorderSide(color: Color(4293309470)),
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
                                                
                                                /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  crearReporteScreen(reporteBloc: _reporteBloc,tipo: tipo,)),
                                                  );
                                                  _reporteBloc.add(cambiarToAyudoPractico());
                                                  _reporteBloc.add(buscarAmigosReporte());*/
                                                  //iniciarVistaReportePsicologTodo
                                                  //ReportePsicologBloc
                                                  BlocProvider.of<ReportePsicologBloc>(context).add(iniciarVistaReportePsicologTodo());
           

                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Color(4293309470), // Color de fondo
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
                                      Padding(
                                                padding: EdgeInsets.only(left: 20), // Padding de 10 píxeles a la izquierda
                                                child: Text(
                                                  "Reportes",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                                        Container(
                                                        height: MediaQuery.of(context).size.height*.6,
                        
                                                        child: ListView.separated(
                                                          itemCount: state.todosReportes.length,
                                                          separatorBuilder: (BuildContext context, int index) {
                                                            return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                          },
                                                          itemBuilder: (BuildContext context, int index) {
                                                            final reporte = state.todosReportes[index];
                                                            return ElevatedButton(
                                                            onPressed: () {
                                                              //crearEjerciciosReporte
                                                                Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) =>  crearEjerciciosReporte(reporte: reporte,leccionBloc: _leccionBloc,portadorImagenBloc: _portadorImagenBloc,
                                                                preguntaLeccionCrearBloc: _preguntaLeccionCrearBloc,)),
                                                              );
                                                             
                                                              
                                                              
                                                              
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
                                                                  height: 80,

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
                                                                  height: 80,

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                           
                                                                         Container(
                                                                            height: 70,
                                                                            width: 70,
                                                                            decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(
                                                                                color: Colors.grey, // Color del borde
                                                                                width: 1, // Ancho del borde
                                                                              ),
                                                                            ),
                                                                            child: ClipOval(
                                                                              child: Image.network(
                                                                                  reporte.usuario.imagen, // URL de la imagen
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
                                                                                    reporte.usuario.nombres,
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
                                                                                    convertirListaAString(reporte.listaValor),
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
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
                                                                          !reporte.fueVisto ?
                                                                         Container(
                                                                          height: 70,
                                                                           child: Center(
                                                                             child: Container(
                                                                                    height: 15,
                                                                                    width: 15,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                      color: Color(4293309470)
                                                                                    ),
                                                                                  ),
                                                                           ),
                                                                         ):Container(),
                                                                
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
                                                      ],
                                                    );

                                                  }
                                                  if(state.esCargando){
                                                    return Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20,top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                
                                                /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  crearReporteScreen(reporteBloc: _reporteBloc,tipo: tipo,)),
                                                  );*/
                                                  //_reporteBloc.add(cambiarToAyudoPractico());
                                                  //_reporteBloc.add(buscarAmigosReporte());
                                                  BlocProvider.of<ReportePsicologBloc>(context).add(iniciarVistaReportePsicolog());

           

                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Color(4293309470), // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                ),
                                              ),
                                              child:Text(
                                                'Nuevas',
                                                style: TextStyle(fontSize: 15,color: Colors.black),
                                              ),
                                            ),
                                                                                        ElevatedButton(
                                              onPressed: () {
                                                
                                                /*Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) =>  crearReporteScreen(reporteBloc: _reporteBloc,tipo: tipo,)),
                                                  );
                                                  _reporteBloc.add(cambiarToAyudoPractico());
                                                  _reporteBloc.add(buscarAmigosReporte());*/
                                                  //iniciarVistaReportePsicologTodo
                                                  //ReportePsicologBloc
                                                  BlocProvider.of<ReportePsicologBloc>(context).add(iniciarVistaReportePsicologTodo());
           

                                                  
                                               
                
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                minimumSize: Size(MediaQuery.of(context).size.width*0.4, 40), // Tamaño mínimo del botón
                                                primary: Colors.white, // Color de fondo
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                  side: BorderSide(color: Color(4293309470)),
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
                                      Padding(
                                                padding: EdgeInsets.only(left: 20), // Padding de 10 píxeles a la izquierda
                                                child: Text(
                                                  "Reportes",
                                                  
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                                        Container(
                                                        height: MediaQuery.of(context).size.height*.6,
                        
                                                        child: ListView.separated(
                                                          itemCount: state.reportesNuevos.length,
                                                          separatorBuilder: (BuildContext context, int index) {
                                                            return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                          },
                                                          itemBuilder: (BuildContext context, int index) {
                                                            final reporte = state.reportesNuevos[index];
                                                            return ElevatedButton(
                                                            onPressed: () {
                                                              //crearEjerciciosReporte
                                                                Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) =>  crearEjerciciosReporte(reporte: reporte,leccionBloc: _leccionBloc,portadorImagenBloc: _portadorImagenBloc,
                                                                preguntaLeccionCrearBloc: _preguntaLeccionCrearBloc,)),
                                                              );
                                                               BlocProvider.of<ReportePsicologBloc>(context).add(iniciarCambiarVisto(reporte.idReporte));
                                                             
                                                              
                                                              
                                                              
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
                                                                  height: 80,

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
                                                                  height: 80,

                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                           
                                                                         Container(
                                                                            height: 70,
                                                                            width: 70,
                                                                            decoration: BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(
                                                                                color: Colors.grey, // Color del borde
                                                                                width: 1, // Ancho del borde
                                                                              ),
                                                                            ),
                                                                            child: ClipOval(
                                                                              child: Image.network(
                                                                                  reporte.usuario.imagen, // URL de la imagen
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
                                                                                    reporte.usuario.nombres,
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
                                                                                    convertirListaAString(reporte.listaValor),
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
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
                                                                          !reporte.fueVisto ?
                                                                         Container(
                                                                          height: 70,
                                                                           child: Center(
                                                                             child: Container(
                                                                                    height: 15,
                                                                                    width: 15,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                      color: Color(4293309470)
                                                                                    ),
                                                                                  ),
                                                                           ),
                                                                         ):Container(),
                                                                
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

  String convertirListaAString(Map<String,Habilidad> listaValores) {
    String resultado = "";
    listaValores.forEach((key, value) {
       resultado += value.nombre + " ";
    });
    return resultado.trim();
  }


}


class SecondRouteReporte extends StatelessWidget {
  final Habilidad habilidad;
  final String titulo;
  final int index;
  final String tipo;
  final String descripcion;
  final Reporte reporte;
  final LeccionBloc leccionBLoc;
  const SecondRouteReporte({super.key,
  required this.tipo,
  required this.index,
  required this.reporte,
  required this.leccionBLoc
  , required this.habilidad, required this.titulo,required this.descripcion});

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
                                Center(child: Text('Ejercicio')),
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
                                  child: Image(image: AssetImage('lib/icon/fuerte.png'))),
                                SizedBox(height: 20,),
                                Text('Ejercicios enviados',style: TextStyle(
                                  fontWeight:FontWeight.bold,
                                  fontSize: 21, fontFamily: 'Lato',
                                ),),
                                SizedBox(height: 10,),
          
          
                                //---------------------------------------------------
          
                                           Text('Agresores',style: TextStyle(
                                            fontWeight:FontWeight.bold,
                                  fontSize: 17, fontFamily: 'Lato',
                                ),),
                                    SizedBox(height: 10,),
                                    Container(
                                                                            height:30+ reporte.listaPractico.length*50,
                                                                            child: ListView.separated(
                                                                               physics: NeverScrollableScrollPhysics(),
                                                                                                      itemCount: reporte.listaPractico.length,
                                                                                                      separatorBuilder: (BuildContext context, int index) {
                                                                                                        return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                                                                      },
                                                                                                      itemBuilder: (BuildContext context, int index) {
                                                                                                        final liss=reporte.listaPractico.keys.toList();
                                                                                                        final agresor = reporte.listaPractico[liss[index]];
                                                                                                     
                                                                                                        return Padding(
                                                                                                          padding: const EdgeInsets.only(left:10,right: 10),
                                                                                                          child: Stack(
                                                                                                          alignment: AlignmentDirectional.bottomStart,
                                                                                                          children: [
                                                                                                                                                              
                                                                                                          Container(
                                                                                                              height: 50,
                                                                                                              decoration: BoxDecoration(
                                                                                                                  color: Color(0),
                                                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                                                  border: Border.all(
                                                                                                                    color: Colors.grey, // Color del borde
                                                                                                                    width: 2, // Ancho del borde
                                                                                                                  ),
                                                                                                                ),
                                                                                                                                                                          
                                                                                                              child: Container(),
                                                                                                            ),
                                                                                                                                                              
                                                                                                            Container(
                                                                                                              height: 50,
                                                                                                                                                              
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
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          shape: BoxShape.circle,
                                                                                                                          border: Border.all(
                                                                                                                            color: Color(habilidad.color), // Color del borde
                                                                                                                            width: 1, // Ancho del borde
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        child: ClipOval(
                                                                                                                          child: Image.network(
                                                                                                                              agresor!.imagen, // URL de la imagen
                                                                                                                              fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                                                            ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      
                                                                                                                          Center(
                                                                                                                            child: Container(
                                                                                                                                width: 170, // Ancho del contenedor
                                                                                                                                child: Text(
                                                                                                                                  agresor.nombres,
                                                                                                                                  style: TextStyle(
                                                                                                                                    color: Colors.black,
                                                                                                                                    fontSize: 15,
                                                                                                                                    fontFamily: 'Lato',
                                                                                                                                   
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



          
                                       
          
                                //----------------------------------------------------------
          
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 20,top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            leccionBLoc.add(LoadEspecialRerporteEjerciciosOtraVez());

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
                                            'Continuar',
                                            style: TextStyle(fontSize: 15,color: Colors.black),
                                            
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


class crearEjerciciosReporte extends StatelessWidget{
  final Reporte reporte;
  final LeccionBloc leccionBloc;
  final String idLeccionEjercicios='SNSmlsqB0PCN1IUBrNRc';
  final int color=4293309470;

  final TextEditingController titulo =TextEditingController();
  final TextEditingController descripcion =TextEditingController();
  final TextEditingController dificultad =TextEditingController(text: 'Fácil');
  final TextEditingController imagen=TextEditingController();


  final TextEditingController pregunta=TextEditingController();
  final TextEditingController alternativa=TextEditingController();
  final TextEditingController alternativa1=TextEditingController();
  final TextEditingController alternativa2=TextEditingController();
  final TextEditingController alternativa3=TextEditingController();
  final PortadorImagenBloc portadorImagenBloc;
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;
  crearEjerciciosReporte({super.key, required this.reporte, required this.leccionBloc,required this.portadorImagenBloc, required this.preguntaLeccionCrearBloc});

  @override
  Widget build(BuildContext context){

    return Scaffold(
                  body: SafeArea(
                    child: BlocBuilder<LeccionBloc,LeccionState>(
                      bloc: leccionBloc,
                      builder: (context,state) {
                        
                        if(state.success){
                          return SecondRouteReporte(
                            leccionBLoc:leccionBloc,
                            reporte: reporte,
                            index: state.isCrearLeccion ? state.lecciones.length:state.leccion.indexTemporal,
                            habilidad: Habilidad.empty2(),
                            titulo: titulo.text,
                            descripcion: descripcion.text,
                            tipo:state.isCrearLeccion ? 'Creada':'Editada',
                            );
                        } else if(state.isActualizarLeccion || state.isCrearLeccion){
                           if(titulo.text.isEmpty && descripcion.text.isEmpty ){
                            preguntaLeccionCrearBloc.add(InitialLoadEjercicios(state.leccionCM.id));
                                titulo.text=state.leccionCM.nombre;
                                descripcion.text=state.leccionCM.descripcion;
                                dificultad.text=state.leccionCM.dificultad;
                              

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

                                                    if(state.isActualizarLeccion){
                                                      leccionBloc.add(LoadEspecialRerporteEjerciciosOtraVez());
                                                    }else if(state.isCrearLeccion){
                                                      leccionBloc.add(LoadEspecialRerporteEjercicios());
                                                    }
                                                   
                                                          
                                                            //Navigator.pop(context);      
                                        
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
                                                        'Crear nuevo ejercicio',
                                                        style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold),
                                                        
                                                      ):Text(
                                                        'Editar ejercicio',
                                                        style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold),
                                                        
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
                                                
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                TextField(
                                                  controller: titulo,
                                                  decoration: InputDecoration(
                                                    hintText: 'Ingresa el título',
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
                                              ],
                                            ),
                                          ),

                                            
                                          Padding(
                                            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Dificultad',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontFamily: 'Lato',
                                              
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                DropdownButtonFormField(
                                                  value: dificultad.text,
                                                  decoration: InputDecoration(
                                                
                                                    labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                  ),
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: 'Fácil',
                                                      child: Text('Fácil',style: TextStyle(color: Colors.grey,fontSize: 15,
                                                    fontFamily: 'Lato',
                                                      
                                                      ),),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: 'Medio',
                                                      child: Text('Medio',style: TextStyle(color: Colors.grey,fontSize: 15,
                                                    fontFamily: 'Lato',
                                                      ),),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: 'Difícil',
                                                      child: Text('Difícil',style: TextStyle(color: Colors.grey,fontSize: 15,
                                                    fontFamily: 'Lato',
                                                      ),),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: 'Avanzado',
                                                      child: Text('Avanzado',style: TextStyle(color: Colors.grey,fontSize: 15,
                                                    fontFamily: 'Lato',
                                                      ),),
                                                    ),

                                                  ],
                                                  onChanged: (value) {
                                                    
                                                    leccionBloc.add(IngresarDificutaldLeccion( dificultad: value!));
                                                    //homeBloc.tipo.text = value!;
                                                    //homeBloc.add(TextChangedEvent(value));
                                                    //cambiarTipoPregunta

                                                  },
                                                )
                              
                                              ],
                                            ),
                                          ),
                              
                                                              
                                                          
                                          
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

                                          

                                          personajeTipo2(portadorImagenBloc: portadorImagenBloc, leccionBloc: leccionBloc, habilidad: Habilidad.empty2()),

                                                        SizedBox(height: 25,),
                                                        Text(
                                                                'Preguntas de ejercicio',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  fontSize: 21,
                                                                  fontFamily: 'Lato',
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              
                                                        SizedBox(height: 15,),
                                                              Text(
                                                                
                                                                'Añade preguntas para el ejercicio.',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontFamily: 'Lato',
                                                                  
                                                                ),
                                                              ),
                                                      SizedBox(height: 25,),

                                                
                                                crearEjerciciosScreen(preguntaLeccionCrearBloc: preguntaLeccionCrearBloc,
                                                habilidad: Habilidad.empty2(),
                                                  pregunta: pregunta,
                                                  leccion:state.leccionCM,
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
                              
                                                      onPressed: () {
                                                        
                                                        //reporte.listaPractico.values.toList()
                                                        leccionBloc.add(ContinuarIngresBuDB(abusadores: reporte.listaPractico.values.toList()));
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
                                                        style: TextStyle(fontSize: 15,color: Colors.black),
                                                        
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

                                                    //dificultad.text='';
                                                    if(state.isActualizarLeccion){
                                                      leccionBloc.add(LoadEspecialRerporteEjerciciosOtraVez());
                                                    }else if(state.isCrearLeccion){
                                                      leccionBloc.add(LoadEspecialRerporteEjercicios());
                                                    }
                                                      //Navigator.pop(context);      

                                                    // Acción al presionar el botón
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50), // Tamaño mínimo del botón
                                                    primary: Colors.white, // Color de fondo
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                      side: BorderSide(color: Color(color)), // Color del borde
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
                        else if(state.isLoadLeccion){
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
                                                    leccionBloc.add(LoadEspecialRerporteEjercicios());
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
                                              child: Text(
                                                'Enviar ejercicio',
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
                      height: MediaQuery.of(context).size.height*0.83,
                      width: MediaQuery.of(context).size.width*0.97,
                      child: ListView(
                                            
                    
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


                                          ],
                                        ),
                                      ),
                                                    
                      
                                              Center(
                                                child: Text(
                                                  "Seleccionar el nivel de ejercicio",
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                        Center(
                                                child: Text(
                                                  "Seleccionar el nivel de ejercicio",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10,),

                                             Container(
                                                height: MediaQuery.of(context).size.height,
                    
                                                child: ListView.separated(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemCount: state.lecciones.length,
                                                  separatorBuilder: (BuildContext context, int index) {
                                                    return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                  },
                                                  itemBuilder: (BuildContext context, int index) {
                                                    final leccion = state.lecciones[index];
                                                    Color coloRR=Colors.white;
                                                    if(state.leccionCM.id==leccion.id){
                                                      coloRR=Color(color).withOpacity(.4);

                                                    }
                                                    return ElevatedButton(
                                                    onPressed: () {
                                                      //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
                                                      
                                                      leccion.indexTemporal=index;
                                                      
                                                      //BlocProvider.of<CambiadorBloc>(context).add(cambiarToEjercicio(leccion));
                                                        titulo.text='';
                                                        descripcion.text='';
                                                        
                                                        leccionBloc.add(IngresarActualizarLeccion(leccion: leccion));
                                                        //leccionBloc.add(ActualizarLeccion(leccion: leccion));
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
                                                          height: 80,

                                                          decoration: BoxDecoration(
                                                            color: coloRR,
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
                                                          height: 80,

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
                                                                    child: Center(child: Text((index+1).toString()
                                                                    ,style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 17,
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
                                                                              fontSize: 15,
                                                                              fontFamily: 'Lato',
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            overflow: TextOverflow.ellipsis, // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                            maxLines: 1, // Limitar el texto a una sola línea
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 10,),
                                                                        Container(
                                                                          width: 170, // Ancho del contenedor
                                                                          child: Text(
                                                                            leccion.dificultad,
                                                                            style: TextStyle(
                                                                              color: Color.fromARGB(255, 97, 97, 97),
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
                                                                           Container(
                                                       
                                                    width: MediaQuery.of(context).size.width*0.9,            
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                  
                                                      children: [
                                                        ElevatedButton(
                                                                    onPressed:  () {
                                                                      //reporteBloc.add(continuarReporte(1));
                                                                         /*Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) =>  crearEjerciciosReporte(reporte: reporte,)),
                                                                );*/

                                                                //reporte.listaAyudo.values.toList()



                                                                      leccionBloc.add(RealiarCopiaBu());
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                                      minimumSize: Size(MediaQuery.of(context).size.width*0.95, 50), // Tamaño mínimo del botón
                                                                      primary: Color(color), // Color de fondo
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      'Asignar preguntas',
                                                                      style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Lato'),
                                                                      
                                                                    ),
                                                                  )
                                                      ],
                                                    ),
                                                                  ),
                                                                  SizedBox(height: 20,),
                                                     Container(
                                                       
                                                    width: MediaQuery.of(context).size.width*0.9,            
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                  
                                                      children: [
                                                        ElevatedButton(
                                                                    onPressed:  () {
                                                                      leccionBloc.add(LoadEspecialRerporteEjercicios());
                                                                     
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                                      minimumSize: Size(MediaQuery.of(context).size.width*0.95, 50), // Tamaño mínimo del botón
                                                                      primary: Colors.white, // Color de fondo
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                                        side: BorderSide(color: Color(color)),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      'Cancelar',
                                                                      style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Lato'),
                                                                      
                                                                    ),
                                                                  )
                                                      ],
                                                    ),
                                                                  ),
                                            ],
                                          ),
                        ),
                        ],
                      );
                        }
                        return Container(
                          child: Column(
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
                                                    'Ver reporte',
                                                    style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),
                                                    
                                                  )
                                                ),
                                                
                                              ],
                                ),
                                ),
                               
                                SizedBox(height: 10,),
                                Container(
                                  height: MediaQuery.of(context).size.height*.8,
                                  child: ListView(
                                    children: [
                                             Center(
                                      
                                        child: Text(
                                          'Reporte de violencia',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold,),
                                          
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,top: 20),
                                        child: Text(
                                          'Reportador',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,),
                                          
                                        ),
                                      ),
                                      ElevatedButton(
                                                                          onPressed: () {
                                                                            //reporteBloc.add(ingresarUsuarioReporteParticipo(index));
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
                                                                                height: 50,
                                                                                decoration: BoxDecoration(
                                                                                    color: Color(0),
                                                                                    borderRadius: BorderRadius.circular(40),
                                                                                    border: Border.all(
                                                                                      color: Colors.grey, // Color del borde
                                                                                      width: 2, // Ancho del borde
                                                                                    ),
                                                                                  ),
                                                                  
                                                                                child: Container(),
                                                                              ),
                                                      
                                                                              Container(
                                                                                height: 50,
                                                      
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
                                                                                          decoration: BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                            border: Border.all(
                                                                                              color: Colors.grey, // Color del borde
                                                                                              width: 1, // Ancho del borde
                                                                                            ),
                                                                                          ),
                                                                                          child: ClipOval(
                                                                                            child: Image.network(
                                                                                                reporte.usuario.imagen, // URL de la imagen
                                                                                                fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                              ),
                                                                                          ),
                                                                                        ),
                                                                                        
                                                                                            Center(
                                                                                              child: Container(
                                                                                                  width: 170, // Ancho del contenedor
                                                                                                  child: Text(
                                                                                                    reporte.usuario.nombres,
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.black,
                                                                                                      fontSize: 15,
                                                                                                      fontFamily: 'Lato',
                                                                                                     
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
                                                                        ),
                                
                                
                                
                                                                 Padding(
                                                                            padding: const EdgeInsets.only(left: 10),
                                                                            child: Text(
                                                                              'Agresor',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,),
                                                                              
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:20+ reporte.listaPractico.length*55,
                                                                            child: ListView.separated(
                                                                               physics: NeverScrollableScrollPhysics(),
                                                                                                      itemCount: reporte.listaPractico.length,
                                                                                                      separatorBuilder: (BuildContext context, int index) {
                                                                                                        return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                                                                      },
                                                                                                      itemBuilder: (BuildContext context, int index) {
                                                                                                        final liss=reporte.listaPractico.keys.toList();
                                                                                                        final agresor = reporte.listaPractico[liss[index]];
                                                                                                     
                                                                                                        return Padding(
                                                                                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                                                                                          child: Stack(
                                                                                                          alignment: AlignmentDirectional.bottomStart,
                                                                                                          children: [
                                                                                                                                                              
                                                                                                          Container(
                                                                                                              height: 50,
                                                                                                              decoration: BoxDecoration(
                                                                                                                  color: Color(0),
                                                                                                                  borderRadius: BorderRadius.circular(40),
                                                                                                                  border: Border.all(
                                                                                                                    color: Colors.grey, // Color del borde
                                                                                                                    width: 2, // Ancho del borde
                                                                                                                  ),
                                                                                                                ),
                                                                                                                                                                          
                                                                                                              child: Container(),
                                                                                                            ),
                                                                                                                                                              
                                                                                                            Container(
                                                                                                              height: 50,
                                                                                                                                                              
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
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          shape: BoxShape.circle,
                                                                                                                          border: Border.all(
                                                                                                                            color: Colors.grey, // Color del borde
                                                                                                                            width: 1, // Ancho del borde
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        child: ClipOval(
                                                                                                                          child: Image.network(
                                                                                                                              agresor!.imagen, // URL de la imagen
                                                                                                                              fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                                                            ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      
                                                                                                                          Center(
                                                                                                                            child: Container(
                                                                                                                                width: 170, // Ancho del contenedor
                                                                                                                                child: Text(
                                                                                                                                  agresor.nombres,
                                                                                                                                  style: TextStyle(
                                                                                                                                    color: Colors.black,
                                                                                                                                    fontSize: 15,
                                                                                                                                    fontFamily: 'Lato',
                                                                                                                                   
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
                                                   
                                                                        Padding(
                                                                            padding: const EdgeInsets.only(left: 10),
                                                                            child: Text(
                                                                              'Víctima',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,),
                                                                              
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:20+ reporte.listaPractico.length*55,
                                                                            child: ListView.separated(
                                                                               physics: NeverScrollableScrollPhysics(),
                                                                                                      itemCount: reporte.listaAyudo.length,
                                                                                                      separatorBuilder: (BuildContext context, int index) {
                                                                                                        return SizedBox(height:5); // Espacio entre elementos de la lista
                                                                                                      },
                                                                                                      itemBuilder: (BuildContext context, int index) {
                                                                                                        final liss=reporte.listaAyudo.keys.toList();
                                                                                                        final victima = reporte.listaAyudo[liss[index]];
                                                                                                     
                                                                                                        return Padding(
                                                                                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                                                                                          child: Stack(
                                                                                                            alignment: AlignmentDirectional.bottomStart,
                                                                                                            children: [
                                                                                                                                                              
                                                                                                            Container(
                                                                                                                height: 50,
                                                                                                                decoration: BoxDecoration(
                                                                                                                    color: Color(0),
                                                                                                                    borderRadius: BorderRadius.circular(40),
                                                                                                                    border: Border.all(
                                                                                                                      color: Colors.grey, // Color del borde
                                                                                                                      width: 2, // Ancho del borde
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                                                                          
                                                                                                                child: Container(),
                                                                                                              ),
                                                                                                                                                              
                                                                                                              Container(
                                                                                                                height: 50,
                                                                                                                                                              
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
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            shape: BoxShape.circle,
                                                                                                                            border: Border.all(
                                                                                                                              color: Colors.grey, // Color del borde
                                                                                                                              width: 1, // Ancho del borde
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          child: ClipOval(
                                                                                                                            child: Image.network(
                                                                                                                                victima!.imagen, // URL de la imagen
                                                                                                                                fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                                                              ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        
                                                                                                                            Center(
                                                                                                                              child: Container(
                                                                                                                                  width: 170, // Ancho del contenedor
                                                                                                                                  child: Text(
                                                                                                                                    victima.nombres,
                                                                                                                                    style: TextStyle(
                                                                                                                                      color: Colors.black,
                                                                                                                                      fontSize: 15,
                                                                                                                                      fontFamily: 'Lato',
                                                                                                                                     
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
                                
                                                                           Padding(
                                                                            padding: const EdgeInsets.only(left: 10),
                                                                            child: Text(
                                                                              'Valores quebrantados',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,),
                                                                              
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            height:20+ reporte.listaValor.length*55,
                                                                            child: ListView.separated(
                                                                              physics:NeverScrollableScrollPhysics(),
                        
                                                                                                      itemCount: reporte.listaValor.length,
                                                                                                      separatorBuilder: (BuildContext context, int index) {
                                                                                                        return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                                                                      },
                                                                                                      itemBuilder: (BuildContext context, int index) {
                                                                                                        final liss=reporte.listaValor.keys.toList();
                                                                                                        final valor = reporte.listaValor[liss[index]];
                                                                                                     
                                                                                                        return Padding(
                                                                                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                                                                                          child: Stack(
                                                                                                            alignment: AlignmentDirectional.bottomStart,
                                                                                                            children: [
                                                                                                                                                              
                                                                                                            Container(
                                                                                                                height: 50,
                                                                                                                decoration: BoxDecoration(
                                                                                                                    color: Color(0),
                                                                                                                    borderRadius: BorderRadius.circular(40),
                                                                                                                    border: Border.all(
                                                                                                                      color: Colors.grey, // Color del borde
                                                                                                                      width: 2, // Ancho del borde
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                                                                          
                                                                                                                child: Container(),
                                                                                                              ),
                                                                                                                                                              
                                                                                                              Container(
                                                                                                                height: 50,
                                                                                                                                                              
                                                                                                                child: Column(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                  children: [
                                                                                                                    Row(
                                                                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                      children: [
                                                                                                                                                                  
                                                                                                                       /*Container(
                                                                                                                          height: 40,
                                                                                                                          width: 40,
                                                                                                                          decoration: BoxDecoration(
                                                                                                                            shape: BoxShape.circle,
                                                                                                                            border: Border.all(
                                                                                                                              color: Colors.grey, // Color del borde
                                                                                                                              width: 1, // Ancho del borde
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                          child: ClipOval(
                                                                                                                            child: Image.network(
                                                                                                                                valor!.nombre, // URL de la imagen
                                                                                                                                fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                                                                              ),
                                                                                                                          ),
                                                                                                                        ),*/
                                                                                                                        
                                                                                                                            Center(
                                                                                                                              child: Container(
                                                                                                                                  width: 170, // Ancho del contenedor
                                                                                                                                  child: Text(
                                                                                                                                    valor!.nombre,
                                                                                                                                    style: TextStyle(
                                                                                                                                      color: Color.fromARGB(255, 97, 97, 97),
                                                                                                                                      fontSize: 15,
                                                                                                                                      fontFamily: 'Lato',
                                                                                                                                     
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
                                                                          SizedBox(height: 10,),
                                                                     Padding(
                                                                            padding: const EdgeInsets.only(left: 10),
                                                                            child: Text(
                                                                              'Detalle de los hechos',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold,),
                                                                              
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                          onPressed: () {
                                                                            //reporteBloc.add(ingresarUsuarioReporteParticipo(index));
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
                                                                                height: 150,
                                                                                decoration: BoxDecoration(
                                                                                    color: Color(0),
                                                                                    borderRadius: BorderRadius.circular(40),
                                                                                    border: Border.all(
                                                                                      color: Colors.grey, // Color del borde
                                                                                      width: 2, // Ancho del borde
                                                                                    ),
                                                                                  ),
                                                                  
                                                                                child: Container(),
                                                                              ),
                                                      
                                                                              Container(
                                                                                height: 150,
                                                      
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(20),
                                                                                              child: Text(
                                                                                                reporte.descripcion,
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(
                                                                                                  color: Color.fromARGB(255, 97, 97, 97),
                                                                                                  fontSize: 15,
                                                                                                  fontFamily: 'Lato',
                                                                                                 
                                                                                                ),
                                                                                                // Mostrar tres puntos "..." si el texto excede el ancho del contenedor
                                                                                                maxLines: 10, // Limitar el texto a una sola línea
                                                                                              ),
                                                                                            ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                      SizedBox(height: 10,),
                                                      
                                      Container(
                                                       
                                                    width: MediaQuery.of(context).size.width*0.9,            
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                  
                                                      children: [
                                                        ElevatedButton(
                                                                    onPressed:  () {
                                                                      //reporteBloc.add(continuarReporte(1));
                                                                         /*Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) =>  crearEjerciciosReporte(reporte: reporte,)),
                                                                );*/
                                                                     leccionBloc.add(BuscarLeccion(idLeccionEjercicios));
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                                      minimumSize: Size(MediaQuery.of(context).size.width*0.95, 50), // Tamaño mínimo del botón
                                                                      primary: Color(4293309470), // Color de fondo
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      'Enviar ejercicio al agresor',
                                                                      style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Lato'),
                                                                      
                                                                    ),
                                                                  )
                                                      ],
                                                    ),
                                                                  ),
                                                                  SizedBox(height: 20,),
                                                     Container(
                                                       
                                                    width: MediaQuery.of(context).size.width*0.9,            
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                  
                                                      children: [
                                                        ElevatedButton(
                                                                    onPressed:  () {
                                                                      leccionBloc.add(CrearLeccionEspecial());
                                                                     
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                                      minimumSize: Size(MediaQuery.of(context).size.width*0.95, 50), // Tamaño mínimo del botón
                                                                      primary: Colors.white, // Color de fondo
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(20), // Bordes curvos
                                                                        side: BorderSide(color: Color(4293309470)),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      'Crear nuevo ejercicio',
                                                                      style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: 'Lato'),
                                                                      
                                                                    ),
                                                                  )
                                                      ],
                                                    ),
                                                                  ),
                                                                  SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                                      ],
                                    ),
                        );
                      }
                    ),
                  ),
                );
  }
}


class crearReporteScreen extends StatelessWidget {
  final ReporteBloc reporteBloc;
  final String tipo;
  crearReporteScreen({super.key,required this.reporteBloc,required this.tipo});
  final TextEditingController descripcion=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
      BlocConsumer<ReporteBloc,ReporteState>(
        listener:(context,state){

        },
        bloc: reporteBloc,
        builder: (context,state){
          print("WTFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"+state.isAyudo.toString());
          if(state.isSuccess){
            return SeRoute();
          }
          else if(state.isDescripcion){
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
                              valueColor: AlwaysStoppedAnimation<Color>(Color(4278245019)),
                            ),
                          ),
                                              ),
                                              SizedBox(height: 10,),
                                            Center(
                                                        child: Text(
                                                          '¿Cómo sucedió?',
                                                          style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold),
                                                          
                                                        )
                                                      ),
                                                      SizedBox(height: 10,),
                                                          Center(
                                                        child: Text(
                                                          'Describe cómo se practicó el valor',
                                                          style: TextStyle(fontSize: 15,color: Colors.black),
                                                          
                                                        )
                                                      ),
                                                       SizedBox(height: 10,),
                                                                            Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        
                              TextField(
                                controller: descripcion,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  hintText: 'Escribe la descripción',
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
                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15), // Para desactivar el subrayado del texto
                              ),
                            ],
                          ),
                                              ),
                                              Container(
                             
                                      width: MediaQuery.of(context).size.width*0.9,            
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    
                                        children: [
                                          ElevatedButton(
                                                      onPressed:  () {
                                                        reporteBloc.add(ingresarReporteDB(descripcion.text));
                                                       
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                        minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                                                        primary: Color(4278245019), // Color de fondo
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
          else if(state.isValor){
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
                            valueColor: AlwaysStoppedAnimation<Color>(Color(4278245019)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    Center(
                                                      child: Text(
                                                        tipo=='valor'?'¿Qué valor se practicó?':'¿Qué tipo de violencia?',
                                                        style: TextStyle(fontSize: 21,color: Colors.black,fontWeight: FontWeight.bold),
                                                        
                                                      )
                                                    ),
                                                    SizedBox(height: 10,),
                                                        Center(
                                                      child: Text(
                                                        tipo=='valor'?'Elige uno o varios valores':'Elige uno o varios negativos',
                                                        style: TextStyle(fontSize: 15,color: Colors.black),
                                                        
                                                      )
                                                    ),
                                                     SizedBox(height: 10,),
                                                            Container(
                                        height: MediaQuery.of(context).size.height*.64,
                                        child: ListView.separated(
                                                        itemCount: state.habilidades.length,
                                                        separatorBuilder: (BuildContext context, int index) {
                                                          return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                        },
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final habilidad = state.habilidades[index];
                                                          return ElevatedButton(
                                                          onPressed: () {
                                                            reporteBloc.add(ingresarQuePractico(index));
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
                                                                    color: Color(habilidad.colorR),
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
                                             
                                                                      /* Container(
                                                                          height: 70,
                                                                          width: 70,
                                                                          decoration: BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            border: Border.all(
                                                                              color: Colors.grey, // Color del borde
                                                                              width: 1, // Ancho del borde
                                                                            ),
                                                                          ),
                                                                          child: ClipOval(
                                                                            child: Image.network(
                                                                                usuario.imagen, // URL de la imagen
                                                                                fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                              ),
                                                                          ),
                                                                        ),*/
                                                                        
                                                                            Center(
                                                                              child: Container(
                                                                                  width: 170, // Ancho del contenedor
                                                                                  child: Text(
                                                                                    habilidad.nombre,
                                                                                    style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: 15,
                                                                                      fontFamily: 'Lato',
                                                                                     
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
                                                    onPressed:  reporteBloc.listaValores.isNotEmpty ? () {
                                                      reporteBloc.add(continuarReporte(3));
                                                     
                                                    }:null,
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                      minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                                                      primary: Color(4278245019), // Color de fondo
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
            );

          }
          else if(state.isAyudo){
            
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
                                          '2 de 4',
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
                            value: 2/4,

                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(4278245019)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    Center(
                                                      child: Text(
                                                        tipo=='valor'?'¿A quién ayudó?':'¿A quién agredio?',
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
                                        height: MediaQuery.of(context).size.height*.64,
                                        child: ListView.separated(
                                                        itemCount: state.usuarios.length,
                                                        separatorBuilder: (BuildContext context, int index) {
                                                          return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                        },
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final usuario = state.usuarios[index];
                                                          return ElevatedButton(
                                                          onPressed: () {
                                                            reporteBloc.add(ingresarUsuarioReporteAyudo(index));
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
                                                                    color: Color(usuario.puesto),
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
                                                                              color: Colors.grey, // Color del borde
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
                                                    onPressed: reporteBloc.listaAyudo.isNotEmpty ? () {
                                                      reporteBloc.add(continuarReporte(2));
                                                 
                                                     
                                                    }:null,
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                      minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                                                      primary: Color(4278245019), // Color de fondo
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
            );

          }
          else if(state.isPractico){
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
                                          '1 de 4',
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
                            value: 1/4,

                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(4278245019)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                                        child: Text(
                                          tipo=='valor'?'¿Quién practicó el valor?':'¿Quién fue el agresor?',
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
                                        height: MediaQuery.of(context).size.height*.64,
                                        child: ListView.separated(
                                                        itemCount: state.usuarios.length,
                                                        separatorBuilder: (BuildContext context, int index) {
                                                          return SizedBox(height: 5); // Espacio entre elementos de la lista
                                                        },
                                                        itemBuilder: (BuildContext context, int index) {
                                                          final usuario = state.usuarios[index];
                                                          return ElevatedButton(
                                                          onPressed: () {
                                                            reporteBloc.add(ingresarUsuarioReporteParticipo(index));
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
                                                                    color: Color(usuario.puesto),
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
                                                                              color: Colors.grey, // Color del borde
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
                                                    onPressed:  reporteBloc.listaPractico.isNotEmpty ? () {
                                                      reporteBloc.add(continuarReporte(1));
                                                     
                                                    }:null,
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                                      minimumSize: Size(MediaQuery.of(context).size.width*0.6, 50), // Tamaño mínimo del botón
                                                      primary: Color(4278245019), // Color de fondo
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
            );
          }
          return Container();
        },
      ),
      ),
    );
  }

}


class SeRoute extends StatelessWidget {

 

 
  

  const SeRoute({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(4278245019).withOpacity(.5),
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
                                color: Color(4278245019), // Set the icon color to green
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
                                  child: Image(image: AssetImage('lib/icon/fresaAlegre.png'))),
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
                                            primary: Color(4278245019), // Color de fondo
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20), // Bordes curvos
                                            ),
                                          ),
                                          child: Text(
                                            'Seguir',
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

