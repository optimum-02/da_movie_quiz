import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  final String? apiKey;
  final String? baseUrl;

  ApiClient({required this.client, this.apiKey, this.baseUrl});

  Map<String, String> get defaultHeaders {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (apiKey != null) {
      headers.addEntries([MapEntry('Authorization', 'Bearer $apiKey')]);
    }

    return headers;
  }

  Future<http.Response> get(String url) async {
    final completeUrl = Uri.parse((baseUrl ?? "") + url);
    return client.get(completeUrl, headers: defaultHeaders);
  }

  // Add other methods (put, delete, etc.) if needed
}
