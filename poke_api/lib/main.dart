import 'package:flutter/material.dart';
import 'package:poke_api/providers/pokemon_provider.dart';
import 'package:poke_api/screens/pokemon_search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PokemonProvider()..loadPokemons(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      debugShowCheckedModeBanner: false,
      home: const PokemonSearchScreen(),
    );
  }
}
