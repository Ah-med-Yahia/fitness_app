import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/use_cases/login_use_case.dart';
import 'login_intent.dart';
import 'state/login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginState.initial());

  Future<void> _login({required String email, required String password}) async {
    emit(const LoginState.loading());

    final entity = await _loginUseCase(email: email, password: password);
    entity.when(
      success: (data) {
        emit(LoginState.success(message: data));
      },
      failure: (exception) {
        emit(LoginState.failure(message: exception.message));
      },
    );
  }

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case UserLoginIntent():
        _login(email: intent.email, password: intent.password);
    }
  }
}
