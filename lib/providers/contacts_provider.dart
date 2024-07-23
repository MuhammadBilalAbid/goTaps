import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gotaps/model/contacts_model.dart';
import 'package:gotaps/model/userdetails_model.dart';
import 'package:gotaps/utils/app_api.dart';

class ConnectionsProvider with ChangeNotifier {
  List<Connection> _connections = [];
  bool _isLoading = true;

  List<Connection> get connections => _connections;
  bool get isLoading => _isLoading;

  ConnectionsProvider() {
    fetchConnections();
  }

  Future<void> fetchConnections() async {
    User? user = await User.loadUser();
    String authToken = user!.token;
    try {
      Map<String, dynamic> header = {
        'Accept': 'application/json',
        'Device-ID': '12345',
        'Authorization': 'Bearer $authToken',
      };
      final response = await Dio().get(
        ApiLinks.getConnections,
        options: Options(headers: header),
      );
      List<dynamic> data = response.data['connections'];
      _connections = data.map((json) => Connection.fromJson(json)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      print('Error fetching Connections: $error');
      _isLoading = false;
      notifyListeners();
    }
  }
}
