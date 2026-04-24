import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/on_boarding/domain/repository/on_boarding_repository.dart';

class SetOnBoardingViewUseCase {
  final OnBoardingRepository _onBoardingRepository;
  SetOnBoardingViewUseCase(this._onBoardingRepository);
  Future<BaseResponse<void>> call() async {
    return await _onBoardingRepository.saveOnBoardingViewed();
  }
}
