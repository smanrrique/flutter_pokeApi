import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class ToggleFavorite {
  final PokemonRepository repository;

  const ToggleFavorite(this.repository);

  Future<Pokemon> call(Pokemon pokemon) async {
    final newValue = !pokemon.isFavorite;
    await repository.setFavorite(pokemon.url, newValue);
    pokemon.isFavorite = newValue;
    return pokemon;
  }
}
