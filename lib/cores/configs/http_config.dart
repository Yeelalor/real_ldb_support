import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../EndPoint/end_point.dart';

class Network {
  dynamic token;
  _setBasicAuth() => {
        'Accept': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('l1k695f88dbdf2844d2bee65b957f7887d5:f9ba11db16e2472f83e79a412c4fd14d'))}',
      };
  getAuthToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final uri =
        Uri.parse('https://dehome.ldblao.la/vbox-oauth2/v2/authorise/token');
    var map = <String, dynamic>{};
    map['grant_type'] = 'client_credentials';
    final response = await http.post(uri, body: map, headers: _setBasicAuth());
    final body = json.decode(response.body);
    token = await localStorage.setString('localToken', body['access_token']);
  }

  _setHeaderNormal() => {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };
  postData(data, url) async {
    final baseUrl = Uri.parse('$END_POINT/$url');
    await getAuthToken();
    return http.post(
      baseUrl,
      body: data,
      headers: _setHeaderNormal(),
    );
  }

  getData(url) async {
    final baseUrl = Uri.parse('$END_POINT/$url');
    return http.get(baseUrl);
  }
}
