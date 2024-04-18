

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import 'package:valorix/src/ui/habilidad_screen/crear_habilidades.dart';



import '../../bloc/bloc_cambiador/bloc.dart';

import '../../bloc/bloc_portador_imagen/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';
import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../../modelos/usuario.dart';
import '../home_screen/actua_screen.dart';
import 'habilidad_screen.dart';




class HabilidadScreen extends StatefulWidget {
  final Aprende aprende;
  const HabilidadScreen({super.key, required this.aprende});

  @override
  State<HabilidadScreen> createState() => _habilidadState();
}

class _habilidadState extends State<HabilidadScreen> {
  
  CambiadorBloc? _cambiadorBloc;
  late HabilidadBloc _habilidadBloc;
  late PortadorImagenBloc _portadorImagenBloc;
  final TextEditingController nombre= TextEditingController();
  @override
  void initState() {
    _cambiadorBloc = BlocProvider.of<CambiadorBloc>(context);
    _habilidadBloc=BlocProvider.of<HabilidadBloc>(context);
    _portadorImagenBloc=BlocProvider.of<PortadorImagenBloc>(context);
    //add(iniciarVistaProgreso(aprende.id))
    BlocProvider.of<LeccionProgresoHabilidadBloc>(context).add(iniciarVistaHabilidadProgreso(widget.aprende.id));

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
                                  widget.aprende.nombre,
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
                  builder: (context, state) {
                    if (state is Authenticated) {
                      final stateF = state as Authenticated;
                      return Column(
                          children: [
          
                          BlocConsumer<HabilidadBloc, HabilidadState>(
                            listener: (context, state){
                      
                            },
                    
                            builder: (context,state){
                              /*if( state.isLoadHabilidad && !state.isCrearHabilidad && !state.isActualizarHabilidad){
                                return Column(
                                  children: [
                                             stateF.usuario.esPsicologo ? 
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                Container(
                                    width: MediaQuery.of(context).size.width*.8,
                                  height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                color: Color(widget.aprende.color),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0, // Ajusta el ancho del borde según sea necesario
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<HabilidadBloc>(context).add(CrearHabilidad());
                                  // Acciones que deseas realizar cuando se toca el botón de agregar
                                },
                                child: Text(
                                'Crear nuevo valor',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ),
                            ),
                                        ],
                                      )
                      
                      
                          :Container(), 
                          
                          SizedBox(height: 20),
                                    Container(
                               
                                      height: MediaQuery.of(context).size.height*.67,
                                      child: ListView.separated(
                                        itemCount: state.habilidades!.length,
                                        separatorBuilder: (BuildContext context, int index) {
                                          return SizedBox(height: 10); // Espacio entre elementos de la lista
                                        },
                                        itemBuilder: (BuildContext context, int index) {
                                          final habilidad = state.habilidades![index];
                                          return barra_habilidad(
                                            habilidad: habilidad,
                                            usuario: stateF.usuario,
                                            color: widget.aprende.color,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }else if(state.isCrearHabilidad){
                           
                                
                                return crearaHabilidades(imagen: state.habilidad!.imagen,id: widget.aprende.id,color: widget.aprende.color,);
                              }
                              else if(state.isActualizarHabilidad){
                                return crearaHabilidades(
                                  id: state.habilidad!.id,
                                  color: widget.aprende.color,
                                  nombreController:TextEditingController(text: "${state.habilidad!.nombre}"),
                                  tipo: "Actualizar",
                                  imagen: state.habilidad!.imagen,);
                              }*/
                             
                                        
                               return Column(
                                          children: [
                                                    stateF.usuario.esPsicologo ? 
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                        Container(
                                            width: MediaQuery.of(context).size.width*.8,
                                          height: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                        color: Color(widget.aprende.color),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.0, // Ajusta el ancho del borde según sea necesario
                                        ),
                                      ),
                                      child: TextButton(
                                        onPressed: () {

                                          nombre.text='';
                                          Navigator.push(
                                                  context,
                                              MaterialPageRoute(builder: (context) =>  crearaHabilidades(nombre: nombre,
                                              aptitud:widget.aprende,
                                                habilidadBloc:_habilidadBloc ,portadorImagenBloc: _portadorImagenBloc,
                                              )),
                                          );
                                          
                                          BlocProvider.of<HabilidadBloc>(context).add(CrearHabilidad());
                                          // Acciones que deseas realizar cuando se toca el botón de agregar
                                        },
                                        child: Text(
                                        'Crear nuevo valor',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ),
                                    ),
                                                ],
                                              )
                            
                            
                                  :Container(), 
                                  
                                  SizedBox(height: 20),
                                            Container(
                                      
                                              height: stateF.usuario.esPsicologo ?MediaQuery.of(context).size.height*.66:MediaQuery.of(context).size.height*.8,
                                              child: ListView.separated(
                                                itemCount: state.habilidades!.length,
                                                separatorBuilder: (BuildContext context, int index) {
                                                  return SizedBox(height: 10); // Espacio entre elementos de la lista
                                                },
                                                itemBuilder: (BuildContext context, int index) {
                                                  final habilidad = state.habilidades![index];
                                                  return ElevatedButton(
                                                      onPressed: () {
                                                        BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(habilidad));

                                                        // Acción al hacer clic en el botón
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        primary: Colors.transparent,
                                                        elevation: 0, // Establece la elevación a 0 para quitar la sombra de fondo
                                                        minimumSize: Size(double.infinity, 100), // Ajusta el tamaño del botón según tus necesidades
                                                        padding: EdgeInsets.only(left: 10, right: 10,bottom: 10), // Elimina el espacio alrededor del contenido del botón
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20.0),
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        alignment: AlignmentDirectional.bottomStart,
                                                        children: [
                                                        Container(
                                                            height: 120+(stateF.usuario.esPsicologo?60:0),
                                                            width: MediaQuery.of(context).size.width ,
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

                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        habilidad.nombre,
                                                                        style: TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 15,
                                                                          fontFamily: 'Lato',
                                                                          fontWeight: FontWeight.bold,
                                                                        ),
                                                                      ),

                                                                      BlocBuilder<LeccionProgresoHabilidadBloc, LeccionProgresoHabilidadState>(
                                                                          builder: (context, state) {
                                                                            if(state.esCargado){
                                                                              String s= "${ state.resultados[habilidad.id] != null ? state.resultados[habilidad.id]!.enProgreso:0} ";

                                                                              return Container(
                                                                                width: 150,
                                                                                height: 30,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      s,
                                                                                      style: TextStyle(
                                                                                        color: Color.fromARGB(255, 97, 97, 97),
                                                                                        fontSize: 25,
                                                                                        fontFamily: 'Lato',
                                                                                        
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      "de ${state.resultados[habilidad.id]!= null ? state.resultados[habilidad.id]!.total:0} lecciones",
                                                                                      style: TextStyle(
                                                                                        color: Color.fromARGB(255, 97, 97, 97),
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
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black), // Color del indicador
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
                                                                      height: 120,
                                                                      width: 120,
                                                                      child: Image.network(
                                                                    habilidad.imagen, // URL de la imagen
                                                                    fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                                                                  ),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),

                                                              BlocBuilder<LeccionProgresoHabilidadBloc, LeccionProgresoHabilidadState>(
                                                                  builder: (context, state) {
                                                                    if(state.esCargado){
                                                                      final progreso =state.resultados[habilidad.id] != null ? state.resultados[habilidad.id]!.enProgreso:1;
                                                                      final total =state.resultados[habilidad.id] != null ? state.resultados[habilidad.id]!.total:1;
                                                                      return Container(
                                                                        height: 10,
                                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                                        child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(5), // Ajusta el radio según tus preferencias
                                                                          child: LinearProgressIndicator(
                                                                            value: total !=0 ? progreso / total:0,

                                                                            backgroundColor: Colors.grey,
                                                                            valueColor: AlwaysStoppedAnimation<Color>(Color(widget.aprende.color)),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    return Container(
                                                                      height: 10,
                                                                      width: MediaQuery.of(context).size.width * 0.8,
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(5), // Ajusta el radio según tus preferencias
                                                                        child: LinearProgressIndicator(
                                                                          value: 1,
                                                                          minHeight: 10,
                                                                          backgroundColor: Colors.grey,
                                                                          valueColor: AlwaysStoppedAnimation<Color>(Color(widget.aprende.color)),
                                                                        ),
                                                                      ),
                                                                    );

                                                                  }),

                                                              Container(height: 10,),
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
                                                                                  color: Color(widget.aprende.color),
                                                                                  width: 1.0, // Ajusta el ancho del borde según sea necesario
                                                                                ),
                                                                              ),
                                                                              child: TextButton(
                                                                                onPressed: () {
                                                                                  BlocProvider.of<HabilidadBloc>(context).add(ElimnarHabilidad(habilidad.id));
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
                                                                            SizedBox(width: 15,),
                                                                            // Ajusta el espacio entre los botones según sea necesario
                                                                            Container(
                                                                              width: 150.0,
                                                                              height: 40.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(widget.aprende.color),
                                                                                borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                                                                border: Border.all(
                                                                                  color: Colors.white,
                                                                                  width: 1.0, // Ajusta el ancho del borde según sea necesario
                                                                                ),
                                                                              ),
                                                                              child: TextButton(
                                                                                onPressed: () {
                                                                                   nombre.text='';
                                                                                  Navigator.push(
                                                                                          context,
                                                                                      MaterialPageRoute(builder: (context) =>  crearaHabilidades(nombre: nombre,
                                                                                      aptitud:widget.aprende,tipo: 'Editar',
                                                                                        habilidadBloc:_habilidadBloc ,portadorImagenBloc: _portadorImagenBloc,
                                                                                      )),
                                                                                      
                                                                                  );
                                                                                  BlocProvider.of<HabilidadBloc>(context).add(ModificarHabilidad(habilidad));
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
                                                                      SizedBox(height: 10,)

                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                },
                                              ),
                                            ),
                                          ],
                              );
                            },
                          ),
          
                        ],
                      );
                    }
                    return Container();
                  },
                ),
          ],
        ),
    ),
  );

  }

}