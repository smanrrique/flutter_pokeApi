import 'package:flutter/material.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon_species.dart';

class PokemonDescription extends StatelessWidget {
  const PokemonDescription({super.key, required this.species});

  final PokemonSpecies species;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (species.genus.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              species.genus,
              style: TextStyle(
                fontSize: width * 0.035,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        if (species.flavorText.isNotEmpty)
          Text(
            species.flavorText,
            style: TextStyle(fontSize: width * 0.032),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
