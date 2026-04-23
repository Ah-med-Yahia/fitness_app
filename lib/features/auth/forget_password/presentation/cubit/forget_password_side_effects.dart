sealed class ForgetPasswordSideEffects {
  ForgetPasswordSideEffects();
}

class ShowLoading extends ForgetPasswordSideEffects {}

class HideLoading extends ForgetPasswordSideEffects {}

class ShowError extends ForgetPasswordSideEffects {
  final String error;
  ShowError({required this.error});
}

class ShowSuccessMessage extends ForgetPasswordSideEffects {
  final String message;
  ShowSuccessMessage({required this.message});
}

class NavigateToNextPageViewSideEffect extends ForgetPasswordSideEffects {}

class NavigateToLoginSideEffect extends ForgetPasswordSideEffects {
  final String message;
  NavigateToLoginSideEffect({required this.message});
}
