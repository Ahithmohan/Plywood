import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/purchase_model.dart';

class PurchaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<PurchaseModel> _purchaseList = [];
  List<PurchaseModel> get purchaseList => _purchaseList;

  //add purchases
  Future<bool> addPurchase({
    required String customerName,
    required String customerNumber, // <- added
    required String product,
    required int quantity,
    required String date,
    required int price,
  }) async {
    _isLoading = true;
    notifyListeners();

    final url = "https://plywood-backend-t3v1.onrender.com/api/Purchase/add";

    final data = {
      "customerName": customerName,
      "customerNumber": customerNumber, // <- added
      "product": product,
      "quantity": quantity,
      "date": date,
      "price": price,
    };

    debugPrint("Sending purchase data: $data");

    try {
      final response = await Dio().post(
        url,
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
          headers: {"Content-Type": "application/json"},
        ),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Response: ${response.data}");

      _isLoading = false;
      notifyListeners();

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Purchase API error: $e");
      return false;
    }
  }

  //fetch all purchases
  Future<void> fetchPurchases() async {
    _isLoading = true;
    notifyListeners();

    const url = "https://plywood-backend-t3v1.onrender.com/api/Purchase/all";

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final List data = response.data;
        _purchaseList =
            data.map((json) => PurchaseModel.fromJson(json)).toList();
      } else {
        debugPrint(
            "Failed to fetch purchases. Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Fetch purchases error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  // update purchase
  Future<bool> updatePurchase({
    required String id,
    required String customerName,
    required String customerNumber,
    required String product,
    required int quantity,
    required String date,
    required int price,
  }) async {
    _isLoading = true;
    notifyListeners();

    final url =
        "https://plywood-backend-t3v1.onrender.com/api/Purchase/update/$id";

    final data = {
      "customerName": customerName,
      "customerNumber": customerNumber,
      "product": product,
      "quantity": quantity,
      "date": date,
      "price": price,
    };

    try {
      final response = await Dio().put(
        url,
        data: data,
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
          headers: {"Content-Type": "application/json"},
        ),
      );

      _isLoading = false;
      notifyListeners();

      return response.statusCode == 200;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Update API error: $e");
      return false;
    }
  }
}
