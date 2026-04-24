import 'package:fitness_app/config/base_response/base_response.dart';

abstract class AuthRepository {
  Future<BaseResponse<String>> login({
    required String email,
    required String password,
  });
}
