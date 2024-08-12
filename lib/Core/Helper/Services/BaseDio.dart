
import 'dart:io';
import 'package:dio/io.dart' as dio_io;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'dart:developer' as l;
import 'AuthenticationInterceptor.dart';

class BaseDio {
  late Dio _dio;

  Dio _initDio() {
    BaseOptions baseOptions = BaseOptions(
      connectTimeout: const Duration(milliseconds: 25000),
      receiveTimeout: const Duration(milliseconds: 25000),
      responseType: ResponseType.json,
      headers: headers(),
    );

    Dio dio =  Dio(baseOptions);
    dio.interceptors.clear();
    dio.interceptors.add(AuthenticationInterceptor(dio,));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true,
      requestHeader: true,responseHeader: true,
      logPrint: (object) {
        l.log(object.toString());
      },));
    }

    if (!kIsWeb) {
      dio.httpClientAdapter = dio_io.IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          client.badCertificateCallback = (X509Certificate cert, String host, int port) {
            return true; // Verify the certificate.
          };
          return client;
        },
      );
    }

    return dio;
  }


  BaseDio() {
    _dio = _initDio();
  }

  Dio get dio => _dio;

  headers() {
    var headers = {
      "content-type": "application/json",
      "type": "Flutter",
      "platform": BaseBrain.platform,
      "application": 'waiter.sesoot',
      "appversion": BaseBrain.appVersion.value,
      "os": BaseBrain.os,
    };
    return headers;
  }
}
