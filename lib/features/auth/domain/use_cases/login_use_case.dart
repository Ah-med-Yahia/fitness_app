import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../repository/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<BaseResponse<String>> call({
    required String email,
    required String password,
  }) => _repository.login(email: email, password: password);
}
