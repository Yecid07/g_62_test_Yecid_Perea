import 'package:flutter/material.dart';
import '../../data/models/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            pokemon.imageUrl.isNotEmpty
                ? Image.network(
                    pokemon.imageUrl,
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text('ID: #${pokemon.id}'),
                  Text('Tipo: ${pokemon.type}'),
                  Text('Altura: ${pokemon.height} dm'),
                  Text('Peso: ${pokemon.weight} hg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
