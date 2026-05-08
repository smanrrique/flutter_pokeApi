class Pokemon {
  final String name;
  final String url;
  String imageUrl;
  String speciesUrl;
  List<String> types;
  Map<String, String> stats;
  int weight;
  int height;
  bool isFavorite;
  bool detailLoaded;

  Pokemon({
    required this.name,
    required this.url,
    this.imageUrl = '',
    this.speciesUrl = '',
    this.types = const [],
    this.stats = const {},
    this.weight = 0,
    this.height = 0,
    this.isFavorite = false,
    this.detailLoaded = false,
  });
}
