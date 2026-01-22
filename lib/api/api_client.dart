import 'dart:convert';
import 'package:chat_app/utils/msg.dart';
import 'package:http/http.dart' as http;

enum HttpMethodTypes { get, post, put, delete, patch }

class ApiClient {
  final Map<String, String> _headers = {'Content-Type': 'application/json'};

  Future<dynamic> request({
    required String url,
    required HttpMethodTypes method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
  }) async {
    late http.Response response;
    _headers['Authorization'] = 'key=7fIC8flrwJqFIrhjr0BuqVwc8';
    Uri uri = Uri.parse(url).replace(
      queryParameters: {if (queryParameters != null) ...queryParameters},
    );

    logInfo('ApiClient/Request', msg: "${method.name}: $uri");
    if (payload != null) logInfo('ApiClient/Request', msg: jsonEncode(payload));

    logInfo('ApiClient/Header', msg: jsonEncode(_headers));
    try {
      switch (method) {
        case HttpMethodTypes.get:
          response = await http.get(uri, headers: _headers);
          break;
        case HttpMethodTypes.post:
          response = await http.post(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case HttpMethodTypes.put:
          response = await http.put(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case HttpMethodTypes.delete:
          response = await http.delete(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case HttpMethodTypes.patch:
          response = await http.patch(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
      }
      //final decoded = jsonDecode(response.body);
      logSuccess('ApiClient/Request/Response', msg: response.body);
      logSuccess('ApiClient/Request/StatusCode', msg: response.statusCode);
      if (response.statusCode == 200) {}
    } catch (ex) {
      toastMsg(ex.toString());
      logError('ApiClient/Request', msg: ex);
    }
    return false;
  }
}
