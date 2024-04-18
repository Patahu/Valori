


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/blocs_home/bloc_visor_home/bloc.dart';


import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../habilidad_screen/habilidad_base.dart';
import '../home_screen/home_base.dart';
import '../leccion_screen/pantalla_leccion.dart';
import '../leccion_screen/pantalla_leccion_tipo1.dart';
import '../notificacion_screen/pantalla_notificacion.dart';
import '../perfil_screen/pantalla_perfil.dart';
import '../pregunta_screen/pantalla_pregunta.dart';
import '../pregunta_screen/pregunta_base.dart';
import '../ranking_screen/pantalla_ranking.dart';
import '../reporte_screen/pantalla_reporte.dart';
import '../resume_screen/resume_base.dart';
import '../video_screen/pantalla_video.dart';




class cambiador extends StatefulWidget {
  const cambiador({super.key});

  @override
  State<cambiador> createState() => _CambiadorState();
}

class _CambiadorState extends State<cambiador> {


  @override
  void initState() {
  
    super.initState();
  }
  
 
  List<Widget> body=const [Icon(Icons.home),Icon(Icons.abc),Icon(Icons.person)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    extendBody: true,
    body: BlocBuilder<CambiadorBloc, CambiadorState>(
    builder: (context, state) {
      if (state.es_home) {
        
        return HomeBase();
      }else if(state.es_habilidad){
        return HabilidadBase(aprende:state.aprende!);
      }else if (state.es_leccion){
        final habilidadD=state.habilidad!;
        final aprendeD=state.aprende!;
   
        return LeciconesBase(habilidad: habilidadD,aprende: aprendeD,);
      }else if(state.es_video){
        final habilidadD=state.habilidad!;
        final leccionD=state.leccion!;
        final aprendeD=state.aprende!; 
        
        return videoBase(habilidad: habilidadD,leccion: leccionD,aprende:aprendeD);
      }else if(state.es_perfil){
        return PerfilBase();

      }else if(state.es_ranking){
   
        return RankingBase();
      }else if(state.es_ejercicio && !state.es_resume){
        final leccionD=state.leccion!;
        final habilidadD=state.habilidad!;
        final aprendeD=state.aprende!;
         
        return PreguntaBase(habilidad: habilidadD,leccion: leccionD,aprende:aprendeD);
      }else if(state.es_leccion_global){
        final habilidadD=state.habilidad!;
       
        return LeciconesBaseTipo1(habilidad: habilidadD);
      }else if(state.es_notificacion){

        return NotificacionBase();
      }else if(state.es_resume){
        final color=state.habilidad!.color==0 ? state.aprende!.color:state.habilidad!.color;
        final tipo=state.habilidad!.alcance;
        return ResumeBase(resumen: state.resume!,color: color,tipo: tipo,);
      }else if(state.es_reporte_valor){
        return ReporteBase(tipo: state.tipo_reporte_valor);
      }
      return Container();
    },
  ),
      bottomNavigationBar: 
        BlocConsumer<CambiadorBloc, CambiadorState>(
        listener: (context,state){
          if(!state.es_home && !state.es_ranking && !state.es_perfil && !state.es_ejercicio){
            BlocProvider.of<VisorBloc>(context).add(VisorNinguno());
          }else if(state.es_home){
            BlocProvider.of<VisorBloc>(context).add(VisorHome());
          }else if(state.es_ranking){
            BlocProvider.of<VisorBloc>(context).add(VisorRanking());
          }

          },
         builder: (context, state) {
          if(!state.es_ejercicio){

          
          return Container(
          height: 55,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), // Borde superior izquierdo curvo
              topRight: Radius.circular(20.0), // Borde superior derecho curvo
              bottomLeft: Radius.zero, // Borde inferior izquierdo recto
              bottomRight: Radius.zero, // Borde inferior derecho recto
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<VisorBloc, VisorState>(
                builder: (context, state) {
                  if(state.isHome){
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10), // Elimina el espacio alrededor del contenido del botón
                     
                    ),
                      onPressed: (){
                        
                     
                      
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                              'lib/icon/hogar_1.png',
                              width: 25,
                              height: 25,
                            ),
                            Text(
                              'Inicio',style: TextStyle(
                                fontSize: 14,
                                color: Color(4278245019),
                                fontFamily: 'Lato'
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10), // Elimina el espacio alrededor del contenido del botón
                     
                    ),
                      onPressed: (){
                           BlocProvider.of<VisorBloc>(context).add(VisorHome());
                           BlocProvider.of<CambiadorBloc>(context).add(cambiarToInicio());
                     
                        
                      },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                            'lib/icon/hogar.png',
                            width: 25,
                            height: 25,
                          ),
                          Text(
                            'Inicio',style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 97, 97, 97),
                              fontFamily: 'Lato'
                            ),
                          ),
                      ],
                    ),
                  );
               
              },
              ),
                        BlocBuilder<VisorBloc, VisorState>(
                builder: (context, state) {
                  if(state.isRanking){
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10), // Elimina el espacio alrededor del contenido del botón
                    
                    ),
                      onPressed: (){
                         
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                              'lib/icon/trofeo_1.png',
                              width: 25,
                              height: 25,
                              
                            ),
                            Text(
                              'Ranking',style: TextStyle(
                                fontSize: 14,
                                color: Color(4278245019),
                                fontFamily: 'Lato'
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10), // Elimina el espacio alrededor del contenido del botón
                    
                    ),
                      onPressed: (){
                        BlocProvider.of<VisorBloc>(context).add(VisorRanking());
                                
                
                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToRanking());
                  
                        
                      },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                            'lib/icon/trofeo.png',
                            width: 25,
                            height: 25,
                          ),
                          Text(
                            'Ranking',style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 97, 97, 97),
                              fontFamily: 'Lato'
                            ),
                          ),
                      ],
                    ),
                  );
               
              },
              ),
              BlocBuilder<VisorBloc, VisorState>(
                builder: (context, state) {
                  if(state.isPerfil){
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10), // Elimina el espacio alrededor del contenido del botón
                   
                    ),
                      onPressed: (){
                        
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                              'lib/icon/usuario_1.png',
                              width: 25,
                              height: 25,
                            ),
                            Text(
                              'Perfil',style: TextStyle(
                                fontSize: 14,
                                color: Color(4278245019),
                                fontFamily: 'Lato'
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                      padding: EdgeInsets.only(left: 10, right: 10,top: 10), // Elimina el espacio alrededor del contenido del botón
                   
                    ),
                      onPressed: (){
                        BlocProvider.of<VisorBloc>(context).add(VisorPerfil());
                                   
                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToPerfil());
                        
                      },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                            'lib/icon/usuario.png',
                            width: 25,
                            height: 25,
                          ),
                          Text(
                            'Perfil',style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 97, 97, 97),
                              fontFamily: 'Lato'
                            ),
                          ),
                      ],
                    ),
                  );
               
              },
              ),
            ],
          ),
        );
        }
        return Container(height: 0,width: 0,);
      
      }
    )
      
  );

  }
}


class BarraInferiorI extends StatefulWidget {
  final int currentIndex;

  const BarraInferiorI({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _BarraInferiorRState createState() => _BarraInferiorRState();
}

class _BarraInferiorRState extends State<BarraInferiorI> {
  late int _currentIndex;
  late List<String> _icons;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _icons = [
      'lib/icon/hogar.png',
      'lib/icon/trofeo.png',
      'lib/icon/usuario.png',
    ];
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(

          selectedFontSize:14,
          unselectedFontSize: 11,
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
              _icons = [
                'lib/icon/hogar.png',
                'lib/icon/trofeo.png',
                'lib/icon/usuario.png',

              ]; // Restaura los iconos originales

              // Cambia los iconos según la opción seleccionada
              switch (newIndex) {
                case 0:
               
                  BlocProvider.of<CambiadorBloc>(context).add(cambiarToInicio());
                  break;
                case 1:
            
                  BlocProvider.of<CambiadorBloc>(context).add(cambiarToRanking());
                  break;
                case 2:
            
                  BlocProvider.of<CambiadorBloc>(context).add(cambiarToPerfil());
                  break;
                default:
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: 
                  Image.asset(
                    _icons[0],
                    width: 25,
                    height: 25,
                  ),
               
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _icons[1],
                width: 25,
                height: 25,
              ),
              label: 'Ranking',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _icons[2],
                width: 25,
                height: 25,
              ),
              label: 'Perfil',
            ),
          ],
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}







class BarraInferior extends StatefulWidget {
  final int currentIndex;

  const BarraInferior({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _BarraInferiorState createState() => _BarraInferiorState();
}

class _BarraInferiorState extends State<BarraInferior> {
  late int _currentIndex;
  late List<String> _icons;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _icons = [
      'lib/icon/hogar_1.png',
      'lib/icon/trofeo.png',
      'lib/icon/usuario.png',
    ];
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(

          selectedFontSize:14,
          unselectedFontSize: 11,
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
              _icons = [
                'lib/icon/hogar.png',
                'lib/icon/trofeo.png',
                'lib/icon/usuario.png',

              ]; // Restaura los iconos originales

              // Cambia los iconos según la opción seleccionada
              switch (newIndex) {
                case 0:
                  _icons[newIndex] = 'lib/icon/hogar_1.png';
                  BlocProvider.of<CambiadorBloc>(context).add(cambiarToInicio());
                  break;
                case 1:
                  _icons[newIndex] = 'lib/icon/trofeo_1.png';
                  BlocProvider.of<CambiadorBloc>(context).add(cambiarToRanking());
                  break;
                case 2:
                  _icons[newIndex] = 'lib/icon/usuario_1.png';
                  BlocProvider.of<CambiadorBloc>(context).add(cambiarToPerfil());
                  break;
                default:
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: 
                  Image.asset(
                    _icons[0],
                    width: 25,
                    height: 25,
                  ),
               
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _icons[1],
                width: 25,
                height: 25,
              ),
              label: 'Ranking',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _icons[2],
                width: 25,
                height: 25,
              ),
              label: 'Perfil',
            ),
          ],
          selectedItemColor: Color(4278245019),
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}





