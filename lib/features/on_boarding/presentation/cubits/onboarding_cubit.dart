import 'package:fitness_app/features/on_boarding/presentation/cubits/onboarding_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/on_boarding/presentation/cubits/on_boarding_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(const OnBoardingStates());
  void doIntent(OnboardingIntents intent) {
    switch (intent) {
      case UpdateCurrentPageIntent(page: final page):
        _updateCurrentPage(page);
    }
  }

  void _updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }
}
