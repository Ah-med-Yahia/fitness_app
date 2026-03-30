import 'package:fitness_app/config/errors/app_exception.dart';

class ApiException extends AppException {
  ApiException(super.message, {super.code});

  factory ApiException.fromResponse({
    required Map<String, dynamic> json,
    required int? statusCode,
  }) {
    return ApiException(
      json['error'] ?? ErrorsConstant.defaultError,
      code: statusCode,
    );
  }
}
