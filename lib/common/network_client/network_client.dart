import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class NetworkClient {
  static const String _kBaseUrl =
      'https://spiceblogserver-production.up.railway.app';

  static Future<http.Response> get(String endPoint) async {
    return http.get(Uri.parse('$_kBaseUrl/$endPoint'));
  }

  static Future<http.Response> delete(String endPoint) async {
    return http.delete(Uri.parse('$_kBaseUrl/$endPoint'));
  }

  static Future<http.Response> post(String endPoint, {dynamic data}) async {
    return http.post(Uri.parse('$_kBaseUrl/$endPoint'), body: jsonEncode(data));
  }
}