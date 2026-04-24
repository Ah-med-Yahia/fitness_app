import 'package:freezed_annotation/freezed_annotation.dart';

import '../errors/app_exception.dart';

part 'base_response.freezed.dart';

@Freezed()
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse.success(T data) = Success<T>;

  const factory BaseResponse.failure(AppException exception) = Failure<T>;
}
