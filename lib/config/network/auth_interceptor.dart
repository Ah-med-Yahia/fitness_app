import 'package:dio/dio.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/services/tokens/token_service_storage_contract.dart';
import 'package:fitness_app/core/constants/api_constants.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/core/constants/errors_constants.dart';
import 'package:fitness_app/core/extensions/extensions.dart';
import 'package:fitness_app/core/routing/app_router.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:injectable/injectable.dart';

import '../services/app_logger.dart' show appLogger;

@injectable
class AuthInterceptor extends Interceptor {
  final TokenServiceStorageContract _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.getToken();

    token.when(
      success: (token) {
        if (!token.isNullOrEmpty()) {
          options.headers[ApiConstants.authorization] =
              '${ApiConstants.bearer} $token';
        }
      },
      failure: (error) {
        appLogger.e(CacheConstants.tokenReadFailed);
      },
    );

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      _tokenStorage.clearToken();
      AppRouter.router.go(AppRoutesConstants.signInRoute);
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: ErrorsConstant.sessionExpiredError,
          type: DioExceptionType.cancel,
        ),
      );
    }
    handler.next(err);
  }
}
