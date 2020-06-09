import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class ApiServices {
  final _apiKey = 'e0310fe3c87dfb9d68ddaebe72887c43';
  final _host = 'developers.zomato.com';
  final _contextRoot = 'api/v2.1';

  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': _apiKey};

  Future<Map> getRequest(
      {@required String path, Map<String, String> parameters}) async {

    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);

    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);

    return jsonObject;
  }

  // Future<Map> postRequest(
  // Future<Map> putRequest(

}