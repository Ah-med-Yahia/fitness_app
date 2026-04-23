class ApiConstants {
  ApiConstants._();
  //====================Headers============================
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  //==================== Base URL============================
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1/';
  //==================== Auth============================
  static const String signIn = 'auth/signin';
  static const String signUp = 'auth/signup';
  static const String forgotPasswordEndpoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndpoint = 'auth/verifyResetCode';
  static const String resetPasswordEndpoint = 'auth/resetPassword';
}
