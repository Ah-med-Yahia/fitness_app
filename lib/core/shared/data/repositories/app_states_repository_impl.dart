import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/shared/data/data__sources/local/app_states_local_data_sources/app_states_local_data_sources.dart';
import 'package:fitness_app/core/shared/domain/repositories/app_states_repository/app_states_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppStatesRepository)
class AppStatesRepositoryImpl implements AppStatesRepository {
  final AppStatesLocalDataSources _appStatesLocalDataSources;
  AppStatesRepositoryImpl(this._appStatesLocalDataSources);
  @override
  Future<BaseResponse<void>> saveOnBoardingViewed() {
    return _appStatesLocalDataSources.saveOnBoardingViewed();
  }

  @override
  Future<BaseResponse<bool?>> getOnBoardingViewed() {
    return _appStatesLocalDataSources.getOnBoardingViewed();
  }

  @override
  Future<BaseResponse<void>> saveIsLoggedIn() {
    return _appStatesLocalDataSources.saveIsLoggedIn();
  }

  @override
  Future<BaseResponse<bool?>> getIsLoggedIn() {
    return _appStatesLocalDataSources.getIsLoggedIn();
  }
}
