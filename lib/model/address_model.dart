class AddressModel {
  AddressModel({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.userEmail,
  });

  final int? id;
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final String? userEmail;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"],
      street: json["street"],
      city: json["city"],
      state: json["state"],
      postalCode: json["postalCode"],
      country: json["country"],
      userEmail: json["userEmail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "country": country,
        "userEmail": userEmail,
      };

  @override
  String toString() {
    return "$id, $street, $city, $state, $postalCode, $country, $userEmail, ";
  }
}
