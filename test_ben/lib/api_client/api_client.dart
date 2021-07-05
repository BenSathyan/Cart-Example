import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  ApiClient() {
    initClient();
  }
  ApiClient.test({@required this.dio});

  Dio dio;
  BaseOptions _baseOptions;

  initClient() async {
    _baseOptions = new BaseOptions(
        baseUrl: "https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad",
        connectTimeout: 3000000,
        receiveTimeout: 1000000,
        followRedirects: true,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        responseType: ResponseType.json,
        receiveDataWhenStatusError: true);

    dio = Dio(_baseOptions);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions reqOptions) {
        return reqOptions;
      },
      onError: (DioError dioError) {
        return dioError.response;
      },
    ));
  }

  // ignore: missing_return
  Future<Response> getProductList() async {
    return dio.post("https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad");
  }
}