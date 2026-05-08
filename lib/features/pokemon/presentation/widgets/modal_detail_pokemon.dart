import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/evolution_chain_widget.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/pokemon_description.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/stats_pokemon.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/type_pokemon.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/weight_and_height.dart';
import 'package:provider/provider.dart';

class FrontModalDetailPokemon extends StatefulWidget {
  final Pokemon pokemon;

  const FrontModalDetailPokemon({super.key, required this.pokemon});

  @override
  State<FrontModalDetailPokemon> createState() =>
      _FrontModalDetailPokemonState();
}

class _FrontModalDetailPokemonState extends State<FrontModalDetailPokemon> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_loadDataIfNeeded);
  }

  Future<void> _loadDataIfNeeded() async {
    if (!mounted) return;
    final provider = context.read<PokemonProvider>();
    if (!widget.pokemon.detailLoaded) {
      await provider.loadDetail(widget.pokemon);
    }
    if (!mounted) return;
    if (widget.pokemon.speciesUrl.isNotEmpty) {
      await provider.loadSpecies(widget.pokemon);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PokemonProvider>();
    final isLoadingDetail = provider.isLoadingDetail(widget.pokemon);
    final species = provider.speciesFor(widget.pokemon);
    final isLoadingSpecies = provider.isLoadingSpecies(widget.pokemon);
    final evolution = species == null ? null : provider.evolutionFor(species);
    final isLoadingEvolution =
        species != null && provider.isLoadingEvolution(species);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 220,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: 200,
                maxHeight: MediaQuery.of(context).size.height * 0.75,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            IconButton(
                              onPressed: () =>
                                  provider.toggleFavorite(widget.pokemon),
                              icon: Icon(
                                Icons.favorite,
                                color: widget.pokemon.isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Text(
                          widget.pokemon.name,
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (isLoadingDetail && !widget.pokemon.detailLoaded)
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          )
                        else ...[
                          TypePokemon(pokemon: widget.pokemon),
                          const SizedBox(height: 12),
                          WeightAndHeight(pokemon: widget.pokemon),
                          const SizedBox(height: 12),
                          StatsPokemon(pokemon: widget.pokemon),
                          const SizedBox(height: 12),
                          _SectionTitle(title: 'Descripción'),
                          if (isLoadingSpecies && species == null)
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          else if (species != null)
                            PokemonDescription(species: species)
                          else
                            Text(
                              'Sin descripción disponible',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          const SizedBox(height: 12),
                          _SectionTitle(title: 'Evolución'),
                          if (isLoadingEvolution && evolution == null)
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          else if (evolution != null)
                            EvolutionChainWidget(stages: evolution)
                          else
                            Text(
                              'Sin cadena de evolución',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          const SizedBox(height: 8),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              right: 0,
              child: Center(
                child: widget.pokemon.imageUrl.isNotEmpty
                    ? SvgPicture.network(
                        widget.pokemon.imageUrl,
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                      )
                    : const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey.shade800,
        ),
      ),
    );
  }
}
