import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/stock_model.dart';

class StockProvider extends ChangeNotifier {
  List<StockModel> _stocks = [];
  List<StockModel> get stocks => _stocks;

  String _searchText = '';
  String get searchText => _searchText;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<StockModel> get filteredStocks {
    if (_searchText.isEmpty) return _stocks;
    return _stocks
        .where((stock) =>
            stock.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  // void setSearchText(String text) {
  //   _searchText = text;
  //   notifyListeners();
  // }
  void setSearchText(String text) {
    if (_searchText != text) {
      _searchText = text;
      notifyListeners();
    }
  }

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
