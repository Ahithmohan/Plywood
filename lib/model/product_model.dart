class ProductModel {
  final String id;
  final String name;
  final String category;
  final String size;
  final String thickness;
  final String grade;
  final int quantity;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v; // for __v

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.size,
    required this.thickness,
    required this.grade,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      size: json['size'],
      thickness: json['thickness'],
      grade: json['grade'],
      quantity: json['quantity'],
      price: json['price'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'size': size,
      'thickness': thickness,
      'grade': grade,
      'quantity': quantity,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
