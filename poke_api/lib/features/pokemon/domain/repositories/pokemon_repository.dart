import 'package:poke_api/features/pokemon/domain/entities/evolution_stage.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon_page.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon_species.dart';

abstract class PokemonRepository {
  Future<PokemonPage> getInitialPokemons();
  Future<PokemonPage> loadMore(String nextUrl);
  Future<Pokemon> getPokemonDetail(Pokemon pokemon);
  Future<PokemonSpecies> getPokemonSpecies(String speciesUrl);
  Future<List<EvolutionStage>> getEvolutionChain(String evolutionChainUrl);
  Future<Set<String>> getFavoriteUrls();
  Future<void> setFavorite(String url, bool isFavorite);
}
