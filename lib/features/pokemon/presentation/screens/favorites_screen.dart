import 'package:flutter/material.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/body_list.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<PokemonProvider>().favorites;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: favorites.isEmpty
            ? const Center(child: Text('Aún no tienes favoritos'))
            : Column(
                children: [BodyList(pokemons: favorites)],
              ),
      ),
    );
  }
}
