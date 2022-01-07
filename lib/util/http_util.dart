import 'dart:convert';

import 'package:http/http.dart'as http;

typedef void OnRequestCompleted(responseBody);
typedef void OnRequestFailed();

class HttpUtil {

  Map <String, String> _headers = {
     'X-Api-Key': '42c230defe3b40aa871ee0e177527761'
  };

  Future<void> makeGetRequest({
  required String url,
  required OnRequestCompleted onRequestCompleted,
  required OnRequestFailed onRequestFailed
  }) async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: _headers);
      if(response.statusCode == 200) {
        onRequestCompleted(json.decode(response.body));
      } else {
        print(response.statusCode);
        onRequestFailed();
      }
    } catch(e) {
      print(e);
    }
  }
}