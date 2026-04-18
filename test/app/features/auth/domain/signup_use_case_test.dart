import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/app/features/auth/domain/entities/signup_entity.dart';
import 'package:fitness_app/app/features/auth/domain/repository/auth_repository.dart';
import 'package:fitness_app/app/features/auth/domain/use_cases/signup_use_case.dart';
import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late SignUpUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = SignUpUseCase(mockRepo);
  });

  test('returns SignUpEntity on success', () async {
    when(
      mockRepo.signUp(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        password: anyNamed('password'),
        rePassword: anyNamed('rePassword'),
        gender: anyNamed('gender'),
        height: anyNamed('height'),
        weight: anyNamed('weight'),
        age: anyNamed('age'),
        goal: anyNamed('goal'),
        activityLevel: anyNamed('activityLevel'),
      ),
    ).thenAnswer((_) async => const SignUpEntity(token: 'test_token'));

    final result = await useCase(
      firstName: 'Ahmed',
      lastName: 'Yousef',
      email: 'test@test.com',
      password: 'Password@1',
      rePassword: 'Password@1',
      gender: 'male',
      height: 170,
      weight: 70,
      age: 25,
      goal: 'Gain Weight',
      activityLevel: 'level1',
    );

    expect(result.token, 'test_token');
  });

  test('throws when repository throws', () async {
    when(
      mockRepo.signUp(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        password: anyNamed('password'),
        rePassword: anyNamed('rePassword'),
        gender: anyNamed('gender'),
        height: anyNamed('height'),
        weight: anyNamed('weight'),
        age: anyNamed('age'),
        goal: anyNamed('goal'),
        activityLevel: anyNamed('activityLevel'),
      ),
    ).thenThrow(Exception('Network error'));

    expect(
      () => useCase(
        firstName: 'Ahmed',
        lastName: 'Yousef',
        email: 'test@test.com',
        password: 'Password@1',
        rePassword: 'Password@1',
        gender: 'male',
        height: 170,
        weight: 70,
        age: 25,
        goal: 'Gain Weight',
        activityLevel: 'level1',
      ),
      throwsException,
    );
  });
}
