class Pet {
  final String id;
  final String name;
  final String species;
  final String breed;
  final int age;

  const Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
  });

  @override
  String toString() =>
      'Pet(id: $id, name: $name, species: $species, breed: $breed, age: $age)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pet &&
        other.id == id &&
        other.name == name &&
        other.species == species &&
        other.breed == breed &&
        other.age == age;
  }

  @override
  int get hashCode => Object.hash(id, name, species, breed, age);
}
