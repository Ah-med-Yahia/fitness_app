import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/shared/domain/repositories/app_states_repository/app_states_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveLoggedInUseCase {
  final AppStatesRepository _appStatesRepository;
  SaveLoggedInUseCase(this._appStatesRepository);
  Future<BaseResponse<void>> call() {
    return _appStatesRepository.saveIsLoggedIn();
  }
}
