class AdminModel {
  final String id;
  final String username;
  final String email;
  final String contactNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AdminModel({
    required this.id,
    required this.username,
    required this.email,
    required this.contactNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      contactNumber: json['contactNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'contactNumber': contactNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
