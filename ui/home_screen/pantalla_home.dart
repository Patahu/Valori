
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/blocs_home/bloc_ranking/bloc.dart';
import 'package:valorix/src/bloc/blocs_home/bloc_ver_reporte_psicologo/psicologo_reporte_state.dart';


import '../../bloc/blocs_home/bloc_ver_reporte_psicologo/bloc.dart';
import '../../bloc/blocs_home/bloc_visor_home/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../../modelos/usuario.dart';
import 'actua_screen.dart';
import 'aprende_screen.dart';
import 'crear_aprenderes.dart';
import 'paleta_colores.dart';





class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {

    //BlocProvider.of<LeccionProgresoHabilidadBloc>(context);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.white,
  body: BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      if (state is Authenticated) {
        final stateF = state as Authenticated;
        return SafeArea(
          bottom: false,
          child: Column(
            children: [
                    barra_estado_screen(stateF: stateF),
                        Container(
      width: MediaQuery.of(context).size.width * 0.98,
      height: 2, // Altura de la línea encima del Container principal
      color: Colors.grey.withOpacity(.2), // Color de la línea encima del Container principal
    ),
              Container(
                height: MediaQuery.of(context).size.height*.82,
                child: ListView(
                  children: [
                      
                    SizedBox(height: 5),
                    BlocBuilder<RankingBloc,RankingState>(
                      builder: (context,state){
                        if(state.isLoad){
                            return PodioGanadores(usuarios: state.listaUsuariosRanking);
                        }
                        return Container();
                      }
                      ),
                   
              
                    
                    // BLOC DE APRENDE
                    
               
                Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            child: Text(
                              "Aprende",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                             SizedBox(width: 30,),
                           
                          /*InkWell(
                            onTap: () {
                                //_ver=true;
                                BlocProvider.of<VisorBloc>(context).add(VisorAprende());
                                // Acciones que deseas realizar cuando se toca el botón
                             
                              },
                            child: Center(
                                 child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey, // Color del borde
                                                    width: 1, // Ancho del borde
                                                  ),
                                                ),
                             child:  BlocBuilder<VisorBloc,VisorState>(
                                builder: (context,state){
                                  if(state.isAprende){
                                      return Center(
                                        child: Image.asset(
                                          'lib/icon/down.png', // Ruta de la imagen
                                          width: 15, // Ajusta el tamaño de la imagen según sea necesario
                                          height: 15,
                                  ),
                                );
                                                    }
                                return Center(
                                child: Image.asset(
                                                    'lib/icon/d.png', // Ruta de la imagen
                                                    width: 15, // Ajusta el tamaño de la imagen según sea necesario
                                                    height: 15,
                                                  ),
                                                );
                                                  },
                                                ),
                                                /* Center(
                                                  child: Image.asset(
                                                    'lib/icon/down.png', // Ruta de la imagen
                                                    width: 15, // Ajusta el tamaño de la imagen según sea necesario
                                                    height: 15,
                                                  ),
                                                ),*/
                                              ),
                              ),
                           ),*/
                           SizedBox(width: 30,),
                           /*BlocBuilder<VisorBloc,VisorState>(
                                builder: (context,state){
                                  if(state.isAprende && stateF.usuario.esPsicologo){
                                      return Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: 50.0,
                                              height: 50.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2.0, // Ajusta el ancho del borde según sea necesario
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              BlocProvider.of<AprendeBloc>(context).add(CrearAprende());
                                              // Acciones que deseas realizar cuando se toca el botón de agregar
                                            },
                                            icon: Icon(Icons.add),
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
                                  );
                                }
                                return Container();
                                                  },
                          ),*/
                            
                        ],
                      ),
                  ),
                  SizedBox(height: 5,),
                  parteAprende(stateF: stateF),
                  Padding(
                      padding: EdgeInsets.only(left: 10,top:20),
                      child: Row(
                        children: [
                          Container(
                              width: 80,
                            child: Text(
                              "Practica",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 30,),
                          /*InkWell(
                                            onTap: () {
                                              //_ver=false;
                                              BlocProvider.of<VisorBloc>(context).add(VisorPractica());
                                            //BlocProvider.of<CambiadorBloc>(context).add(cambiarToInicio());
                                          // Acciones que deseas realizar cuando se toca el botón
                          
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey, // Color del borde
                                                    width: 1, // Ancho del borde
                                                  ),
                                                ),
                                                child: BlocBuilder<VisorBloc,VisorState>(
                                builder: (context,state){
                                  if(state.isPractica){
                                      return Center(
                                        child: Image.asset(
                                          'lib/icon/down.png', // Ruta de la imagen
                                          width: 15, // Ajusta el tamaño de la imagen según sea necesario
                                          height: 15,
                                  ),
                                );
                                                    }
                                return Center(
                                child: Image.asset(
                                                    'lib/icon/d.png', // Ruta de la imagen
                                                    width: 15, // Ajusta el tamaño de la imagen según sea necesario
                                                    height: 15,
                                                  ),
                                                );
                                                  },
                                                ),/*Center(
                                                  child: Image.asset(
                                                    'lib/icon/down.png', // Ruta de la imagen
                                                    width: 15, // Ajusta el tamaño de la imagen según sea necesario
                                                    height: 15,
                                                  ),
                                                ),*/
                                              ),
                                            ),
                          ),*/
              
              
                          
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    partePractica(stateF: stateF),
                    stateF.usuario.esPsicologo ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Reportes de estudiantes",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                          barra_reporte_psicologo(color: 0, usuario: stateF.usuario,),
                        ],
                      ),
                    ):
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Actúa",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width*.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<CambiadorBloc>(context).add(cambiartToReporte('valor'));
              
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                                      padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomStart,
                                      children: [
                                      Container(
                                          height: MediaQuery.of(context).size.width*.42,
                                          width: MediaQuery.of(context).size.width*.42,
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
                                          height: MediaQuery.of(context).size.width*.42,
                                          width: MediaQuery.of(context).size.width*.42,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                                Center(
                                                child: Image.asset(
                                                        'lib/icon/rvalor.png', // Ruta de la imagen
                                                        width: 95, // Ajusta el tamaño de la imagen según sea necesario
                                                        height: 95,
                                                      ),
                                                ),
                                                Text('Reportar un valor',style: TextStyle(color: Colors.black,fontSize: 15),),
              
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                                         ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<CambiadorBloc>(context).add(cambiartToReporte('violencia'));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                      minimumSize: Size(80, 80), // Ajusta el tamaño del botón según tus necesidades
                                      padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5), // Elimina el espacio alrededor del contenido del botón
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: AlignmentDirectional.bottomStart,
                                      children: [
                                      Container(
                                          height: MediaQuery.of(context).size.width*.42,
                                          width: MediaQuery.of(context).size.width*.42,
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
                                          height: MediaQuery.of(context).size.width*.42,
                                          width: MediaQuery.of(context).size.width*.42,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                                Center(
                                                child: Image.asset(
                                                        'lib/icon/rviolencia.png', // Ruta de la imagen
                                                        width: 95, // Ajusta el tamaño de la imagen según sea necesario
                                                        height: 95,
                                                      ),
                                                ),
                                                Text('Reportar una\n\r violencia',style: TextStyle(color: Colors.black,fontSize: 15)),
              
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          ],),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        );
      }
      return Container();
    },
  ),

  );

  }

}

class parteAprende extends StatelessWidget {
  const parteAprende({
    super.key,
    required this.stateF,
  });

  final Authenticated stateF;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AprendeBloc, AprendeState>(
       listener: (context, state){

        //iniciarVistaProgreso()
       },

       builder: (context,state){
        if( state.isNewMessaging ){
          //BlocProvider.of<VisorBloc>(context).add(LoadAprende());
          return Container(
       
            height: 30+ MediaQuery.of(context).size.height * 0.30 ,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.aprenderes!.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10); // Espacio entre elementos de la lista
              },
              itemBuilder: (BuildContext context, int index) {
                final aprende = state.aprenderes![index];
                return barra_aprende(
                  aprende: aprende,
                  usuario: stateF.usuario,
                );
              },
            ),
          );
        }
        else if(state.isCrearAprender){
          return crearaAprenderes();
        }
        else if(state.isActualizarAprender){
       
          return crearaAprenderes(
            id: state.aprende!.id,
            nombreController:TextEditingController(text: "${state.aprende!.nombre}"),
            tipo: "Actualizar",
            color: state.aprende!.color,
            imagen: state.aprende!.imagen,);
        }
      
        return Container();
      },
     );
  }
}




class barra_reporte_psicologo extends StatelessWidget {
  final int color;
  final Usuario usuario;

  const barra_reporte_psicologo({
    Key? key,
    required this.color,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: () {
        //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardHabilidad(aprende));
        BlocProvider.of<CambiadorBloc>(context).add(cambiartToReporte('ver_reportes'));
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
            height: 100,
            width: MediaQuery.of(context).size.width ,
            decoration: BoxDecoration(
              color: Color(4293309470),
              borderRadius: BorderRadius.circular(20.0), // Ajusta el radio según tus preferencias
            ),
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Violencia',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              BlocBuilder<ReportePsicologBloc, ReportePsicologState>(
              builder: (context, state) {
                if(state.esCargando){
                  //String s= "${ state.resultados[aprende.id] != null ? state.resultados[aprende.id]!.enProgreso:0} ";

                  return Container(
                    width: 150,
                    height: 30,
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${state.reportesNuevos.length}',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "  nuevo reporte",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Lato',
                           
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  height: 30,
                  width: 150,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2, // Ancho de la línea del indicador
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Color del indicador
                      backgroundColor: Colors.transparent, // Color de fondo (transparente en este caso)
                      // Radio del círculo (la mitad del tamaño deseado)
                    ),
                  ),
                );

              }),

                ],
              ),
              Center(
                child: Container(
                  height: 110,
                  width: 110,
                  child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/valorixdb.appspot.com/o/ejercicio_imagen%2FfotoAprende%2F604be2894b8d021360d0ab81b5ea2a19.png?alt=media&token=2e92cd68-7042-4344-b96d-fd4c879b2924', // URL de la imagen
                        fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                      ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}


class partePractica extends StatefulWidget {
  const partePractica({
    super.key,
    required this.stateF,
  });

  final Authenticated stateF;

  @override
  State<partePractica> createState() => _partePracticaState();
}

class _partePracticaState extends State<partePractica> {


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HabilidadBloc, HabilidadState>(
         

            builder: (context, state) {
              if (state.isLoadHabilidad) {
                
                return Container(
          
                        height: 30+MediaQuery.of(context).size.height * 0.52 ,
                      
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.habilidades!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 10); // Espacio entre elementos de la lista
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final habilidad = state.habilidades![index];
                            return barra_habilidad_global(
                              habilidad: habilidad,
                              usuario: widget.stateF.usuario,
                            );
                          },
                        ),
                      );
                
              }
              return Container();
            },
          );
    
    /*BlocBuilder<VisorBloc, VisorState>(
      builder: (context, stateM) {
        if (stateM.isPractica) {
            },
          );
        }
        return Container();
      },
    );*/
  }
}





class PodioGanadores extends StatelessWidget {
  final List<Usuario> usuarios;

  const PodioGanadores({Key? key, required this.usuarios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tamano=MediaQuery.of(context).size.width;
    return Container(
      height: 280,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
    
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: PodioItem2(
                    usuario: usuarios[1],
                    posicion: 2,
                    radio: tamano * 0.14,
                  ),
              ),
            CircleAvatar(
              radius: tamano * 0.07, // Define el tamaño del avatar circular
              backgroundColor: Colors.transparent, // Color de fondo
              child: Container(),
                    ),
             PodioItem2(
                  usuario: usuarios[2],
                  posicion: 3,
                  radio: tamano * 0.14,
                ),
    
            ],
          ),
          Column(
            children: [
              PodioItem1(
                
                  usuario: usuarios[0],
                  posicion: 1,
                  radio: tamano * 0.18,
                ),
                
            ],
          ),
        ],
      ), 
    );
  }
}

class PodioItem1 extends StatelessWidget {
  final Usuario usuario;
  final int posicion;
  final double radio;
  const PodioItem1({Key? key, required this.usuario, required this.posicion, required this.radio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
                  height: 50,
                  width: 50,
                  child: Image(
              
                    image: AssetImage('lib/icon/primerLugar.png')),
                ),
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
             
                height: radio + 53,
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
                Text(
                  '${usuario.nombres}',
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),
                  maxLines: 2, 
                  textAlign: TextAlign.center,
                ),
  
                Text(
                  '${usuario.progreso}',
                  style: TextStyle(fontSize: 17,color: Color(4278245019),fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 30,)
               
      ],
    );
  }
}
class PodioItem2 extends StatelessWidget {
  final Usuario usuario;
  final int posicion;
  final double radio;
  
  const PodioItem2({Key? key, required this.usuario, required this.posicion, required this.radio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                Container(
                  height: 80,
                  width: 80,
         
                ),
        Text(
                  '$posicion',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color:  posicion==2 ? Colors.purple:Colors.pink
          ),
        ),
         Container(
          width: radio + 65, // El doble del radio más el ancho del borde
          height: radio + 65, // El doble del radio más el ancho del borde
          decoration: BoxDecoration(
            border: Border.all(color: posicion==2 ? Colors.purple:Colors.pink, width: 4),
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: ClipOval(
              child: Container(
                height: radio + 53,
                width: radio + 60,
                child: Image.network(
                        usuario.imagen, // URL de la imagen
                        fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                      ),
              ),
            ),
          ),
        ),
          Text(
                  
                  '${usuario.nombres}',
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                ),
  
                Text(
                  '${usuario.progreso}',
                  style: TextStyle(fontSize: 17,color: posicion==2 ? Colors.purple:Colors.pink,fontWeight: FontWeight.bold,),
                ),
      ],
    );
  }
}