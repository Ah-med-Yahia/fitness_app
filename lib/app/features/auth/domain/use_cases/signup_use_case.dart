import 'package:injectable/injectable.dart';
import '../entities/signup_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _repository;
  const SignUpUseCase(this._repository);

  Future<SignUpEntity> call({
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
  }) => _repository.signUp(
    firstName: firstName,
    lastName: lastName,
    email: email,
    password: password,
    rePassword: rePassword,
    gender: gender,
    height: height,
    weight: weight,
    age: age,
    goal: goal,
    activityLevel: activityLevel,
  );
}
