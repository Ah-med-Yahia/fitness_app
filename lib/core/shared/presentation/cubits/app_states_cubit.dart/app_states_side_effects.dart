sealed class AppStatesSideEffects {}

class ShowError extends AppStatesSideEffects {
  final String message;
  ShowError(this.message);
}
