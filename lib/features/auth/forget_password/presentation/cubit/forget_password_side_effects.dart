class ForgetPasswordSideEffects {
  ForgetPasswordSideEffects();
}

// Provide Email Intents
class ShowErrorProvideEmailSideEffect extends ForgetPasswordSideEffects {
  final String error;
  ShowErrorProvideEmailSideEffect({required this.error});
}

class NavigateToVerifyCodeSideEffect extends ForgetPasswordSideEffects {}

// Verify Code Intents
class ShowErrorVerifyCodeSideEffect extends ForgetPasswordSideEffects {
  final String error;
  ShowErrorVerifyCodeSideEffect({required this.error});
}

class ShowSuccessVerifyCodeSideEffect extends ForgetPasswordSideEffects {
  final String message;
  ShowSuccessVerifyCodeSideEffect({required this.message});
}

class NavigateToResetPasswordSideEffect extends ForgetPasswordSideEffects {}

// Reset Password Intents

class ShowLoadingResetPasswordSideEffect extends ForgetPasswordSideEffects {}

class HideLoadingResetPasswordSideEffect extends ForgetPasswordSideEffects {}

class ShowErrorResetPasswordSideEffect extends ForgetPasswordSideEffects {
  final String error;
  ShowErrorResetPasswordSideEffect({required this.error});
}

class NavigateToLoginSideEffect extends ForgetPasswordSideEffects {
  final String message;
  NavigateToLoginSideEffect({required this.message});
}
