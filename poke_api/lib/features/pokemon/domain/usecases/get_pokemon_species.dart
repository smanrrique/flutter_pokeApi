import 'package:poke_api/features/pokemon/domain/entities/pokemon_species.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonSpecies {
  final PokemonRepository repository;

  const GetPokemonSpecies(this.repository);

  Future<PokemonSpecies> call(String speciesUrl) =>
      repository.getPokemonSpecies(speciesUrl);
}
