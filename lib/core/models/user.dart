class User {
  final int? id;
  final String? username;
  final String? password;
  final String? role;

  const User({this.id, this.username, this.password, this.role});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'role': role,
      };
}
