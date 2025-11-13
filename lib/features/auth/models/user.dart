class User {
  final int id;
  final String name;
  final String email;
  final String username;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'username': username};
  }
}
