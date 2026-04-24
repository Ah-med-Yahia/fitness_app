import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/errors/app_exception.dart';
import 'package:fitness_app/core/constants/errors_constants.dart';

class ApiException extends AppException with EquatableMixin {
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

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
