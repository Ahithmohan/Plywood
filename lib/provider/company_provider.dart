import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CompanyProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? _companyDetails;
  Map<String, dynamic>? get companyDetails => _companyDetails;

  final Dio _dio = Dio();

  Future<void> fetchCompanyDetails() async {
    _isLoading = true;
    notifyListeners();

    const String url =
        "https://plywood-backend-t3v1.onrender.com/api/Settings/all";

    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        _companyDetails = response.data[0]; // assuming only one company config
      } else {
        _companyDetails = null;
      }
    } catch (e) {
      debugPrint("Fetch Company Error: $e");
      _companyDetails = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  // Future<bool> addCompanyDetails({
  //   required String companyName,
  //   required String address,
  //   required String contactNumber,
  //   required String gstin,
  //   required String email,
  //   required String pincode,
  // }) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   const String url =
  //       "https://plywood-backend-t3v1.onrender.com/api/Settings/add";
  //
  //   final data = {
  //     "companyName": companyName,
  //     "address": address,
  //     "contactNumber": contactNumber,
  //     "gstin": gstin,
  //     "email": email,
  //     "pincode": pincode,
  //   };
  //
  //   try {
  //     final response = await _dio.post(url, data: data);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       await fetchCompanyDetails(); // refresh after add
  //       return true;
  //     } else {
  //       debugPrint(
  //           "Add Company Failed: ${response.statusCode} ${response.data}");
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint("Add Company Error: $e");
  //     return false;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
  //update
  Future<bool> updateCompanyDetails({
    required String id,
    required String companyName,
    required String address,
    required String contactNumber,
    required String gstin,
    required String email,
    required String pincode,
  }) async {
    _isLoading = true;
    notifyListeners();

    final String url =
        "https://plywood-backend-t3v1.onrender.com/api/Settings/update/$id";

    final data = {
      "companyName": companyName,
      "address": address,
      "contactNumber": contactNumber,
      "gstin": gstin,
      "email": email,
      "pincode": pincode,
    };

    try {
      final response = await _dio.put(url, data: data);

      if (response.statusCode == 200) {
        await fetchCompanyDetails();
        return true;
      } else {
        debugPrint(
            "Update Company Failed: ${response.statusCode} ${response.data}");
        return false;
      }
    } catch (e) {
      debugPrint("Update Company Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
