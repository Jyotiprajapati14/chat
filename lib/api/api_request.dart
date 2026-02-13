import 'dart:convert';
import 'package:adept_log/view/adept_log.dart';
import 'package:http/http.dart' as http;
import 'package:productapp/app/app_data.dart';

enum ApiRequestType { get, post, put, delete, patch }

class ApiResponseMdl {
  bool isSuccess;
  Map<String, dynamic> data;
  ApiResponseMdl({this.isSuccess = false, this.data = const {}});
}

class ApiClient {
  http.Client _client = http.Client();
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'text/plain',
  };

  void resetClient() {
    try {
      _client.close();
    } catch (ex) {
      //AdeptLog.e(ex);
    }
    _client = http.Client();
  }

  Future<ApiResponseMdl> request({
    required String endPoint,
    required ApiRequestType method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
  }) async {
    late http.Response response;
    Uri uri = Uri.parse('${AppData.apiBaseUrl}$endPoint').replace(
      queryParameters: {if (queryParameters != null) ...queryParameters},
    );
    AdeptLog.i({
      method.name.toUpperCase(): uri.toString(),
      "Payload": ?payload,
    }, tag: endPoint);
    try {
      switch (method) {
        case ApiRequestType.get:
          response = await http.get(uri, headers: _headers);
          break;
        case ApiRequestType.post:
          response = await http.post(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case ApiRequestType.put:
          response = await http.put(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case ApiRequestType.delete:
          response = await http.delete(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case ApiRequestType.patch:
          response = await http.patch(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
      }

      final decoded = jsonDecode(response.body);
      AdeptLog.s({
        "StatusCode": "${response.statusCode}",
        "Response": decoded,
      }, tag: endPoint);
      if (response.statusCode == 403) {
      } else if (response.statusCode == 200) {
        return ApiResponseMdl(isSuccess: true, data: decoded);
      }
    } catch (ex, st) {
      AdeptLog.e(ex, stackTrace: st);
    }
    return ApiResponseMdl();
  }
}
