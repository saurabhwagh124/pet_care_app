class UserPetModel {
  UserPetModel({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.description,
    required this.age,
    required this.height,
    required this.weight,
    required this.photoUrl,
    required this.ownerEmail,
  });

  final int? id;
  late final String? name;
  final String? species;
  late final String? breed;
  final String? description;
  late final double? age;
  late final double? height;
  late final double? weight;
  final String? photoUrl;
  final String? ownerEmail;

  factory UserPetModel.fromJson(Map<String, dynamic> json) {
    return UserPetModel(
      id: json["id"],
      name: json["name"],
      species: json["species"],
      breed: json["breed"],
      description: json["description"],
      age: json["age"],
      height: json["height"],
      weight: json["weight"],
      photoUrl: json["photoUrl"],
      ownerEmail: json["ownerEmail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "species": species,
        "breed": breed,
        "description": description,
        "age": age,
        "height": height,
        "weight": weight,
        "photoUrl": photoUrl,
        "ownerEmail": ownerEmail,
      };

  @override
  String toString() {
    return "$id, $name, $species, $breed, $description, $age, $height, $weight, $photoUrl, $ownerEmail, ";
  }
}
