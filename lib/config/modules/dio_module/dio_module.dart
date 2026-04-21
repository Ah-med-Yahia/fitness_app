import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:fitness_app/config/network/auth_interceptor.dart';
import 'package:fitness_app/config/network/pretty_dio_logger_interceptor.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../feature/food_category/api/food_api_client/food_api_clients.dart';

@module
abstract class DioModule {
  @lazySingleton
  FoodApiClient provideFoodApiClient(Dio dio) =>
      FoodApiClient(dio, baseUrl: ApiConstants.baseUrl);
  @singleton
  Dio dio(
    AuthInterceptor authInterceptor,
    PrettyDioLoggerInterceptor loggerInterceptor,
      ChuckerDioInterceptor chuckerDioInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(chuckerDioInterceptor);
    if (kDebugMode) {
      dio.interceptors.add(loggerInterceptor);
    }
    return dio;
  }
  @lazySingleton
  ChuckerDioInterceptor provideChuckerInterceptor() => ChuckerDioInterceptor();
}
