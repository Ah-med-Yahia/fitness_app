import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/shared/domain/repositories/app_states_repository/app_states_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAppStatusUseCase {
  final AppStatesRepository _appStatesRepository;

  GetAppStatusUseCase(this._appStatesRepository);

  Future<UserInitialStatus> call() async {
    final isLoggedInRes = await _appStatesRepository.getIsLoggedIn();
    final onBoardingRes = await _appStatesRepository.getOnBoardingViewed();

    return onBoardingRes.when(
      success: (viewd) {
        if (!(viewd ?? false)) {
          return UserInitialStatus.newUser;
        } else {
          return isLoggedInRes.when(
            success: (isLoggedIn) {
              if (isLoggedIn ?? false) {
                return UserInitialStatus.loggedIn;
              } else {
                return UserInitialStatus.notLoggedIn;
              }
            },
            failure: (error) {
              return UserInitialStatus.notLoggedIn;
            },
          );
        }
      },
      failure: (error) {
        return UserInitialStatus.newUser;
      },
    );
  }
}

enum UserInitialStatus { newUser, notLoggedIn, loggedIn }
