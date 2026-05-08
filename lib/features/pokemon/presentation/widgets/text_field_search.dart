import 'package:flutter/material.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: "Buscar un Pokémon",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (text) =>
          context.read<PokemonProvider>().setSearchQuery(text),
    );
  }
}
