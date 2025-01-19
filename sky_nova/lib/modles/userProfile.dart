class SkyNova {
  String id;
  String name;
  String email;
  String password;
  bool isOnline;
  DateTime createdAt;

  // Constructor
  SkyNova({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.isOnline,
    required this.createdAt,
  });

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'isOnline': isOnline,
      'createdAt':
          createdAt.toIso8601String(), // Convert DateTime to ISO8601 string
    };
  }

  // Create User object from JSON
  factory SkyNova.fromJson(Map<String, dynamic> json) {
    return SkyNova(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      isOnline: json['isOnline'] ?? false,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
