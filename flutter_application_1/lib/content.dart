class Content {
  final int id;
  final int type;
  final String name;
  final String description;
  bool favorite;

  /// Modèle représentant un contenu
  Content(
      {required this.id,
      required this.type,
      required this.name,
      required this.description,
      required this.favorite});
}
