import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_services/cache_storage_contract.dart';
import 'package:fitness_app/config/cache_services/serializer/bool_serializer.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/core/shared/data/data__sources/local/app_states_local_data_sources/app_states_local_data_sources.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppStatesLocalDataSources)
class AppStatesLocalDataSourcesImpl implements AppStatesLocalDataSources {
  final CacheStorageContract _cacheStorage;
  AppStatesLocalDataSourcesImpl(@Named('secureStorage') this._cacheStorage);
  @override
  Future<BaseResponse<void>> saveOnBoardingViewed() async {
    return await _cacheStorage.write(
      StorageKeys.onBoardingViewed,
      true,
      BoolSerializer(),
    );
  }

  @override
  Future<BaseResponse<bool?>> getOnBoardingViewed() async {
    return await _cacheStorage.read(
      StorageKeys.onBoardingViewed,
      BoolSerializer(),
    );
  }

  @override
  Future<BaseResponse<void>> saveIsLoggedIn() async {
    return await _cacheStorage.write(
      StorageKeys.isLoggedIn,
      true,
      BoolSerializer(),
    );
  }

  @override
  Future<BaseResponse<bool?>> getIsLoggedIn() async {
    return await _cacheStorage.read(StorageKeys.isLoggedIn, BoolSerializer());
  }
}
