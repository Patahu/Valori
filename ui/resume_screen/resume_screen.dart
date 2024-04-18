

import 'package:flutter/material.dart';
import 'package:valorix/src/modelos/habilidad.dart';

import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/bloc_ranking/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs_home/bloc_resume/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../../modelos/leccion.dart';
import '../../modelos/resume.dart';
import '../../modelos/usuario.dart';
import '../home_screen/aprende_screen.dart';
import '../home_screen/pantalla_home.dart';
import 'barra_usuario.dart';

class ResumeScreen extends StatefulWidget {
  final int leccion;
  final int color;
  final List<Resume> resumen;
  final String tipo;
  const ResumeScreen({super.key, required this.leccion, 
  required this.color, 
  required this.resumen,
  required this.tipo,
  });

  @override
  State<ResumeScreen> createState() => _ResumeState();
}

class _ResumeState extends State<ResumeScreen> {
  

  @override
  void initState() {

    super.initState();
  }
  
  get color=>widget.color;
  get leccion=>widget.leccion;
  List<Resume> get resumen=>widget.resumen;
  get tipo=>widget.tipo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: 
        BlocBuilder<ResumeBloc, ResumeState>(       
             builder: (context, state)  {
              if(state.isLoad || state.isVideoResume){
                return resultados(color: color, leccion: leccion,resumen: state.resumen, esVideo: state.isVideoResume,);
              }else if(state.isResumeRanking){
                return resultadosRanking(color: color, tipo: tipo,usuario: state.usuario,);
              }
              return Container();

          })
        //resultados(color: color, leccion: leccion,resumen: resumen,),
        ),
      );
    }
  
  }

class resultadosRanking extends StatelessWidget {
  const resultadosRanking({
    super.key,
    required this.color,
    required this.tipo,
    required this.usuario
 
  });

  final int color;
  final String tipo;
  final Usuario usuario;
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(color).withOpacity(.5),
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
                                Icons.star_border,
                                color: Color(color), // Set the icon color to green
                              ),
                              SizedBox(width: 10,),
                            Center(child: Text('Ranking',style: TextStyle(
                              fontSize: 15
                            ),)),
                          ],
                        ),
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
                              height: 80,
                              child: Image(image: AssetImage('lib/icon/parag.png'))),
                            SizedBox(height: 20,),
                            Text('¡Este es tu puesto!',style: TextStyle(
                              fontSize: 21, fontFamily: 'Lato',fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 10,),
                                    Text('Puesto ${usuario.puesto}',style: TextStyle(
                              fontSize: 17,
                               fontFamily: 'Lato',
                               fontWeight: FontWeight.bold
                            ),),

                            //---------------------------------------------------

                            barra_usuario(color: color, index: usuario.puesto, usuario: usuario,),

                            //----------------------------------------------------------

                            Padding(
                                padding: const EdgeInsets.only(bottom: 20,top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        print("RESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
                                        print(tipo);
                                         if(tipo=="aptitud"){
                                          BlocProvider.of<CambiadorBloc>(context).add(backLecciones());

                                        }else if(tipo=="global"){
                                          BlocProvider.of<CambiadorBloc>(context).add(backLeccionesGlobal());

                                        }else if(tipo.isEmpty){
                                          BlocProvider.of<CambiadorBloc>(context).add(cambiarToNotificacion());


                                        }
                                        //BlocProvider.of<CambiadorBloc>(context).add(backLeccionesGlobal());
                                        //BlocProvider.of<ResumeBloc>(context).add((continuarResume()));
                                        // Acción al presionar el botón
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
                                        'Seguir aprendiendo',
                                        style: TextStyle(fontSize: 15,color: Colors.black),
                                        
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                            Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                     BlocProvider.of<CambiadorBloc>(context).add(cambiarToRanking());
                                    // Acción al presionar el botón
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 20), // Espaciado horizontal
                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50), // Tamaño mínimo del botón
                                    primary: Colors.white, // Color de fondo
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20), // Bordes curvos
                                      side: BorderSide(color: Color(color)), // Borde de color azul
                                    ),
                                  ),
                                  child: Text(
                                    'Ver ranking',
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
class resultados extends StatelessWidget {
  const resultados({
    super.key,
    required this.color,
    required this.leccion,
    required this.resumen,
    required this.esVideo
  });

  final int color;
  final int leccion;
  final Resume resumen;
  final bool esVideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(color).withOpacity(.5),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                                  Icon(
                                Icons.check,
                                color: Color(color), // Set the icon color to green
                              ),
                              SizedBox(width: 10,),
                            Center(child: Text('Leccion ${resumen.indexTemporal+1}'
                            ,style: TextStyle(fontSize: 15),
                            )),
                          ],
                        ),
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
                              child: Image(image: AssetImage('lib/icon/idea.png'))),
                            SizedBox(height: 20,),
                            Text('Completada',style: TextStyle(
                              fontSize: 21, fontFamily: 'Lato',fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 10,),
                                    Text('${resumen.pcorrectas-resumen.pincorrectas} puntos',style: TextStyle(
                              fontSize: 17,
                               fontFamily: 'Lato',fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 60,),
                            //---------------------------------------------------
                            !esVideo ? Column(
                              children: [
                                SizedBox(height: 20,),
                                 Text('${resumen.correctas} correctas ${resumen.pcorrectas} ',style: TextStyle(
                              fontSize: 17, fontFamily: 'Lato',
                            ),),
                                    Text('${resumen.incorrectas} incorrectas ${-resumen.pincorrectas} ',style: TextStyle(
                              fontSize: 17, fontFamily: 'Lato',
                            ),),
                              ],
                            ):Container(),
                            
                                   

                            //----------------------------------------------------------

                            Padding(
                                padding: const EdgeInsets.only(bottom: 20,top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        
                                        BlocProvider.of<ResumeBloc>(context).add((rollResume()));
                                        // Acción al presionar el botón
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
    );
  }
}


