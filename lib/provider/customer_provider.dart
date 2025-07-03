import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CustomerProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Map<String, dynamic>> _customers = [];
  List<Map<String, dynamic>> get customers => _customers;

  final String _baseUrl =
      "https://plywood-backend-t3v1.onrender.com/api/customers";

  /// Add a customer
  Future<bool> addCustomer({
    required String name,
    required String phone,
  }) async {
    _isLoading = true;
    notifyListeners();

    final data = {
      "name": name,
      "phone": phone,
    };

    try {
      final response = await Dio().post(
        "$_baseUrl/add",
        data: data,
        options: Options(
          headers: {"Content-Type": "application/json"},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint("Add customer failed: ${response.data}");
        return false;
      }
    } catch (e) {
      debugPrint("Add customer error: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Fetch all customers (optional if you plan to show customer list)
  Future<void> fetchCustomers() async {
    _isLoading = true;
    notifyListeners();

    const url = "https://plywood-backend-t3v1.onrender.com/api/customers/all";

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final List data = response.data;
        _customers = data
            .map((e) => {
                  'id': e['_id'],
                  'name': e['name'],
                  'phone': e['phone'],
                })
            .toList();
      }
    } catch (e) {
      debugPrint("Fetch customer error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
