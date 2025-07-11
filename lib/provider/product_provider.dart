import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;
  bool _hasLoaded = false;

  // Future<bool> addProduct(Map<String, dynamic> productData) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final response = await Dio().post(
  //       'https://plywood-backend-t3v1.onrender.com/api/Plywood/add',
  //       data: productData,
  //     );
  //     _isLoading = false;
  //     notifyListeners();
  //     return response.statusCode == 200 || response.statusCode == 201;
  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     print("Add Product Error: $e");
  //     return false;
  //   }
  // }

  String _searchText = '';
  String get searchText => _searchText;

  List<ProductModel> get filteredProducts {
    if (_searchText.isEmpty) return _products;
    return _products
        .where((product) =>
            product.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<bool> addProduct(Map<String, dynamic> productData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await Dio().post(
        'https://plywood-backend-t3v1.onrender.com/api/Plywood/add',
        data: productData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _hasLoaded = false; // force fetch
        await fetchProducts(); // refresh list
        return true;
      }

      return false;
    } catch (e) {
      print("Add Product Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    if (_hasLoaded) return;
    _isLoading = true;
    notifyListeners();
    try {
      final response = await Dio()
          .get('https://plywood-backend-t3v1.onrender.com/api/Plywood/all');
      final List data = response.data;
      _products = data.map((item) => ProductModel.fromJson(item)).toList();
      _hasLoaded = true;
    } catch (e) {
      print('Error: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  // delete product
  Future<bool> deleteProduct(String productId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await Dio().delete(
        'https://plywood-backend-t3v1.onrender.com/api/Plywood/delete/$productId',
      );

      // Remove from local list if delete is successful
      if (response.statusCode == 200) {
        _products.removeWhere((product) => product.id == productId);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("Delete Product Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //update product
  Future<bool> updateProduct(
      String id, Map<String, dynamic> productData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await Dio().put(
        'https://plywood-backend-t3v1.onrender.com/api/Plywood/update/$id',
        data: productData,
      );
      if (response.statusCode == 200) {
        _hasLoaded = false;
        await fetchProducts();
        return true;
      }
      return false;
    } catch (e) {
      print("Update Product Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // get product by id
  Future<ProductModel?> getProductById(String productId) async {
    try {
      final response = await Dio().get(
        'https://plywood-backend-t3v1.onrender.com/api/Plywood/$productId',
      );
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Get Product by ID Error: $e");
      return null;
    }
  }

  //add stock toggle
  Future<bool> toggleProductStock(String id, bool currentStock) async {
    try {
      final response = await Dio().put(
        'https://plywood-backend-t3v1.onrender.com/api/Plywood/update/$id',
        data: {
          'stock': !currentStock,
        },
      );

      if (response.statusCode == 200) {
        _hasLoaded = false;
        await fetchProducts(); // refresh cache
        return true;
      }
      return false;
    } catch (e) {
      print("Toggle Stock Error: $e");
      return false;
    }
  }
}
