import 'dart:async';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/save_viewed_on_boarding_use_case.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_intents.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_side_effects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit(this._saveViewedOnBoardingUseCase)
    : super(const OnBoardingStates());
  final SaveViewedOnBoardingUseCase _saveViewedOnBoardingUseCase;
  final StreamController<OnBoardingSideEffects> _sideEffectsController =
      StreamController<OnBoardingSideEffects>.broadcast();
  Stream<OnBoardingSideEffects> get sideEffects =>
      _sideEffectsController.stream;
  void doIntent(OnboardingIntents intent) {
    switch (intent) {
      case UpdateCurrentPageIntent(page: final page):
        _updateCurrentPage(page);
      case NavigateToLoginIntent():
        _navigateToLogin();
    }
  }

  void _updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void _navigateToLogin() async {
    final result = await _saveViewedOnBoardingUseCase();
    result.when(
      success: (viewd) {
        _sideEffectsController.add(NavigateToLoginSideEffect());
      },
      failure: (error) {
        _sideEffectsController.add(ShowErrorSideEffect(message: error.message));
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
