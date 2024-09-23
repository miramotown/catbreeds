class CatBreedEntity {

  final String name;
  final String origin;
  final int intelligence;
  final String description;
  final int adaptability;
  final String lifeSpan;
  final String imagePath;

  CatBreedEntity({
    required this.name,
    required this.origin,
    required this.intelligence,
    required this.description,
    required this.adaptability,
    required this.lifeSpan,
    required this.imagePath
  });


  CatBreedEntity copyWith({
    String? name,
    String? origin,
    int? intelligence,
    String? description,
    int? adaptability,
    String? lifeSpan,
    String? imagePath,

  }) => CatBreedEntity(
    name: name ?? this.name,
    origin: origin ?? this.origin,
    intelligence: intelligence ?? this.intelligence,
    description: description ?? this.description,
    adaptability: adaptability ?? this.adaptability,
    lifeSpan: lifeSpan ?? this.lifeSpan,
    imagePath: imagePath ?? this.imagePath,
  );

}