import 'dart:convert';

class User {
  String? username;
  String? password;
  String? contact;
  String? token;

  User({this.username, this.password, this.contact, this.token});

  @override
  String toString() {
    return 'User(username: $username, password: $password, contact: $contact, token: $token)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        username: data['username'] as String?,
        password: data['password'] as String?,
        contact: data['contact'] as String?,
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
        'contact': contact,
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
