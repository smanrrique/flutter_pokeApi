import 'package:flutter/material.dart';
import 'package:poke_api/core/error/failures.dart';
import 'package:poke_api/features/pokemon/domain/entities/evolution_stage.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon_species.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_evolution_chain.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_favorites.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:poke_api/features/pokemon/domain/usecases/get_pokemon_species.dart';
import 'package:poke_api/features/pokemon/domain/usecases/load_more_pokemons.dart';
import 'package:poke_api/features/pokemon/domain/usecases/toggle_favorite.dart';

class PokemonProvider extends ChangeNotifier {
  final GetPokemonList getPokemonList;
  final LoadMorePokemons loadMorePokemons;
  final GetPokemonDetail getPokemonDetail;
  final GetPokemonSpecies getPokemonSpecies;
  final GetEvolutionChain getEvolutionChain;
  final ToggleFavorite toggleFavoriteUseCase;
  final GetFavorites getFavoritesUseCase;

  PokemonProvider({
    required this.getPokemonList,
    required this.loadMorePokemons,
    required this.getPokemonDetail,
    required this.getPokemonSpecies,
    required this.getEvolutionChain,
    required this.toggleFavoriteUseCase,
    required this.getFavoritesUseCase,
  });

  final List<Pokemon> _pokemons = [];
  String? _nextUrl;
  int _count = 0;
  bool _loading = false;
  bool _loadingMore = false;
  String? _error;
  String _searchQuery = '';
  final Set<String> _loadingDetailUrls = {};
  final Map<String, PokemonSpecies> _speciesCache = {};
  final Map<String, List<EvolutionStage>> _evolutionCache = {};
  final Set<String> _loadingSpeciesUrls = {};
  final Set<String> _loadingEvolutionUrls = {};

  List<Pokemon> get pokemons {
    if (_searchQuery.isEmpty) return List.unmodifiable(_pokemons);
    final q = _searchQuery.toLowerCase();
    return _pokemons.where((p) => p.name.toLowerCase().contains(q)).toList(
          growable: false,
        );
  }

  List<Pokemon> get favorites =>
      _pokemons.where((p) => p.isFavorite).toList(growable: false);
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;
  bool get hasMore => _nextUrl != null;
  int get count => _count;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  bool isLoadingDetail(Pokemon pokemon) =>
      _loadingDetailUrls.contains(pokemon.url);

  PokemonSpecies? speciesFor(Pokemon pokemon) =>
      pokemon.speciesUrl.isEmpty ? null : _speciesCache[pokemon.speciesUrl];

  bool isLoadingSpecies(Pokemon pokemon) =>
      _loadingSpeciesUrls.contains(pokemon.speciesUrl);

  List<EvolutionStage>? evolutionFor(PokemonSpecies species) =>
      species.evolutionChainUrl.isEmpty
          ? null
          : _evolutionCache[species.evolutionChainUrl];

  bool isLoadingEvolution(PokemonSpecies species) =>
      _loadingEvolutionUrls.contains(species.evolutionChainUrl);

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> loadInitial() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final page = await getPokemonList();
      _pokemons
        ..clear()
        ..addAll(page.pokemons);
      _nextUrl = page.next;
      _count = page.count;
    } on Failure catch (failure) {
      _error = failure.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    final url = _nextUrl;
    if (url == null || _loadingMore) return;

    _loadingMore = true;
    notifyListeners();

    try {
      final page = await loadMorePokemons(url);
      _pokemons.addAll(page.pokemons);
      _nextUrl = page.next;
    } on Failure catch (failure) {
      _error = failure.message;
    } finally {
      _loadingMore = false;
      notifyListeners();
    }
  }

  Future<void> loadDetail(Pokemon pokemon) async {
    if (pokemon.detailLoaded || _loadingDetailUrls.contains(pokemon.url)) {
      return;
    }
    _loadingDetailUrls.add(pokemon.url);
    notifyListeners();

    try {
      await getPokemonDetail(pokemon);
    } on Failure catch (failure) {
      _error = failure.message;
    } finally {
      _loadingDetailUrls.remove(pokemon.url);
      notifyListeners();
    }
  }

  Future<void> loadSpecies(Pokemon pokemon) async {
    final url = pokemon.speciesUrl;
    if (url.isEmpty ||
        _speciesCache.containsKey(url) ||
        _loadingSpeciesUrls.contains(url)) {
      return;
    }
    _loadingSpeciesUrls.add(url);
    notifyListeners();

    try {
      final species = await getPokemonSpecies(url);
      _speciesCache[url] = species;
      if (species.evolutionChainUrl.isNotEmpty) {
        await loadEvolution(species);
      }
    } on Failure catch (failure) {
      _error = failure.message;
    } finally {
      _loadingSpeciesUrls.remove(url);
      notifyListeners();
    }
  }

  Future<void> loadEvolution(PokemonSpecies species) async {
    final url = species.evolutionChainUrl;
    if (url.isEmpty ||
        _evolutionCache.containsKey(url) ||
        _loadingEvolutionUrls.contains(url)) {
      return;
    }
    _loadingEvolutionUrls.add(url);
    notifyListeners();

    try {
      _evolutionCache[url] = await getEvolutionChain(url);
    } on Failure catch (failure) {
      _error = failure.message;
    } finally {
      _loadingEvolutionUrls.remove(url);
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Pokemon pokemon) async {
    try {
      await toggleFavoriteUseCase(pokemon);
    } on Failure catch (failure) {
      _error = failure.message;
    } finally {
      notifyListeners();
    }
  }

  Future<void> refreshFavorites() async {
    try {
      final favoriteUrls = await getFavoritesUseCase();
      for (final pokemon in _pokemons) {
        pokemon.isFavorite = favoriteUrls.contains(pokemon.url);
      }
    } on Failure catch (failure) {
      _error = failure.message;
    } finally {
      notifyListeners();
    }
  }
}
