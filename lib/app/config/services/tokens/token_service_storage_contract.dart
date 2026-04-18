import 'package:fitness_app/app/config/base_response/base_response.dart';

abstract class TokenServiceStorageContract {
  Future<BaseResponse<bool>> saveToken({required String token});

  Future<BaseResponse<String?>> getToken();

  Future<BaseResponse<void>> clearToken();
}
