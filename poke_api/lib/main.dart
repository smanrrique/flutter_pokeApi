import 'package:flutter/material.dart';
import 'package:poke_api/providers/pokemon_provider.dart';
import 'package:poke_api/screens/pokemon_search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider())
      ],
      child: MaterialApp(
        title: 'Pokemon App',
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightBlue, Colors.white],
            ),
          ),
          child: PokemonSearchScreen(),
        ),
      ),
    );
  }
}
