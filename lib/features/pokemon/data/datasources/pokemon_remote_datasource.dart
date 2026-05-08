import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poke_api/core/constants/api_endpoints.dart';
import 'package:poke_api/core/error/exceptions.dart';
import 'package:poke_api/features/pokemon/data/models/evolution_chain_model.dart';
import 'package:poke_api/features/pokemon/data/models/pokemon_model.dart';
import 'package:poke_api/features/pokemon/data/models/pokemon_page_model.dart';
import 'package:poke_api/features/pokemon/data/models/pokemon_species_model.dart';
import 'package:poke_api/features/pokemon/domain/entities/evolution_stage.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonPageModel> getInitial();
  Future<PokemonPageModel> loadMore(String url);
  Future<PokemonDetailDto> getDetail(String url);
  Future<PokemonSpeciesModel> getSpecies(String url);
  Future<List<EvolutionStage>> getEvolutionChain(String url);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;

  PokemonRemoteDataSourceImpl({required this.client});

  @override
  Future<PokemonPageModel> getInitial() => _fetchPage(ApiEndpoints.pokemonList);

  @override
  Future<PokemonPageModel> loadMore(String url) => _fetchPage(url);

  @override
  Future<PokemonDetailDto> getDetail(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ServerException('Detail request failed: ${response.statusCode}');
    }
    return PokemonDetailDto.fromJson(jsonDecode(response.body));
  }

  @override
  Future<PokemonSpeciesModel> getSpecies(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ServerException('Species request failed: ${response.statusCode}');
    }
    return PokemonSpeciesModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<EvolutionStage>> getEvolutionChain(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ServerException(
          'Evolution chain request failed: ${response.statusCode}');
    }
    return EvolutionChainParser.parse(jsonDecode(response.body));
  }

  Future<PokemonPageModel> _fetchPage(String url) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw ServerException('List request failed: ${response.statusCode}');
    }
    return PokemonPageModel.fromJson(jsonDecode(response.body));
  }
}
