import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FloatingButtonFavorite extends StatelessWidget {
  final VoidCallback onShowFavorites;

  const FloatingButtonFavorite({super.key, required this.onShowFavorites});

  @override
  Widget build(BuildContext context) {
    final double bouttonSize = MediaQuery.of(context).size.width * 0.12;

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFF1E90FF),
      buttonSize: Size(bouttonSize, bouttonSize),
      childrenButtonSize: Size(bouttonSize, bouttonSize),
      childPadding: EdgeInsets.zero,
      spacing: 6,
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
          onTap: onShowFavorites,
        ),
      ],
    );
  }
}
