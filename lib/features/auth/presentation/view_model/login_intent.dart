sealed class LoginIntent {

}
class UserLoginIntent extends LoginIntent{
  final String email;
  final String password;
  UserLoginIntent({required this.email, required this.password});
}
