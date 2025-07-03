class StockModel {
  final String id;
  final String name;
  final String category;
  final String size;
  final String thickness;
  final String grade;
  final int quantity;
  final int price;
  final bool stock;

  StockModel({
    required this.id,
    required this.name,
    required this.category,
    required this.size,
    required this.thickness,
    required this.grade,
    required this.quantity,
    required this.price,
    required this.stock,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      size: json['size'],
      thickness: json['thickness'],
      grade: json['grade'],
      quantity: json['quantity'],
      price: json['price'],
      stock: json['stock'],
    );
  }
}
