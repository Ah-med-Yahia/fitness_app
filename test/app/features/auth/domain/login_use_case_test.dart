import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/app/features/auth/domain/entities/login_entity.dart';
import 'package:fitness_app/app/features/auth/domain/repository/auth_repository.dart';
import 'package:fitness_app/app/features/auth/domain/use_cases/login_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
  });

  test('returns LoginEntity on success', () async {
    when(
      mockRepo.login(email: anyNamed('email'), password: anyNamed('password')),
    ).thenAnswer((_) async => const LoginEntity(token: 'abc123'));

    final result = await useCase(
      email: 'test@test.com',
      password: 'Password@1',
    );

    expect(result.token, 'abc123');
    verify(
      mockRepo.login(email: 'test@test.com', password: 'Password@1'),
    ).called(1);
  });

  test('throws AppException when repository throws', () async {
    when(
      mockRepo.login(email: anyNamed('email'), password: anyNamed('password')),
    ).thenThrow(Exception('Network error'));

    expect(
      () => useCase(email: 'test@test.com', password: 'Password@1'),
      throwsException,
    );
  });
}
