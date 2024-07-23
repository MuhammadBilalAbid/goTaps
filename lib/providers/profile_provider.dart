import 'package:flutter/material.dart';
import 'package:gotaps/model/userdetails_model.dart';

class ProfileProvider with ChangeNotifier {
  late User _user;
  bool _isLoading = true;

  User get user => _user;
  bool get isLoading => _isLoading;

  ProfileProvider() {
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    try {
      _isLoading = true;
      notifyListeners();

      final loadedUser = await User.loadUser();
      if (loadedUser != null) {
        _user = loadedUser;
      } else {
        throw Exception('User data is null');
      }
    } catch (e) {
      print("Failed to load user: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateUser(User updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  void updateCoverImage(String imagePath) {
    _user.backgroundImage = imagePath;
    notifyListeners();
  }

  void updateProfileImage(String imagePath) {
    _user.profileImage = imagePath;
    notifyListeners();
  }
}
