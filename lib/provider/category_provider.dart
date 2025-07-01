import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Map<String, dynamic>> _categories = [];

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get categories => _categories;

  final Dio _dio = Dio();

  // Add Category
  Future<bool> addCategory(String type) async {
    _isLoading = true;
    notifyListeners();

    const url = 'https://plywood-backend-t3v1.onrender.com/api/Category/add';
    try {
      final response = await _dio.post(url, data: {"type": type});
      if (response.statusCode == 200 || response.statusCode == 201) {
        await getCategories();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Add category error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get All Categories
  Future<void> getCategories() async {
    _isLoading = true;
    notifyListeners();

    const url = 'https://plywood-backend-t3v1.onrender.com/api/Category/all';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data is List) {
        _categories = List<Map<String, dynamic>>.from(response.data);
      }
    } catch (e) {
      debugPrint("Get categories error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete Category by ID
  Future<bool> deleteCategory(String id) async {
    _isLoading = true;
    notifyListeners();

    final url =
        'https://plywood-backend-t3v1.onrender.com/api/Category/delete/$id';
    try {
      final response = await _dio.delete(url);
      if (response.statusCode == 200) {
        await getCategories();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Delete category error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
