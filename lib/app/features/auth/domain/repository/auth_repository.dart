import 'package:fitness_app/app/features/auth/domain/entities/signup_entity.dart';

import '../entities/login_entity.dart';

abstract class AuthRepository {
  Future<LoginEntity> login({required String email, required String password});
  Future<SignUpEntity> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required int height,
    required int weight,
    required int age,
    required String goal,
    required String activityLevel,
  });
}
