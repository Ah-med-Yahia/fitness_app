sealed class ForgetPasswordIntents {}

class EmailChangedIntent extends ForgetPasswordIntents {
  final String email;
  EmailChangedIntent({required this.email});
}

class SendOtpIntent extends ForgetPasswordIntents {}

class OtpCodeChangedIntent extends ForgetPasswordIntents {
  final String otpCode;
  OtpCodeChangedIntent({required this.otpCode});
}

class ConfirmOtpCodeIntent extends ForgetPasswordIntents {}

class ResendOtpCodeIntent extends ForgetPasswordIntents {
  final String email;
  ResendOtpCodeIntent({required this.email});
}

class NewPasswordChangedIntent extends ForgetPasswordIntents {
  final String newPassword;
  NewPasswordChangedIntent({required this.newPassword});
}

class ConfirmNewPasswordChangedIntent extends ForgetPasswordIntents {
  final String confirmNewPassword;
  ConfirmNewPasswordChangedIntent({required this.confirmNewPassword});
}

class ToggleObscurePasswordIntent extends ForgetPasswordIntents {}

class ToggleObscureConfirmPasswordIntent extends ForgetPasswordIntents {}

class ResetPasswordIntent extends ForgetPasswordIntents {}
