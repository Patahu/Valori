



import 'package:flutter/material.dart';
import 'package:valorix/src/bloc/blocs_home/blocs_aprende/bloc_habilidad/bloc.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class barra_habilidad extends StatelessWidget {
  final Habilidad habilidad;
  final Usuario usuario;
  final int color;

  const barra_habilidad({
    Key? key,
    required this.habilidad,
    required this.usuario,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            height: 120+(usuario.esPsicologo?60:0),
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
                          fontSize: 18,
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
                                        color: Colors.black,
                                        fontSize: 27,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "de ${state.resultados[habilidad.id]!= null ? state.resultados[habilidad.id]!.total:0} lecciones",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.bold,
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
                            valueColor: AlwaysStoppedAnimation<Color>(Color(color)),
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
                          valueColor: AlwaysStoppedAnimation<Color>(Color(color)),
                        ),
                      ),
                    );

                  }),

              Container(height: 10,),
                                usuario.esPsicologo
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
                                  color: Color(color),
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
                                color: Color(color),
                                borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.0, // Ajusta el ancho del borde según sea necesario
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<HabilidadBloc>(context).add(ModificarHabilidad(habilidad));
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
                      SizedBox(height: 10,)

            ],
          )
        ],
      ),
    );
  }
}
