import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/pokemon_model.dart';
import '../../data/services/pokemon_service.dart';
import '../widgets/pokemon_card.dart';

final pokemonProvider = FutureProvider<List<PokemonModel>>((ref) async {
  final service = PokemonService();
  return service.fetchPokemonList();
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      _buildPokemonList(),
      _buildPlaceholder('Pantalla 2 - Vacía', Icons.catching_pokemon, Colors.red),
      _buildPlaceholder('Pantalla 3 - También vacía', Icons.videogame_asset, Colors.blue),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon App'),
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => ref.refresh(pokemonProvider),
            ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.catching_pokemon), label: 'Pokémon'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Pantalla 2'),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: 'Pantalla 3'),
        ],
      ),
    );
  }

  Widget _buildPokemonList() {
    final pokemonAsync = ref.watch(pokemonProvider);

    return pokemonAsync.when(
      data: (pokemons) => ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) => PokemonCard(pokemon: pokemons[index]),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: \$error')),
    );
  }

  Widget _buildPlaceholder(String title, IconData icon, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: color),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}