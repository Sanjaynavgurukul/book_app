import 'dart:convert';
import 'dart:developer';
import 'package:book_app/model/api_response.dart';
import 'package:book_app/services/api_urls.dart';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static final NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  //GET API METHOD
  Future<ApiResponse> get({required String url}) async {
    Map<String, String> header = {'Content-Type': 'application/json'};
    print('check --- api url ---- ${Uri.parse(ApiUrls.baseUrl + url)}');
    http.Response response = await http.get(Uri.parse(ApiUrls.baseUrl + url), headers: header);
    return await convertResponse(response: response);
  }

  Future<ApiResponse> convertResponse({
    required http.Response response,
  }) async {
    final int statusCode = response.statusCode;
    if (statusCode == 200 || statusCode == 201) {
      const JsonDecoder decoder = JsonDecoder();
      Map<String, dynamic> body = decoder.convert(response.body);
      log('check body from network utils ---- $body');
      return ApiResponse(
          status: body.containsKey('status') ? body['status'] : true, message: body.containsKey('message') ? body['message'] : '', data: body);
    } else {
      return ApiResponse(status: false, message: 'Api Not responding', data: {'status': false, 'message': 'Api Not responding'});
    }
  }
}

