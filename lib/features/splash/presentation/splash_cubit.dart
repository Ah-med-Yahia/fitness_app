import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/get_app_status_use_case.dart';
import 'package:fitness_app/features/splash/presentation/splash_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashCubit extends Cubit<SplashStates> {
  final GetAppStatusUseCase getAppStatusUseCase;
  SplashCubit({required this.getAppStatusUseCase})
    : super(const SplashStates()) {
    getAppStatus();
  }
  void getAppStatus() async {
    final result = await getAppStatusUseCase();
    emit(state.copyWith(userInitialStatus: result, isLoading: false));
  }
}
