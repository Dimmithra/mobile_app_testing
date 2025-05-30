import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import 'package:mobile_app_test/utils/key_constant.dart';

class CommonHttp {
  final String baseUrl;
  final String authToken;

  CommonHttp(this.baseUrl, this.authToken);

  Future<dynamic> get(String endpoint, BuildContext context) async {
    const storage = FlutterSecureStorage();

    String? token = await storage.read(key: kSecureToken);

    try {
      // dev.log(token.toString());
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return response.body;
      }
    } catch (error) {
      // dev.log('Error during GET request: $error');
      throw Exception('Failed to load data: $error');
    }
  }

  Future<dynamic> post(
      String endpoint, Map<String, dynamic> data, BuildContext context) async {
    const storage = FlutterSecureStorage();

    String? token = await storage.read(key: kSecureToken);
    final response = await http.post(
      Uri.parse(endpoint),
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      return response.body;
    }
  }
}
