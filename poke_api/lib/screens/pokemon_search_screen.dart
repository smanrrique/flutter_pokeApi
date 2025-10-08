import 'package:flutter/material.dart';
import 'package:poke_api/components/BodyList.dart';
import 'package:poke_api/components/CustomAppBar.dart';
import 'package:poke_api/components/ElevateButtonLoadMore.dart';
import 'package:poke_api/components/FloatingButtonFavorite.dart';
import 'package:poke_api/components/TextFieldSearch.dart';
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
    final pokemonProvider = context.watch<PokemonProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextfieldSearch(),
            const SizedBox(height: 8),

            if (pokemonProvider.loading)
              Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),

            if (!pokemonProvider.loading &&
                (pokemonProvider.response?.listPokemons.isNotEmpty ?? false))
              BodyList(),
            const SizedBox(height: 8),
          ],
        ),
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 16,
            left: MediaQuery.of(context).size.width * 0.064,
            right: 0,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.12,
                child: ElevateButtonLoadMore(
                  loadMore: () {
                    pokemonProvider.loadMore();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.01,
            child: SizedBox(
              child: FloatingButtonFavorite(),
            ),
          ),
        ],
      ),
    );
  }
}

