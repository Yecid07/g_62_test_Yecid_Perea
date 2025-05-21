import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonService {
  Future<List<PokemonModel>> fetchPokemonList() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];

      List<Future<PokemonModel>> futureDetails = results.map((pokemon) async {
        final detailRes = await http.get(Uri.parse(pokemon['url']));
        if (detailRes.statusCode == 200) {
          final detailJson = json.decode(detailRes.body);
          return PokemonModel.fromDetailJson(detailJson);
        } else {
          throw Exception('Error al cargar detalles del Pokémon');
        }
      }).toList();

      return await Future.wait(futureDetails);
    } else {
      throw Exception('Error al cargar los Pokémon');
    }
  }
}