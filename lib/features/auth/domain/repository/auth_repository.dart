import 'package:fitness_app/config/base_response/base_response.dart';

import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<BaseResponse<String>> login({required String email, required String password});
}
