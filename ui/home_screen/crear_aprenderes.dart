

import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_aprende/bloc.dart';
import 'paleta_colores.dart';

class crearaAprenderes extends StatelessWidget {
  TextEditingController _nombre;
  int _color;
  String _imagen;
  String _tipo;
  String _id;
  crearaAprenderes({
    Key? key,
    TextEditingController? nombreController,
    int? color,
    String? imagen,
    String? tipo,
    String? id,
  })  : _nombre = nombreController ?? TextEditingController(),
        _color = color ?? 4291359200,
        _tipo=tipo ?? 'Ingresar',
        _imagen = imagen ?? 'violencia',
        _id=id?? '',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.35,
      width: MediaQuery.of(context).size.width*.9,
       decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(color: Colors.black45, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
      child: ListView(
      children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50.0,
               
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<AprendeBloc>(context).add(VolverAprende());
                      // Acciones que deseas realizar cuando se toca el botón de volver
                      //Navigator.of(context).pop(); // Esto cierra la página actual y vuelve a la anterior
                    },
                    icon: Icon(Icons.keyboard_arrow_left), // Ícono para volver
                    iconSize: 50.0,
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(color: Colors.black45, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _nombre,
                  decoration: const InputDecoration(
                      icon: Padding(
                        padding: EdgeInsets.only(left:20), // Ajusta la cantidad de espacio a la derecha
                        child: Icon(Icons.abc, color:Colors.black45),
                      ),
                      labelText: 'Nombre',
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.black45)),
                  autovalidateMode: AutovalidateMode.always,
                  autocorrect: false,
                  validator: (_) {
                    //return !state.isEmailValid ? 'Email inválido' : null;
                  },
                  style: TextStyle(
                    decoration: TextDecoration.none, // Elimina el subrayado del texto ingresado
                  ),
                ),
              ),
            ),
            // Botón para seleccionar un color
            BlocBuilder<AprendeBloc, AprendeState>(
              builder: (context,state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),///4278245019, 4285358586
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            color: Color(_color),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Acciones que deseas realizar cuando se toca el botón de seleccionar color
                              _showColorPaletteDialog(context,BlocProvider.of<AprendeBloc>(context));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(4278245019),
                            ),
                            child: Text('Seleccionar Color'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: Center(
                                    child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Image(image: AssetImage('lib/icon/${_imagen}.png')),
                                  ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(4285358586),
                            ),
                            onPressed: () {
                              // Acciones que deseas realizar cuando se toca el botón de seleccionar color
                              _showPhotoPaletteDialog(context,BlocProvider.of<AprendeBloc>(context));
                            },
                            child: Text('Seleccionar Foto'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(4285358586),
                    ),
                    onPressed: () {
                      if(_tipo=='Ingresar'){
                        BlocProvider.of<AprendeBloc>(context).add(IngresarAprende(_nombre.text,_color,_imagen));

                      }else if(_tipo=='Actualizar'){
                            //updateAprender
                        BlocProvider.of<AprendeBloc>(context).add(ActualizarAprende(_id,_nombre.text,_color,_imagen));
                      }
                      // Acciones que deseas realizar cuando se toca el botón de seleccionar color
                    },
                    child: Text(_tipo),
                  ),
                ),
              ],
            ),
            // Botón para volver
            
          ],
        ),
      );
  }

  void _showPhotoPaletteDialog(BuildContext context, AprendeBloc blocs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PhotoPaletteDialog(
          onPhotoSelected: (String onPhotoSelected) {
            // Manejar la selección del color aquí
            _imagen=onPhotoSelected;
            blocs.add(ActualizarCFAprende());
            print('Color seleccionado: $onPhotoSelected');
          },
        );
      },
    );
  }
  void _showColorPaletteDialog(BuildContext context,AprendeBloc blocs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPaletteDialog(
          onColorSelected: (int selectedColor) {
            // Manejar la selección del color aquí
            _color=selectedColor;
            blocs.add(ActualizarCFAprende());
            print('Color seleccionado: $selectedColor');
          },
        );
      },
    );
  }

}