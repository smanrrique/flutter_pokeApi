import 'package:flutter/material.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/card_pokemon.dart';
import 'package:provider/provider.dart';

class BodyList extends StatefulWidget {
  final List<Pokemon> pokemons;
  final bool enableInfiniteScroll;

  const BodyList({
    super.key,
    required this.pokemons,
    this.enableInfiniteScroll = true,
  });

  @override
  State<BodyList> createState() => _BodyListState();
}

class _BodyListState extends State<BodyList> {
  static const double _loadMoreThreshold = 300;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.enableInfiniteScroll) {
      _controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    final position = _controller.position;
    if (position.pixels < position.maxScrollExtent - _loadMoreThreshold) {
      return;
    }
    final provider = context.read<PokemonProvider>();
    if (provider.hasMore && !provider.loadingMore && provider.searchQuery.isEmpty) {
      provider.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadingMore =
        widget.enableInfiniteScroll && context.watch<PokemonProvider>().loadingMore;

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _controller,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.9,
              ),
              itemCount: widget.pokemons.length,
              itemBuilder: (context, index) {
                return CardPokemon(item: widget.pokemons[index]);
              },
            ),
          ),
          if (loadingMore)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
            ),
        ],
      ),
    );
  }
}
