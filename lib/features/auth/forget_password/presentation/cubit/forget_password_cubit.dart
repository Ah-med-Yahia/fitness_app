import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/constants/validation_constants.dart';
import 'package:fitness_app/core/validators/app_regex.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/usecases/verify_code_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_side_effects.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final StreamController<ForgetPasswordSideEffects> _streamController =
      StreamController<ForgetPasswordSideEffects>.broadcast();

  Stream<ForgetPasswordSideEffects> get sideEffects => _streamController.stream;

  ForgetPasswordCubit({
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.verifyCodeUseCase,
  }) : super(const ForgetPasswordStates());

  void doIntent(ForgetPasswordIntents intent) {
    switch (intent) {
      case EmailChangedIntent(email: final email):
        _handleEmailChanged(email);

      case SendOtpIntent():
        _handleSendOtp();

      case OtpCodeChangedIntent(otpCode: final otpCode):
        _handleOtpCodeChanged(otpCode);

      case ConfirmOtpCodeIntent():
        _handleConfirmOtpCode();

      case ResendOtpCodeIntent(email: final email):
        _handleResendOtpCode(email);

      case NewPasswordChangedIntent(newPassword: final newPassword):
        _handleNewPasswordChanged(newPassword);

      case ConfirmNewPasswordChangedIntent(
        confirmNewPassword: final confirmNewPassword,
      ):
        _handleConfirmNewPasswordChanged(confirmNewPassword);

      case ResetPasswordIntent():
        _handleResetPassword();
      case ToggleObscurePasswordIntent():
        _handleToggleObscurePassword();
      case ToggleObscureConfirmPasswordIntent():
        _handleToggleObscureConfirmPassword();
    }
  }

  void _handleEmailChanged(String email) {
    emit(
      state.copyWith(email: email, isEmailValid: AppRegex.isEmailValid(email)),
    );
  }

  Future<void> _handleSendOtp() async {
    if (!state.isEmailValid) {
      _streamController.add(
        ShowError(error: AppTextConstants.pleaseEnterValidEmail),
      );
      return;
    }
    emit(state.copyWith(isSendOtpLoading: true));
    final request = ForgetPasswordRequestModel(email: state.email);
    final response = await forgetPasswordUseCase(request);
    response.when(
      success: (_) {
        emit(state.copyWith(isSendOtpLoading: false));
        _streamController.add(NavigateToNextPageViewSideEffect());
      },
      failure: (error) {
        emit(state.copyWith(isSendOtpLoading: false));
        _streamController.add(ShowError(error: error.message));
      },
    );
  }

  void _handleOtpCodeChanged(String otpCode) {
    emit(state.copyWith(otp: otpCode, isOtpValid: _validateOtp(otpCode)));
  }

  bool? _validateOtp(String otpCode) {
    if (otpCode.isEmpty) {
      return null;
    }
    return otpCode.length == 6 && int.tryParse(otpCode) != null;
  }

  Future<void> _handleConfirmOtpCode() async {
    if (!state.isOtpCodeValid) {
      _streamController.add(
        ShowError(error: AppTextConstants.pleaseEnterValidOtp),
      );
      return;
    }
    emit(state.copyWith(isVerifyOtpLoading: true));
    final request = VerifyCodeRequestModel(resetCode: state.otpCode);
    final response = await verifyCodeUseCase(request);
    response.when(
      success: (_) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(NavigateToNextPageViewSideEffect());
      },
      failure: (error) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(ShowError(error: error.message));
      },
    );
  }

  Future<void> _handleResendOtpCode(String email) async {
    emit(state.copyWith(isVerifyOtpLoading: true));
    final request = ForgetPasswordRequestModel(email: email);
    final response = await forgetPasswordUseCase(request);
    response.when(
      success: (_) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(
          ShowSuccessMessage(message: AppTextConstants.otpSentSuccessfully),
        );
      },
      failure: (error) {
        emit(state.copyWith(isVerifyOtpLoading: false));
        _streamController.add(ShowError(error: error.message));
      },
    );
  }

  void _handleNewPasswordChanged(String newPassword) {
    emit(
      state.copyWith(
        newPassword: newPassword,
        isFormValid: _validateForm(
          newPassword: newPassword,
          confirmNewPassword: state.confirmNewPassword,
        ),
      ),
    );
  }

  void _handleConfirmNewPasswordChanged(String confirmNewPassword) {
    emit(
      state.copyWith(
        confirmNewPassword: confirmNewPassword,
        isFormValid: _validateForm(
          newPassword: state.newPassword,
          confirmNewPassword: confirmNewPassword,
        ),
      ),
    );
  }

  bool? _validateForm({
    required String newPassword,
    required String confirmNewPassword,
  }) {
    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      return null;
    }
    return newPassword.length >= 8 && newPassword == confirmNewPassword;
  }

  Future<void> _handleResetPassword() async {
    if (state.newPassword.isEmpty || state.confirmNewPassword.isEmpty) {
      _streamController.add(
        ShowError(error: AppTextConstants.pleaseEnterValidPassword),
      );
      return;
    }
    if (state.newPassword.length < 8) {
      _streamController.add(
        ShowError(error: ValidationConstants.passwordMinLength),
      );
      return;
    }
    if (state.newPassword != state.confirmNewPassword) {
      _streamController.add(
        ShowError(error: ValidationConstants.passwordsDoNotMatch),
      );
      return;
    }
    _streamController.add(ShowLoading());
    final request = ResetPasswordRequestModel(
      newPassword: state.newPassword,
      email: state.email,
    );
    final response = await resetPasswordUseCase(request);
    response.when(
      success: (_) {
        _streamController.add(HideLoading());
        _streamController.add(
          NavigateToLoginSideEffect(
            message: AppTextConstants.passwordResetSuccessfully,
          ),
        );
      },
      failure: (error) {
        _streamController.add(HideLoading());
        _streamController.add(ShowError(error: error.message));
      },
    );
  }

  void _handleToggleObscurePassword() {
    emit(state.copyWith(isObscurePassword: !state.isObscurePassword));
  }

  void _handleToggleObscureConfirmPassword() {
    emit(
      state.copyWith(isObscureConfirmPassword: !state.isObscureConfirmPassword),
    );
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
