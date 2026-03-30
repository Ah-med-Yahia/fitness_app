import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final TokenServiceStorageContract _tokenStorage;
  final TokensManagerContract _tokensManager;

  AuthInterceptor(this._tokenStorage, this._tokensManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _tokenStorage.getAccessToken();

    accessToken.when(
      success: (token) {
        if (!token.isNullOrEmpty()) {
          options.headers[ApiConstants.authorization] =
              '${ApiConstants.bearer} $token';
        }
      },
      failure: (error) {
        appLogger.e(CacheConstants.accessTokenReadFailed);
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
      final refreshedTokenResponse = await _tokenStorage.getRefreshToken();
      refreshedTokenResponse.when(
        success: (refreshToken) async {
          if (refreshToken.isNullOrEmpty()) {
            return _clearAndNavigateToLogin(err, handler);
          }
          final refreshTokenResponse =
              await safeApiCall<RefreshTokenResponseModel>(() async {
                return await _tokensManager.refreshToken(refreshToken!);
              });
          refreshTokenResponse.when(
            success: (data) async {
              _tokenStorage.saveAccessToken(token: data.access);
              _tokenStorage.saveRefreshToken(token: data.refresh);
              err.requestOptions.headers[ApiConstants.authorization] =
                  '${ApiConstants.bearer} ${data.access}';
              final cloneRequest = await _tokensManager.fetchRequestOptions(
                err.requestOptions,
              );
              return handler.resolve(cloneRequest);
            },
            failure: (error) {
              return _clearAndNavigateToLogin(err, handler);
            },
          );
        },
        failure: (error) {
          return CacheException(CacheConstants.refreshTokenReadFailed);
        },
      );
    }
    handler.next(err);
  }

  void _clearAndNavigateToLogin(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    _tokenStorage.clearTokens();
    AppRouter.router.go(AppRoutesConstants.loginRoute);
    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ErrorsConstant.sessionExpiredError,
        type: DioExceptionType.cancel,
      ),
    );
  }
}