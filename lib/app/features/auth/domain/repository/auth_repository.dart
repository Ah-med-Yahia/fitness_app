import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<LoginEntity> login({required String email, required String password});
}
