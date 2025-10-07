import 'package:flutter/material.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';
import 'package:poke_api/utils/app_colors.dart';

class TypePokemon extends StatelessWidget {
  const TypePokemon({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pokemon.listTypes.map((nombre) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 0,
            bottom: 0,
            left: 8,
            right: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              color:
                  AppColors.typesPokemonColor[nombre] ??
                  Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Center(
                child: Text(
                  nombre,
                  style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.width *
                        0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
