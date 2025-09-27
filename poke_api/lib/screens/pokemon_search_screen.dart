import 'package:flutter/material.dart';
import 'package:poke_api/components/BodyList.dart';
import 'package:poke_api/components/CustomAppBar.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';
import 'package:poke_api/data/model/pokemon_response.dart';
import 'package:poke_api/data/repository/pokemon_repository.dart';
import 'package:provider/provider.dart';
import 'package:poke_api/providers/pokemon_provider.dart';

class PokemonSearchScreen extends StatefulWidget {
  const PokemonSearchScreen({super.key});

  @override
  State<PokemonSearchScreen> createState() => _PokemonSearchScreenState();
}

class _PokemonSearchScreenState extends State<PokemonSearchScreen> {
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<PokemonProvider>(context, listen: false).loadPokemons(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Busca un Pokemon",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {},
            ),
            const SizedBox(height: 8),

            if (pokemonProvider.loading &&
                (pokemonProvider.response?.listPokemons.isEmpty ?? true))
              Center(child: CircularProgressIndicator()),

            if (!pokemonProvider.loading &&
                (pokemonProvider.response?.listPokemons.isNotEmpty ?? false))
              BodyList(pokemonResponse: pokemonProvider.response!),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                pokemonProvider.loadMore();
              },
              child: Text('Cargar mas datos'),
            ),
          ],
        ),
      ),
    );
  }
}
