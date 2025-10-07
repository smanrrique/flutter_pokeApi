import 'package:flutter/material.dart';
import 'package:poke_api/components/CardPokemon.dart';
import 'package:poke_api/data/model/pokemon_response.dart';

class BodyList extends StatelessWidget {

  final PokemonResponse pokemonResponse;

  const BodyList({super.key, required this.pokemonResponse});

  @override
  Widget build(BuildContext context) {
    var pokemons = pokemonResponse.listPokemons;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        itemCount: pokemonResponse.listPokemons.length,
        itemBuilder: (context, index) {
          return CardPokemon(item:pokemons[index]);
        },
      ),
    );
  }
}