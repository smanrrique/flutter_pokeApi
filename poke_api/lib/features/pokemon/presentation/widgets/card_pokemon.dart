import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:poke_api/features/pokemon/presentation/widgets/modal_detail_pokemon.dart';
import 'package:provider/provider.dart';

class CardPokemon extends StatefulWidget {
  final Pokemon item;
  const CardPokemon({super.key, required this.item});

  @override
  State<CardPokemon> createState() => _CardPokemonState();
}

class _CardPokemonState extends State<CardPokemon> {
  @override
  void initState() {
    super.initState();
    if (!widget.item.detailLoaded) {
      Future.microtask(() {
        if (!mounted) return;
        context.read<PokemonProvider>().loadDetail(widget.item);
      });
    }
  }

  void _openDetail(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Cerrar",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FrontModalDetailPokemon(pokemon: widget.item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
    final item = widget.item;

    return GestureDetector(
      onTap: () => _openDetail(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              item.imageUrl.isNotEmpty
                  ? Expanded(
                      child: SvgPicture.network(
                        item.imageUrl,
                        fit: BoxFit.contain,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              const SizedBox(height: 10),
              Text(
                item.name,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _openDetail(context),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            Colors.lightBlue.shade50,
                          ),
                        ),
                        child: Text(
                          "Ver",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => pokemonProvider.toggleFavorite(item),
                        icon: Icon(
                          Icons.favorite,
                          color: item.isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
