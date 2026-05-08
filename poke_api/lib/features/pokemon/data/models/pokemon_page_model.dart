import 'package:poke_api/features/pokemon/data/models/pokemon_model.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon_page.dart';

class PokemonPageModel extends PokemonPage {
  PokemonPageModel({
    required super.pokemons,
    required super.count,
    required super.previous,
    required super.next,
  });

  factory PokemonPageModel.fromJson(Map<String, dynamic> json) {
    final list = (json['results'] as List)
        .map((item) => PokemonModel.fromListJson(item))
        .toList();

    return PokemonPageModel(
      pokemons: list,
      count: json['count'] ?? 0,
      previous: json['previous'],
      next: json['next'],
    );
  }
}
