import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart'; // Add this

class ApiService {
  static ApiService inst = ApiService();

  Future<String> getAccessToken() async {
    final String jsonString = await rootBundle.loadString(
      'asset/firebase_service_key.json',
    );
    final accountCredentials = ServiceAccountCredentials.fromJson(jsonString);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = await clientViaServiceAccount(accountCredentials, scopes);
    final accessToken = client.credentials.accessToken.data;
    client.close();
    return accessToken;
  }

  Future<bool> sendPushNotification({
    required String fcm,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    if (fcm.isEmpty) return false;

    try {
      final accessToken = await getAccessToken();
      final String jsonString = await rootBundle.loadString(
        'asset/firebase_service_key.json',
      );
      final Map<String, dynamic> keys = json.decode(jsonString);
      final projectId = keys['project_id'];
      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
      );

      final message = {
        'message': {
          'token': fcm,
          'notification': {'title': title, 'body': body},
          'data': data ?? {},
        },
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully.');
        return true;
      } else {
        print('Failed to send: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending notification: $e');
      return false;
    }
  }
}
