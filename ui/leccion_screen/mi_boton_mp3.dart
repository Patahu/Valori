



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../bloc/blocs_home/blocs_aprende/bloc_pregunta_crear/bloc.dart';

class MiBotonMP3 extends StatefulWidget {
  final PreguntaLeccionCrearBloc preguntaLeccionCrearBloc;
  final int index;

  const MiBotonMP3({super.key, required this.preguntaLeccionCrearBloc,required this.index});
  @override
  _MiBotonStateMP3 createState() => _MiBotonStateMP3();
}

class _MiBotonStateMP3 extends State<MiBotonMP3> {
  File? audioSeleccionada;
  late PreguntaLeccionCrearBloc _preguntaLeccionCrearBloc;
  late int _index;

  Future<void> seleccionarAudio() async {
    final FilePicker _picker = FilePicker.platform;
    final FilePickerResult? result = await _picker.pickFiles(
                                      type: FileType.audio,
                                    );
    if (result != null && result.files.single.path != null) {
      
      setState(() {
        audioSeleccionada =  File(result.files.single.path!);
        _preguntaLeccionCrearBloc.add(IngresarAlternativa('$_index',result.files.single.path!,false));
      });
      
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _preguntaLeccionCrearBloc=widget.preguntaLeccionCrearBloc;
    _index=widget.index;


    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 15),
      child: Container(
        height: MediaQuery.of(context).size.width*.30+ (audioSeleccionada !=null?MediaQuery.of(context).size.width*.07:0),
        width: MediaQuery.of(context).size.width*.95,
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await seleccionarAudio();
                // Actualizar el estado del widget para mostrar la imagen seleccionada
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(50, 100),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: audioSeleccionada == null ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Center(
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Image.asset(
                                'lib/icon/carga_nube.png',
                              ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    'Presiona para subir el audio',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
             
                ],
              ):Container(
                height: MediaQuery.of(context).size.width*.30,
                width: MediaQuery.of(context).size.width*.30,
                child: Icon(Icons.check)),
              
            ),
            SizedBox(height: 5,),
            audioSeleccionada !=null? Container(
            height: 20,
            child: TextButton( // Use TextButton for transparency
              onPressed: () async {
                audioSeleccionada = null;
                setState(() {});
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                minimumSize: Size(10, 10),
                primary: Colors.transparent, // Transparent background
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap area
         
              ),
              child: Text('Eliminar audio',style: TextStyle(
                color: Colors.blue,
                  fontFamily: 'Lato',
                fontSize: 15
              ),),
            ),
          )
          :Container(),
          ],
        ),
      ),
    );
  }
}