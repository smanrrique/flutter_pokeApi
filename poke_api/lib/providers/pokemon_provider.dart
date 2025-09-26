import 'package:flutter/material.dart';
import 'package:poke_api/data/model/pokemon_response.dart';
import 'package:poke_api/data/repository/pokemon_repository.dart';

class PokemonProvider extends ChangeNotifier {
  final Repository repository = Repository();

  PokemonResponse? response;
  bool loading = false;

  Future<void> loadPokemons() async {
    loading = true;
    notifyListeners();

    response = await repository.getPokemons();   
    loading = false;
    notifyListeners(); 
  }

  Future<void> loadMore() async {
    loading = true;
    final newResponse = await repository.loadMore(response!.next);

    if(newResponse != null){
      response!.listPokemons.addAll(newResponse.listPokemons);
      response!.next = newResponse.next;
    }
    loading = false;
    notifyListeners(); 
  }
  
}