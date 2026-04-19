import 'package:fitness_app/app/config/base_response/base_response.dart';
import 'package:fitness_app/app/config/cache_services/serializer/serializer.dart';

abstract class CacheStorageContract {
  Future<BaseResponse<void>> write<T>(
    String key,
    T value,
    Serializer<T> serializer,
  );
  Future<BaseResponse<T?>> read<T>(String key, Serializer<T> serializer);
  Future<BaseResponse<void>> delete(String key);
  Future<BaseResponse<void>> deleteAll();
  Future<BaseResponse<bool>> containsKey(String key);
  Future<BaseResponse<List<String>>> getAllKeys();
}
