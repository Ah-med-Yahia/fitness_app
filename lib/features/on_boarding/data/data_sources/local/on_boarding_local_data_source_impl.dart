import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/cache_services/cache_storage_contract.dart';
import 'package:fitness_app/config/cache_services/serializer/string_serializer.dart';
import 'package:fitness_app/core/constants/cache_constants.dart';
import 'package:fitness_app/features/on_boarding/data/data_sources/local/on_boarding_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnBoardingLocalDataSource)
class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  final CacheStorageContract _cacheStorage;
  OnBoardingLocalDataSourceImpl(@Named('secureStorage') this._cacheStorage);
  @override
  Future<BaseResponse<void>> saveOnBoardingViewed() async {
    return await _cacheStorage.write(
      StorageKeys.onBoardingViewed,
      true,
      StringSerializer(),
    );
  }
}
