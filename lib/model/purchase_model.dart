// class PurchaseModel {
//   final String id;
//   final String customerName;
//   final String customerNumber;
//   final String product;
//   final int quantity;
//   final String date;
//   final int price;
//
//   PurchaseModel({
//     required this.id,
//     required this.customerName,
//     required this.customerNumber,
//     required this.product,
//     required this.quantity,
//     required this.date,
//     required this.price,
//   });
//
//   factory PurchaseModel.fromJson(Map<String, dynamic> json) {
//     return PurchaseModel(
//       id: json['_id'] ?? '',
//       customerName: json['customerName'] ?? '',
//       customerNumber: json['customerNumber'].toString(),
//       product: json['product'] ?? '',
//       quantity: json['quantity'] ?? 0,
//       date: json['date'] != null
//           ? json['date'].toString().substring(0, 10) // YYYY-MM-DD
//           : '',
//       price: json['price'] ?? 0,
//     );
//   }
// }

class PurchaseModel {
  final String id;
  final String customerName;
  final String customerNumber;
  final String date;
  final List<Map<String, dynamic>> products;

  PurchaseModel({
    required this.id,
    required this.customerName,
    required this.customerNumber,
    required this.date,
    required this.products,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawProducts = json['products'] ?? [];
    final List<Map<String, dynamic>> parsedProducts =
        rawProducts.map<Map<String, dynamic>>((product) {
      return {
        'product': product['product'] ?? '',
        'quantity': product['quantity'] ?? 0,
        'price': product['price'] ?? 0,
        'balance': product['balance'] ?? 0,
      };
    }).toList();

    return PurchaseModel(
      id: json['_id'] ?? '',
      customerName: json['customerName'] ?? '',
      customerNumber: json['customerNumber'].toString(),
      date:
          json['date'] != null ? json['date'].toString().substring(0, 10) : '',
      products: parsedProducts,
    );
  }
}
