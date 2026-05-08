import 'package:poke_api/features/pokemon/domain/entities/pokemon_page.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonList {
  final PokemonRepository repository;

  const GetPokemonList(this.repository);

  Future<PokemonPage> call() => repository.getInitialPokemons();
}
