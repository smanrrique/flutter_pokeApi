import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonDetail {
  final PokemonRepository repository;

  const GetPokemonDetail(this.repository);

  Future<Pokemon> call(Pokemon pokemon) =>
      repository.getPokemonDetail(pokemon);
}
