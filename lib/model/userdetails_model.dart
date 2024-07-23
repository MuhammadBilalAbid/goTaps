import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  String firstName;
  final String? lastName;
  final String email;
  final String username;
  final String phone;
  final int status;
  final int isBackgroundImage;
  final int userDirect;
  String address;
  final String? workPosition;
  final int gender;
  final int tiks;
  final int private;
  final int verified;
  final int featured;
  String bio;
  final String? fcmToken;
  final DateTime? dob;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? backgroundColor;
  String backgroundImage;
  String profileImage;
  final String token;
  final dynamic isSuspended;

  User({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.status,
    required this.isBackgroundImage,
    required this.userDirect,
    required this.address,
    this.workPosition,
    required this.gender,
    required this.tiks,
    required this.private,
    required this.verified,
    required this.featured,
    required this.bio,
    this.fcmToken,
    this.dob,
    required this.createdAt,
    required this.updatedAt,
    this.backgroundColor,
    required this.backgroundImage,
    required this.profileImage,
    required this.token,
    this.isSuspended,
  });

  static Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  static Future<User?> loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }
    return null;
  }

  static void deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static User? _instance;

  static Future<User> getInstance() async {
    _instance ??= await _initializeUser();
    return _instance!;
  }

  static void updateInstance(Map<String, dynamic> json) {
    _instance = User.fromJson(json);
  }

  static Future<User> _initializeUser() async {
    // Replace this with actual initialization logic from your API or storage
    const jsonString =
        '{"id": 1, "first_name": "John", "email": "john@example.com", "username": "john_doe", "phone": "1234567890", "status": 1, "is_background_image": 1, "user_direct": 0, "address": "Pakistan", "gender": 1, "tiks": 0, "private": 0, "verified": 1, "featured": 0, "bio": "I am flutter developer.", "is_email_sent": 0, "created_at": "2022-05-20T12:00:00Z", "updated_at": "2022-05-20T12:00:00Z", "cover_photo": "assets/images/cover.png", "photo": "assets/images/profile1.png", "token": "abc123"}';

    final jsonData = json.decode(jsonString);
    return User.fromJson(jsonData);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'],
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? 0,
      isBackgroundImage: json['is_background_image'] ?? 0,
      userDirect: json['user_direct'] ?? 0,
      address: json['address'] ?? '',
      workPosition: json['work_position'],
      gender: json['gender'] ?? 0,
      tiks: json['tiks'] ?? 0,
      private: json['private'] ?? 0,
      verified: json['verified'] ?? 0,
      featured: json['featured'] ?? 0,
      bio: json['bio'] ?? '',
      fcmToken: json['fcm_token'],
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      backgroundColor: json['background_color'],
      backgroundImage: json['cover_photo'] ?? '',
      profileImage: json['photo'] ?? '',
      token: json['token'] ?? '',
      isSuspended: json['is_suspended'],
    );
  }

  static DateTime parseDate(String date) {
    final customFormat = RegExp(r'^\d{4}-[A-Za-z]{3}-\d{2}$');
    if (customFormat.hasMatch(date)) {
      final parts = date.split('-');
      final year = int.parse(parts[0]);
      final month = _parseMonth(parts[1]);
      final day = int.parse(parts[2]);

      if (month != null) {
        return DateTime(year, month, day);
      }
    }
    return DateTime.parse(date);
  }

  static int? _parseMonth(String month) {
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    return months[month];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'phone': phone,
      'status': status,
      'is_background_image': isBackgroundImage,
      'user_direct': userDirect,
      'address': address,
      'work_position': workPosition,
      'gender': gender,
      'tiks': tiks,
      'private': private,
      'verified': verified,
      'featured': featured,
      'bio': bio,
      'fcm_token': fcmToken,
      'dob': dob?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'background_color': backgroundColor,
      'cover_photo': backgroundImage,
      'photo': profileImage,
      'token': token,
      'is_suspended': isSuspended,
    };
  }
}
