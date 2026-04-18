import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/app/config/errors/app_exception.dart';
import 'package:fitness_app/app/config/services/tokens/token_service_storage_contract.dart';
import '../../../domain/use_cases/login_use_case.dart';
import '../login/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final TokenServiceStorageContract _tokenService;

  LoginCubit(this._loginUseCase, this._tokenService)
    : super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginState.loading());
    try {
      final entity = await _loginUseCase(email: email, password: password);
      await _tokenService.saveToken(token: entity.token);
      emit(LoginState.success(token: entity.token));
    } on AppException catch (e) {
      emit(LoginState.failure(message: e.message));
    } catch (e) {
      emit(LoginState.failure(message: e.toString()));
    }
  }
}
