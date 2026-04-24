import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/on_boarding/data/data_sources/local/on_boarding_local_data_source.dart';
import 'package:fitness_app/features/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OnBoardingRepository)
class OnBoardingRepositoryImpl implements OnBoardingRepository {
  final OnBoardingLocalDataSource _onBoardingLocalDataSource;
  OnBoardingRepositoryImpl(this._onBoardingLocalDataSource);
  @override
  Future<BaseResponse<void>> saveOnBoardingViewed() async {
    return await _onBoardingLocalDataSource.saveOnBoardingViewed();
  }
}
