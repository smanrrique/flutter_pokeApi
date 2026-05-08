import 'package:flutter/material.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:poke_api/features/pokemon/presentation/screens/favorites_screen.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/body_list.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/custom_app_bar.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/floating_button_favorite.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/text_field_search.dart';
import 'package:provider/provider.dart';

class PokemonSearchScreen extends StatefulWidget {
  const PokemonSearchScreen({super.key});

  @override
  State<PokemonSearchScreen> createState() => _PokemonSearchScreenState();
}

class _PokemonSearchScreenState extends State<PokemonSearchScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<PokemonProvider>().loadInitial();
    });
  }

  void _showFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FavoritesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
    final pokemons = pokemonProvider.pokemons;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextFieldSearch(),
            const SizedBox(height: 8),
            if (pokemonProvider.loading)
              const Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            if (!pokemonProvider.loading && pokemons.isNotEmpty)
              BodyList(pokemons: pokemons),
            const SizedBox(height: 8),
          ],
        ),
      ),
      floatingActionButton:
          FloatingButtonFavorite(onShowFavorites: _showFavorites),
    );
  }
}
