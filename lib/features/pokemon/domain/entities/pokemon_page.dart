import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';

class PokemonPage {
  final List<Pokemon> pokemons;
  final int count;
  final String? previous;
  final String? next;

  PokemonPage({
    required this.pokemons,
    required this.count,
    required this.previous,
    required this.next,
  });
}
