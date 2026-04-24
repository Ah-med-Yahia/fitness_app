import 'package:fitness_app/config/base_response/base_response.dart';

abstract interface class AppStatesLocalDataSources {
  Future<BaseResponse<void>> saveOnBoardingViewed();
  Future<BaseResponse<bool?>> getOnBoardingViewed();
  Future<BaseResponse<void>> saveIsLoggedIn();
  Future<BaseResponse<bool?>> getIsLoggedIn();
}
