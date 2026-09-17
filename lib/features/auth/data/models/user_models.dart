import 'package:blog_app/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
  });

  // Convert JSON → UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userMetadata = json['user_metadata'];
    final name =
        json['name'] ?? (userMetadata is Map ? userMetadata['name'] : null);

    return UserModel(
      id: json['id'] as String,
      name: name as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }

  // Convert UserModel → JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }

  // Create a new UserModel with changed values
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
