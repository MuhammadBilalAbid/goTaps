import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gotaps/model/platfrom_model.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/utils/app_api.dart';

class PlatformsProvider with ChangeNotifier {
  List<Platform> _platforms = [];
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  List<Platform> _filteredPlatforms = [];
  bool _isLoading = true;

  List<Platform> get platforms => _platforms;
  List<Category> get categories => _filteredCategories;
  List<Platform> get filteredPlatforms => _filteredPlatforms;
  bool get isLoading => _isLoading;

  PlatformsProvider() {
    fetchPlatforms();
  }

  Future<void> fetchPlatforms() async {
    _isLoading = true;
    notifyListeners();

    try {
      var user = await User.loadUser();
      if (user == null) {
        throw Exception("User not found");
      }

      String authToken = user.token;
      log(authToken);

      Map<String, dynamic> headers = {
        'Accept': 'application/json',
        'Device-ID': '12345',
        'Authorization': 'Bearer $authToken',
      };

      final response = await Dio().get(
        ApiLinks.getCategories,
        options: Options(headers: headers),
      );

      ResponseData responseData = ResponseData.fromJson(response.data);
      _categories = responseData.categories;

      _filteredCategories = _categories;

      _filteredPlatforms = _categories
          .expand((category) => category.platforms)
          .where(
              (platform) => platform.path != null && platform.path!.isNotEmpty)
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      log('Error fetching categories: $error');
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

  Future<void> addOrUpdatePlatform(
      Platform platform, String path, String token) async {
    Map<String, dynamic> addNewPlatform = {
      'platform_id': platform.id,
      'path': path,
      'label': platform.title,
    };

    Dio dio = Dio();
    try {
      Response response = await dio.post(
        ApiLinks.addPlatform,
        data: addNewPlatform,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['message'] == 'Platform added successfully' ||
            response.data['message'] == 'Platform updated successfully') {
          await fetchPlatforms();
        } else {
          log('Platform already added');
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log("DioError with response: ${e.response}");
      } else {
        log("DioError without response: $e");
      }
    } catch (e) {
      log("Error: $e");
    }
  }

  void removePlatform(Platform platform) {
    _filteredPlatforms.removeWhere((p) => p.id == platform.id);
    fetchPlatforms();
  }
}
