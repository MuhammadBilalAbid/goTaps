import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gotaps/model/platfrom_model.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/utils/app_api.dart';

class AddLinkMainProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  bool _isLoading = true;

  List<Category> get categories => _filteredCategories;
  bool get isLoading => _isLoading;

  AddLinkMainProvider() {
    fetchCategories();
  }

  fetchCategories() async {
    User? user = await User.loadUser();
    String authToken = user!.token;
    log(authToken);
    try {
      Map<String, dynamic> header = {
        'Accept': 'application/json',
        'Device-ID': '12345',
        'Authorization': 'Bearer $authToken',
      };
      final response = await Dio().get(
        ApiLinks.getCategories,
        options: Options(headers: header),
      );
      ResponseData responseData = ResponseData.fromJson(response.data);
      _categories = responseData.categories;
      _filteredCategories = _categories;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error fetching categories: $error');
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      _filteredCategories = _categories;
    } else {
      _filteredCategories = _categories
          .map((category) {
            final filteredPlatforms = category.platforms
                .where((platform) =>
                    platform.title.toLowerCase().contains(query.toLowerCase()))
                .toList();
            return Category(
              id: category.id,
              name: category.name,
              title_en: category.title_en,
              title_tr: category.title_tr,
              totalPlatforms: category.totalPlatforms,
              platforms: filteredPlatforms,
            );
          })
          .where((category) => category.platforms.isNotEmpty)
          .toList();
    }
    notifyListeners();
  }
}
