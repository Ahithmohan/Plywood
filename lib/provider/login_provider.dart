import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _adminId;
  bool get isLoading => _isLoading;
  String? get adminId => _adminId;

  Future<bool> login(
    String username,
    String password,
  ) async {
    _isLoading = true;
    notifyListeners();
    final url =
        "https://plywood-backend-t3v1.onrender.com/api/admin/adminSignin";
    print("url: $url");
    try {
      final response = await Dio().post(
        url,
        data: {"username": username, "password": password},
        options: Options(contentType: Headers.jsonContentType),
      );
      print("response: ${response.data}");
      if (response.statusCode == 200) {
        print("login success${response.data}");
        _adminId = response.data['admin']?['id'];
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Login error: $e"); // <-- Add this

      _isLoading = false;
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
