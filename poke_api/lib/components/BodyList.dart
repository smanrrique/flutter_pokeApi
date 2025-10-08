import 'package:flutter/material.dart';
import 'package:poke_api/components/CardPokemon.dart';
import 'package:poke_api/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class BodyList extends StatelessWidget {  

  const BodyList({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
    var pokemons = pokemonProvider.response;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        itemCount: pokemonProvider.response!.listPokemons.length,

        itemBuilder: (context, index) {
          return CardPokemon(item:pokemons!.listPokemons[index]);
        },
      ),
    );
  }
}