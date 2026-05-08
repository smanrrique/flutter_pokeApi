import 'package:poke_api/core/error/exceptions.dart';
import 'package:poke_api/core/error/failures.dart';
import 'package:poke_api/features/pokemon/data/datasources/favorites_local_datasource.dart';
import 'package:poke_api/features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_api/features/pokemon/domain/entities/evolution_stage.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon_page.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon_species.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remote;
  final FavoritesLocalDataSource local;

  PokemonRepositoryImpl({required this.remote, required this.local});

  @override
  Future<PokemonPage> getInitialPokemons() async {
    try {
      final page = await remote.getInitial();
      await _markFavorites(page);
      return page;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<PokemonPage> loadMore(String nextUrl) async {
    try {
      final page = await remote.loadMore(nextUrl);
      await _markFavorites(page);
      return page;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<Pokemon> getPokemonDetail(Pokemon pokemon) async {
    try {
      final detail = await remote.getDetail(pokemon.url);
      pokemon
        ..imageUrl = detail.imageUrl
        ..speciesUrl = detail.speciesUrl
        ..types = detail.types
        ..stats = detail.stats
        ..weight = detail.weight
        ..height = detail.height
        ..detailLoaded = true;
      return pokemon;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<PokemonSpecies> getPokemonSpecies(String speciesUrl) async {
    try {
      return await remote.getSpecies(speciesUrl);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<List<EvolutionStage>> getEvolutionChain(
      String evolutionChainUrl) async {
    try {
      return await remote.getEvolutionChain(evolutionChainUrl);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<Set<String>> getFavoriteUrls() async {
    try {
      return await local.getFavoriteUrls();
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }

  @override
  Future<void> setFavorite(String url, bool isFavorite) async {
    try {
      await local.setFavorite(url, isFavorite);
    } on CacheException catch (e) {
      throw CacheFailure(e.message);
    }
  }

  Future<void> _markFavorites(PokemonPage page) async {
    final favorites = await local.getFavoriteUrls();
    for (final pokemon in page.pokemons) {
      if (favorites.contains(pokemon.url)) {
        pokemon.isFavorite = true;
      }
    }
  }
}
