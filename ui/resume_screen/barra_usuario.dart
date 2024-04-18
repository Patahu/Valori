
import 'package:flutter/material.dart';
import 'package:valorix/src/modelos/leccion.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/bloc_cambiador/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class barra_usuario extends StatelessWidget {

  final Usuario usuario;
  final int index;
  final int color;
  const barra_usuario({
    Key? key,
  
    required this.index,
    required this.usuario,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccion(leccion));
       // BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardVideo(leccion));
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

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Center(child: Text(index.toString()
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
                      color: Color(color), // Color del borde
                      width: 1, // Ancho del borde
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                        usuario.imagen, // URL de la imagen
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
                      Container(
                        width: 170, // Ancho del contenedor
                        child: Text(
                          usuario.progreso.toString(),
                          style: TextStyle(
                            color: Color(color),
                            fontSize: 14,
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
          )
        ],
      ),
    );
  }
  Widget determinarIcono(bool es_visto, bool es_pregunta, bool es_echo) {
    if (es_pregunta && es_visto && es_echo) {
      return _buildIconContainer(Icons.replay, Colors.black);
    } else if (es_pregunta && !es_visto && !es_echo) {
      return _buildIconContainer(Icons.play_arrow, Color(color));
    } else if (!es_pregunta && es_visto) {
      return _buildIconContainer(Icons.replay, Colors.black);
    } else {
      return _buildIconContainer(Icons.play_arrow, Color(color));
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
