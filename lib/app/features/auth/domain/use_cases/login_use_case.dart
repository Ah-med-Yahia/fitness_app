import 'package:injectable/injectable.dart';
import '../entities/login_entity.dart';
import '../repository/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<LoginEntity> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}
