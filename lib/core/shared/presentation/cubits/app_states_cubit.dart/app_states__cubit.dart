import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/get_logged_in_use_case.dart';
import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/get_viewed_on_boarding_use_case.dart';
import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/save_looged_in_use_case.dart';
import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/save_viewed_on_boarding_use_case.dart';
import 'package:fitness_app/core/shared/presentation/cubits/app_states_cubit.dart/app_states.dart';
import 'package:fitness_app/core/shared/presentation/cubits/app_states_cubit.dart/app_states_side_effects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  final GetViewedOnBoardingUseCase _getOnBoardingViewedUseCase;
  final SaveViewedOnBoardingUseCase _saveOnBoardingViewedUseCase;
  final GetLoggedInUseCase _getLoggedInUseCase;
  final SaveLoggedInUseCase _saveIsLoggedInUseCase;
  final StreamController<AppStatesSideEffects> _sideEffectsController =
      StreamController.broadcast();
  Stream<AppStatesSideEffects> get sideEffects => _sideEffectsController.stream;

  AppCubit(
    this._getOnBoardingViewedUseCase,
    this._saveOnBoardingViewedUseCase,
    this._getLoggedInUseCase,
    this._saveIsLoggedInUseCase,
  ) : super(const AppState());

  Future<void> init() async {
    emit(const AppState(isLoading: true));

    final onBoardingRes = await _getOnBoardingViewedUseCase();

    onBoardingRes.when(
      success: (data) async {
        final hasSeenOnboarding = data ?? false;
        if (!hasSeenOnboarding) {
          emit(
            const AppState(status: OnboardingStatus.newUser, isLoading: false),
          );
          return;
        }
        final isLoggedInRes = await _getLoggedInUseCase();
        isLoggedInRes.when(
          success: (data) {
            final isLoggedIn = data ?? false;
            emit(
              AppState(
                status: isLoggedIn
                    ? OnboardingStatus.loggedIn
                    : OnboardingStatus.returningNotLoggedIn,
                isLoading: false,
              ),
            );
          },
          failure: (error) {
            _sideEffectsController.add(ShowError(error.message));
            emit(const AppState(isLoading: false));
          },
        );
      },
      failure: (error) {
        _sideEffectsController.add(ShowError(error.message));
        emit(const AppState(isLoading: false));
      },
    );
  }

  Future<void> completeOnBoarding() async {
    await _saveOnBoardingViewedUseCase();
    emit(
      const AppState(
        status: OnboardingStatus.returningNotLoggedIn,
        isLoading: false,
      ),
    );
  }

  Future<void> login() async {
    await _saveIsLoggedInUseCase();
    emit(const AppState(status: OnboardingStatus.loggedIn, isLoading: false));
  }

  void logout() {
    emit(
      const AppState(
        status: OnboardingStatus.returningNotLoggedIn,
        isLoading: false,
      ),
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
