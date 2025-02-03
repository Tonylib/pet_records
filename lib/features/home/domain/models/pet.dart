class Pet {
  final String id;
  final String name;
  final String species;
  final String breed;
  final DateTime dateOfBirth;

  const Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.dateOfBirth,
  });

  @override
  String toString() =>
      'Pet(id: $id, name: $name, species: $species, breed: $breed, dateOfBirth: $dateOfBirth)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pet &&
        other.id == id &&
        other.name == name &&
        other.species == species &&
        other.breed == breed &&
        other.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode => Object.hash(id, name, species, breed, dateOfBirth);
}
