class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final int height;
  final int weight;
  final String type;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.height,
    required this.weight,
    required this.type,
  });

  factory PokemonModel.fromDetailJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'] ?? '',
      height: json['height'],
      weight: json['weight'],
      type: json['types'][0]['type']['name'],
    );
  }
}
