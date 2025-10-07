import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingButtonFavorite extends StatelessWidget {
  const FloatingButtonFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    double bouttonSize = MediaQuery.of(context).size.width * 0.12;

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFF1E90FF),
      buttonSize: Size(bouttonSize, bouttonSize), // Tamaño del boton padre
      childrenButtonSize: Size(bouttonSize, bouttonSize), // Tamaño de los botonos hijos
      childPadding: EdgeInsets.zero, //Quita el pagis por defecto
      spacing: 6, // Espacion entre botones
      shape: const CircleBorder(),       
      children: [
        SpeedDialChild(
          child: Icon(
            Icons.favorite,
            color: Colors.white,
            size: bouttonSize * 0.6,
          ),
          backgroundColor: Colors.red, 
          shape: const CircleBorder(),
          label: 'Favoritos',
          labelStyle: const TextStyle(fontSize: 14),
          onTap: () => print('Favorito 1'),
        ),
      ],
    );
  }
}
