import 'package:flutter/material.dart';
import 'package:poke_api/features/pokemon/presentation/providers/pokemon_provider.dart';
import 'package:poke_api/features/pokemon/presentation/screens/pokemon_search_screen.dart';
import 'package:poke_api/injection_container.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = await AppDependencies.bootstrap();
  runApp(MainApp(dependencies: dependencies));
}

class MainApp extends StatelessWidget {
  final AppDependencies dependencies;

  const MainApp({super.key, required this.dependencies});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PokemonProvider>.value(
          value: dependencies.pokemonProvider,
        ),
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
          child: const PokemonSearchScreen(),
        ),
      ),
    );
  }
}
