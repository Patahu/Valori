

import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import 'package:valorix/src/bloc/blocs_home/blocs_aprende/bloc_habilidad/habilidad_bloc.dart';

import '../../bloc/bloc_portador_imagen/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../modelos/aprende.dart';
import 'paleta_imagenes.dart';


class crearaHabilidades extends StatelessWidget {
  final TextEditingController nombre;


  String _tipo;
  final Aprende aptitud;
  final HabilidadBloc habilidadBloc;
  final PortadorImagenBloc portadorImagenBloc;
  crearaHabilidades({
    Key? key,
    required this.nombre,
    required this.habilidadBloc,
    required this.portadorImagenBloc,
    required this.aptitud,

  
    String? tipo,


  })  :
        _tipo=tipo ?? 'Crear',



        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: BlocConsumer<HabilidadBloc, HabilidadState>(
          listener: (context, state) {
            
                            if (state.isFail) {
                ScaffoldMessenger.of(context)
                // ignore: deprecated_member_use
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                        SnackBar(
                          content: Container(
                            height: 170,
                          
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Error!',
                                  style: TextStyle(fontSize: 25),
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
                              color: Color(aptitud.color).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                      child: Center(child: Text('¡Ingresado!',style: TextStyle(
                        fontSize: 25
                      ),)),
                    ),
                    backgroundColor:    
                    Colors.transparent,
                  ));
              }
          },
          bloc: habilidadBloc,
          builder: (context,state) {
             if(state.isActualizarHabilidad){
                if(nombre.text.isEmpty ){
                    nombre.text=state.habilidad!.nombre;
                 
             
                }
            }
            return Container(
              height: MediaQuery.of(context).size.height*.9,
              width: MediaQuery.of(context).size.width*.97,
          
              child: ListView(
                padding:EdgeInsets.only(left: 15, top: 10),
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
                                        
                                        //habilidadBloc.add(VolverHabilidad());
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
                                  child: Text(
                                    '$_tipo nuevo valor',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                 ),
                ),
                    Text(
                        'Nombre',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    TextField(
                        controller: nombre,
                        decoration: InputDecoration(
                          hintText: 'Ingresa el nombre del valor',
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
                    Text(
                        'Personaje',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    // Botón para seleccionar un color
                    BlocBuilder<PortadorImagenBloc, PortadorImagenState>(
                      bloc: portadorImagenBloc,
                      builder: (context,state) {
                         if(state.isLoadAll){
                                    return  Container(
                                                        height: MediaQuery.of(context).size.height*.8,
                                                        child: GridView.count(
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    crossAxisCount: 4,
                                                                    childAspectRatio: 1.0,
                                                                    children: List.generate(state.fotosHabilidad.length, (index) {
                                                                      final leccion = state.fotosHabilidad[index];
                                                                      return BlocBuilder<HabilidadBloc,HabilidadState>(
                                                                        bloc: habilidadBloc,
                                                                        builder: (context,state2){
                                                                          if(state2.habilidad!.imagen==leccion){
                                                                            return SizedBox(
                                                                                height: 5,
                                                                                width: 5,
                                                                                child: ElevatedButton(
                                                                                    onPressed: () {
                                                                                      //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
                                                                                      habilidadBloc.add(IngresarImageHabilidad(leccion));


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
                                                                                                      color: Color(aptitud.color),
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
                                                                                                height: 60,
                                                                                                width: 60,

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
                                                                                      habilidadBloc.add(IngresarImageHabilidad(leccion));


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
                                                                                                height: 60,
                                                                                                width: 60,

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
                              );
                        }
                        return Container();
                
                      }
                    ),
                    SizedBox(height: 10,),
          
                     Container(
                                              width: MediaQuery.of(context).size.width*.8,
                                            height: 50.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                          color: Color(aptitud
                                          .color),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2.0, // Ajusta el ancho del borde según sea necesario
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            if(_tipo=='Crear'){
                                              habilidadBloc.add(IngresarHabilidad(id_aptitud: aptitud.id,imagen: state.habilidad!.imagen,nombre: nombre.text));
          
                                            }else if(_tipo=='Editar'){
                                                  //updateAprender
                                              habilidadBloc.add(ActualizarHabilidad(id:aptitud.id,nombre:nombre.text,imagen: state.habilidad!.imagen));
                                            }
                                            // Acciones que deseas realizar cuando se toca el botón de agregar
                                          },
                                          child: Text(
                                          '$_tipo valor',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ),
                                      ),
                           Container(
                             width: MediaQuery.of(context).size.width*.8,
                       
                             height: 50.0,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(25.0),
                               border: Border.all(
                                 color: Color(aptitud.color),
                                 width: 2.0,
                               ),
                             ),
                             child: TextButton(
                               onPressed: () {
                                nombre.text='';
                                //habilidadBloc.add(VolverHabilidad());
                                Navigator.pop(context);  
                                 // Acciones que deseas realizar cuando se toca el botón de volver
                                 //Navigator.of(context).pop(); // Esto cierra la página actual y vuelve a la anterior
                               },
                               child: Text(
                                          'Cancelar',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                             ),
                           ),
                    // Botón para volver
                    
                  ],
                ),
              );
          }
        ),
      ),
    );
  }



}




class barra_leccion_tipo3 extends StatelessWidget {

  final String linkImagen;
  final int color;
  const barra_leccion_tipo3({
    Key? key,
    required this.linkImagen,
    required this.color,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
        BlocProvider.of<HabilidadBloc>(context).add(IngresarImageHabilidad(linkImagen));


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
                         color: Color(color),
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
                  height: 60,
                  width: 60,

                  child: Image.network(
                    linkImagen, // URL de la imagen
                    fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                  ),
                )
                

 
              ],
            ),
          )
        ],
      ),
    );
  }


}
