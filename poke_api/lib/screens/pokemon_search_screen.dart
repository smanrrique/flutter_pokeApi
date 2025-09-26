import 'package:flutter/material.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';
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
      appBar: AppBar(title: Text("Pokemon Api")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            if (pokemonProvider.loading &&
                (pokemonProvider.response?.listPokemons.isEmpty ?? true))
              Center(child: CircularProgressIndicator()),

            if (!pokemonProvider.loading &&
                (pokemonProvider.response?.listPokemons.isNotEmpty ?? false))
              bodyList(pokemonProvider),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  pokemonProvider.loadMore();
                },
                child: Text('Cargar mas datos'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Estoy aqui no me estra mostrando los pokemos puede ser que no esta entrando a la linea 51
  Widget bodyList(PokemonProvider pokemonProvider) {
    var pokemons = pokemonProvider.response?.listPokemons ?? [];

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 2 columnas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemCount: pokemonProvider.response!.listPokemons.length ?? 0,
        itemBuilder: (context, index) {
          return itemPokemon(pokemons[index]);
        },
      ),
    );
  }

  Widget itemPokemon(Pokemon item) {
    return Column(
      children: [
        item.urlImage != null
            ? Image.network(
                item.urlImage!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported, size: 80),
        const SizedBox(height: 5),
        Text(item.name),
      ],
    );
  }
}
