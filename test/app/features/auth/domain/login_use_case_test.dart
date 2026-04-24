import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fitness_app/features/auth/domain/use_cases/login_use_case.dart';

import 'login_use_case_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
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
