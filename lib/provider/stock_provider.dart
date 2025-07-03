import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/stock_model.dart';

class StockProvider extends ChangeNotifier {
  List<StockModel> _stocks = [];
  List<StockModel> get stocks => _stocks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchStocks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Dio().get(
        'http://plywood-backend-t3v1.onrender.com/api/Plywood/getStockAvailable',
      );

      if (response.statusCode == 200) {
        _stocks = (response.data as List)
            .map((item) => StockModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint('Fetch stock error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
