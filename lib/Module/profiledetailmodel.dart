class User {
  final String name;
  final String email;
  final String address;
  final String photoUrl;

  User({
    required this.name,
    required this.email,
    required this.address,
    required this.photoUrl,
  });

  // Factory method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      photoUrl: json['photoUrl'],
    );
  }
}
