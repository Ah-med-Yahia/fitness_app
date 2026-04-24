sealed class OnboardingIntents {}

class UpdateCurrentPageIntent extends OnboardingIntents {
  final int page;
  UpdateCurrentPageIntent(this.page);
}

class NavigateToRegisterIntent extends OnboardingIntents {}
