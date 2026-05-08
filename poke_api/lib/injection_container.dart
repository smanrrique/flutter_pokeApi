import 'package:http/http.dart' as http;
import 'package:poke_api/features/pokemon/data/datasources/favorites_local_datasource.dart';
import 'package:poke_api/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_api/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_evolution_chain.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_favorites.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_pokemon_species.dart';
import 'package:poke_api/features/pokemon/domain/usecases/load_more_pokemons.dart';
import 'package:poke_api/features/pokemon/domain/usecases/toggle_favorite.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependencies {
  final PokemonProvider pokemonProvider;

  AppDependencies._({required this.pokemonProvider});

  static Future<AppDependencies> bootstrap() async {
    final httpClient = http.Client();
    final prefs = await SharedPreferences.getInstance();

    final PokemonRemoteDataSource remote =
        PokemonRemoteDataSourceImpl(client: httpClient);
    final FavoritesLocalDataSource local =
        FavoritesLocalDataSourceImpl(prefs: prefs);

    final PokemonRepository repository =
        PokemonRepositoryImpl(remote: remote, local: local);

    final provider = PokemonProvider(
      getPokemonList: GetPokemonList(repository),
      loadMorePokemons: LoadMorePokemons(repository),
      getPokemonDetail: GetPokemonDetail(repository),
      getPokemonSpecies: GetPokemonSpecies(repository),
      getEvolutionChain: GetEvolutionChain(repository),
      toggleFavoriteUseCase: ToggleFavorite(repository),
      getFavoritesUseCase: GetFavorites(repository),
    );

    return AppDependencies._(pokemonProvider: provider);
  }
}
