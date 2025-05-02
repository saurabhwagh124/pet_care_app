class Users {
  Users({
    required this.id,
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.phoneNumber,
    required this.role,
    required this.emailVerified,
  });

  final int? id;
  final String? uid;
  final String? email;
  String? displayName;
  final String? photoUrl;
  String? phoneNumber;
  final String? role;
  final bool? emailVerified;

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json["id"],
      uid: json["uid"],
      email: json["email"],
      displayName: json["displayName"],
      photoUrl: json["photoUrl"],
      phoneNumber: json["phoneNumber"],
      role: json["role"],
      emailVerified: json["emailVerified"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "email": email,
        "displayName": displayName,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "role": role,
        "emailVerified": emailVerified,
      };

  @override
  String toString() {
    return "$id, $uid, $email, $displayName, $photoUrl, $phoneNumber, $role, $emailVerified, ";
  }
}
