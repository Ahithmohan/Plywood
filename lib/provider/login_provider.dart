import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:plywood/model/admin_model.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _adminId;
  AdminModel? _adminDetails;
  bool get isLoading => _isLoading;
  String? get adminId => _adminId;
  AdminModel? get adminDetails => _adminDetails;

  //Login section
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

  // Get admin details
  Future<void> fetchAdminDetails() async {
    final url =
        "https://plywood-backend-t3v1.onrender.com/api/admin/adminprofile/$_adminId";
    try {
      final response = await Dio()
          .get(url, options: Options(contentType: Headers.jsonContentType));
      if (response.statusCode == 200) {
        print("success${response.data}");
        _adminDetails = AdminModel.fromJson(response.data);
        notifyListeners();
      } else {
        print("Failed to fetch admin details: ${response.data}");
      }
    } catch (e) {
      print("Error fetching admin details: $e");
    }
  }

  // Update Admin Details
  Future<bool> updateAdminDetails(
      String username, String password, String email, String phone) async {
    _isLoading = true;
    notifyListeners();
    final url =
        "https://plywood-backend-t3v1.onrender.com/api/admin/updateadminprofile/$adminId";
    print("url:$url");
    try {
      final response = await Dio().put(
        url,
        data: {
          "username": username,
          "email": email,
          "password": password,
          "contactNumber": phone,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      if (response.statusCode == 200) {
        print("successfully${response.data}");
        // _adminDetails = AdminModel.fromJson(response.data);
        // notifyListeners();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        print("Update failed: ${response.statusCode}");
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Error updating admin details: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
