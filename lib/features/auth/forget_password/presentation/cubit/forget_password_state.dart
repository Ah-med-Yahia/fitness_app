import 'package:fitness_app/config/base_state/base_state.dart';

class ForgetPasswordStates extends BaseState<void> {
  final String email;
  final bool isEmailValid;
  final bool isSendOtpLoading;

  final String otpCode;
  final bool isOtpCodeValid;
  final bool isVerifyOtpLoading;

  final String newPassword;
  final String confirmNewPassword;
  final bool isFormValid;
  final bool isObscurePassword;
  final bool isObscureConfirmPassword;

  const ForgetPasswordStates({
    super.isEmpty = false,
    super.isError = false,
    super.data,
    this.email = '',
    this.isEmailValid = false,
    this.isSendOtpLoading = false,
    this.otpCode = '',
    this.isOtpCodeValid = false,
    this.isVerifyOtpLoading = false,
    this.newPassword = '',
    this.confirmNewPassword = '',
    this.isFormValid = false,
    this.isObscurePassword = false,
    this.isObscureConfirmPassword = false,
  });

  @override
  ForgetPasswordStates copyWith({
    bool? isEmpty,
    bool? isError,
    void data,
    bool? isLoading,
    String? errorMessage,
    String? email,
    bool? isEmailValid,
    bool? isSendOtpLoading,
    String? otp,
    bool? isOtpValid,
    bool? isVerifyOtpLoading,
    String? newPassword,
    String? confirmNewPassword,
    bool? isFormValid,
    bool? isObscurePassword,
    bool? isObscureConfirmPassword,
  }) {
    return ForgetPasswordStates(
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      data: data,
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSendOtpLoading: isSendOtpLoading ?? this.isSendOtpLoading,
      otpCode: otp ?? otpCode,
      isOtpCodeValid: isOtpValid ?? isOtpCodeValid,
      isVerifyOtpLoading: isVerifyOtpLoading ?? this.isVerifyOtpLoading,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      isFormValid: isFormValid ?? this.isFormValid,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      isObscureConfirmPassword:
          isObscureConfirmPassword ?? this.isObscureConfirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    isEmpty,
    isError,
    email,
    isEmailValid,
    isSendOtpLoading,
    otpCode,
    isOtpCodeValid,
    isVerifyOtpLoading,
    newPassword,
    confirmNewPassword,
    isFormValid,
    isObscurePassword,
    isObscureConfirmPassword,
  ];
}
