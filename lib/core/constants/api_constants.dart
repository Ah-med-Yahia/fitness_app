class ApiConstants {
  ApiConstants._();
  //====================Headers============================
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  //==================== Base URL============================
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1/';
  static const String baseUrl1 = 'https://themealdb.com/api/json/v1/';
  //==================== Auth============================
  static const String signIn = 'auth/signin';
  static const String signUp = 'auth/signup';
  //==================== Food============================
  static const String foodCategories = '1/categories.php';
  static const String meals = '1/filter.php';
  static const String forgotPasswordEndpoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndpoint = 'auth/verifyResetCode';
  static const String resetPasswordEndpoint = 'auth/resetPassword';
  static const String mealDetails = '1/lookup.php';
}
