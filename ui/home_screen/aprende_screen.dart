



import 'package:flutter/material.dart';
import 'package:valorix/src/modelos/habilidad.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import '../../bloc/bloc_cambiador/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso/bloc.dart';
import '../../bloc/blocs_home/blocs_aprende/bloc_leccion_progreso_habilidad/bloc.dart';
import '../../modelos/aprende.dart';
import '../../modelos/usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class barra_aprende extends StatelessWidget {
  final Aprende aprende;
  final Usuario usuario;

  const barra_aprende({
    Key? key,
    required this.aprende,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardHabilidad(aprende));

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
              color: Color(aprende.color),
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
                    aprende.nombre,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              BlocBuilder<LeccionProgresoBloc, LeccionProgresoState>(
              builder: (context, state) {
                if(state.esCargado){
                  String s= "${ state.resultados[aprende.id] != null ? state.resultados[aprende.id]!.enProgreso:0} ";

                  return Container(
                    width: 150,
                    height: 30,
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          s,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "de ${state.resultados[aprende.id]!= null ? state.resultados[aprende.id]!.total:0} lecciones",
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
                        aprende.imagen, // URL de la imagen
                        fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                      ),
                ),
              ),
              /*usuario.esPsicologo
                  ? Column(
                      children: [
                        // Ajusta el espacio entre los botones según sea necesario
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0, // Ajusta el ancho del borde según sea necesario
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<AprendeBloc>(context).add(ModificarAprende(aprende));
                              // Acciones que deseas realizar cuando se toca el botón de editar
                            },
                            icon: Icon(Icons.edit),
                            iconSize: 30.0,
                            color: Colors.blue,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            padding: EdgeInsets.all(0),
                            constraints: BoxConstraints.tightFor(
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                        ),
                        // Botón delete
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0, // Ajusta el ancho del borde según sea necesario
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<AprendeBloc>(context).add(ElimnarAprende(aprende.id));
                              // Acciones que deseas realizar cuando se toca el botón de eliminar
                            },
                            icon: Icon(Icons.delete),
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
                    )
                  : Container(),*/
            ],
          )
        ],
      ),
    );
  }
}


class barra_habilidad_global extends StatelessWidget {
  final Habilidad habilidad;
  final Usuario usuario;

  const barra_habilidad_global({
    Key? key,
    required this.habilidad,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardHabilidad(aprende));
        BlocProvider.of<CambiadorBloc>(context).add(cambiarToCardLeccionGlobal(habilidad));
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
              color: Color(habilidad.color),
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
                    habilidad.nombre,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              BlocBuilder<LeccionProgresoHabilidadBloc, LeccionProgresoHabilidadState>(
              builder: (context, state) {
                if(state.esCargado){

                  String s= "${ state.resultados[habilidad.id] != null ? state.resultados[habilidad.id]!.enProgreso:0} ";
                  if(habilidad.nombre=="Retos"){
                    final res=state.resultados[habilidad.id] != null ? state.resultados[habilidad.id]!.enProgreso:0;

                    final total=state.resultados[habilidad.id] != null ? state.resultados[habilidad.id]!.total:0;
                  return Container(
                    width: 150,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${total-res}",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " nuevo reto",
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                  }else{
                      return Container(
                      width: 150,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            s,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "de ${state.resultados[habilidad.id]!= null ? state.resultados[habilidad.id]!.total:0} ${habilidad.nombre.toLowerCase()}",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
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
                  height: 120,
                  width: 120,
                  child: Image.network(
                        habilidad.imagen, // URL de la imagen
                        fit: BoxFit.cover, // Ajustar la imagen para cubrir el área circular
                      ),
                ),
              ),
              /*usuario.esPsicologo
                  ? Column(
                      children: [
                        // Ajusta el espacio entre los botones según sea necesario
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0, // Ajusta el ancho del borde según sea necesario
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              //BlocProvider.of<AprendeBloc>(context).add(ModificarAprende(aprende));
                              // Acciones que deseas realizar cuando se toca el botón de editar
                            },
                            icon: Icon(Icons.edit),
                            iconSize: 30.0,
                            color: Colors.blue,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            padding: EdgeInsets.all(0),
                            constraints: BoxConstraints.tightFor(
                              width: 50.0,
                              height: 50.0,
                            ),
                          ),
                        ),
                        // Botón delete
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0), // Ajusta el radio según sea necesario
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0, // Ajusta el ancho del borde según sea necesario
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              //BlocProvider.of<AprendeBloc>(context).add(ElimnarAprende(aprende.id));
                              // Acciones que deseas realizar cuando se toca el botón de eliminar
                            },
                            icon: Icon(Icons.delete),
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
                    )
                  : Container(),*/
            ],
          )
        ],
      ),
    );
  }
}
