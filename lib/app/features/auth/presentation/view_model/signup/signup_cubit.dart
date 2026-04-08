import 'package:fitness_app/app/config/errors/app_exception.dart';
import 'package:fitness_app/app/config/services/tokens/token_service_storage_contract.dart';
import 'package:fitness_app/app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'signup_form_data.dart';
import 'signup_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final TokenServiceStorageContract _tokenService;

  SignUpFormData formData = const SignUpFormData();

  SignUpCubit(this._signUpUseCase, this._tokenService)
    : super(const SignUpState.initial());

  void updateFormData(SignUpFormData data) => formData = data;

  Future<void> submit() async {
    emit(const SignUpState.loading());
    try {
      final entity = await _signUpUseCase(
        firstName: formData.firstName,
        lastName: formData.lastName,
        email: formData.email,
        password: formData.password,
        rePassword: formData.rePassword,
        gender: formData.gender,
        age: formData.age,
        weight: formData.weight,
        height: formData.height,
        goal: formData.goal,
        activityLevel: formData.activityLevel,
      );
      await _tokenService.saveToken(token: entity.token);
      emit(const SignUpState.success());
    } on AppException catch (e) {
      emit(SignUpState.failure(message: e.message));
    } catch (e) {
      emit(SignUpState.failure(message: e.toString()));
    }
  }
}
