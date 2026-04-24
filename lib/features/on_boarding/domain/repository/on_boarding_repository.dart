import 'package:fitness_app/config/base_response/base_response.dart';

abstract interface class OnBoardingRepository {
  Future<BaseResponse<void>> saveOnBoardingViewed();
}
