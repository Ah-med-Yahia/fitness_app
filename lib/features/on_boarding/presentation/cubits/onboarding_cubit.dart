import 'dart:async';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/on_boarding/domain/use_cases/set_on_boarding_view_use_case.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_intents.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_side_effects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit(this._setOnBoardingViewUseCase)
    : super(const OnBoardingStates());
  final SetOnBoardingViewUseCase _setOnBoardingViewUseCase;
  final StreamController<OnBoardingSideEffects> _sideEffectsController =
      StreamController<OnBoardingSideEffects>.broadcast();
  Stream<OnBoardingSideEffects> get sideEffects =>
      _sideEffectsController.stream;
  void doIntent(OnboardingIntents intent) {
    switch (intent) {
      case UpdateCurrentPageIntent(page: final page):
        _updateCurrentPage(page);
      case NavigateToRegisterIntent():
        _navigateToRegister();
    }
  }

  void _updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void _navigateToRegister() async {
    final response = await _setOnBoardingViewUseCase.call();
    response.when(
      success: (success) {},
      failure: (failure) {
        _sideEffectsController.add(
          ShowErrorSideEffect(message: failure.message),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
