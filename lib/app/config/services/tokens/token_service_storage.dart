import 'package:fitness_app/app/config/base_response/base_response.dart';
import 'package:fitness_app/app/config/cache_services/cache_storage_contract.dart';
import 'package:fitness_app/app/config/cache_services/serializer/string_serializer.dart';
import 'package:fitness_app/app/config/services/tokens/token_service_storage_contract.dart';
import 'package:fitness_app/app/core/constants/cache_constants.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenServiceStorageContract)
class TokenServiceStorage implements TokenServiceStorageContract {
  final CacheStorageContract _secureStorageService;

  TokenServiceStorage(@Named('secureStorage') this._secureStorageService);

  @override
  Future<BaseResponse<bool>> saveToken({required String token}) async {
    final result = await _secureStorageService.write(
      StorageKeys.token,
      token,
      StringSerializer(),
    );
    return result.when(
      success: (_) => const BaseResponse<bool>.success(true),
      failure: (f) => BaseResponse<bool>.failure(f),
    );
  }

  @override
  Future<BaseResponse<String?>> getToken() async {
    final result = await _secureStorageService.read(
      StorageKeys.token,
      StringSerializer(),
    );
    return result.when(
      success: (s) => BaseResponse.success(s),
      failure: (f) => BaseResponse.failure(f),
    );
  }

  @override
  Future<BaseResponse<void>> clearToken() async {
    final result = await _secureStorageService.delete(StorageKeys.token);
    return result.when(
      success: (_) => const BaseResponse<void>.success(null),
      failure: (f) => BaseResponse<void>.failure(f),
    );
  }
}
