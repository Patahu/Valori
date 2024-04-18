


import 'package:flutter/material.dart';

class PhotoPaletteDialog extends StatelessWidget {
  final Function(String) onPhotoSelected;

  PhotoPaletteDialog({required this.onPhotoSelected});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Seleccionar Foto'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildColorButtons(context),
        ),
      ],
    );
  }

  List<Widget> _buildColorButtons(BuildContext context) {
    List<String> colors = [
      'violencia',
      'tolerancia',
      'respeto',
      'empatia',
      'autocontrol',

    ];

    return colors.map((color) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Cerrar el diálogo
          onPhotoSelected(color);
        },
        child: Center(
                child: Container(
                height: 40,
                width: 40,
                child: Image(image: AssetImage('lib/icon/${color}.png')),
              ),
        ),
      );
    }).toList();
  }
}



class ColorPaletteDialog extends StatelessWidget {
  final Function(int) onColorSelected;

  ColorPaletteDialog({required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Seleccionar Color'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildColorButtons(context),
        ),
      ],
    );
  }

  List<Widget> _buildColorButtons(BuildContext context) {
    List<int> colors = [4294937216, 4278245019, 4285358586, 4294957180, 4291359200,4287334960];

    return colors.map((color) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Cerrar el diálogo
          onColorSelected(color);
        },
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Color(color),
            shape: BoxShape.circle,
          ),
        ),
      );
    }).toList();
  }
}


