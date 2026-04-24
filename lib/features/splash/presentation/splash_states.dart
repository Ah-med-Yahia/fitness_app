import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/shared/domain/use_cases/app_states_use_cases/get_app_status_use_case.dart';

class SplashStates extends Equatable {
  final UserInitialStatus? userInitialStatus;
  final bool isLoading;
  const SplashStates({this.userInitialStatus, this.isLoading = true});
  SplashStates copyWith({
    UserInitialStatus? userInitialStatus,
    bool? isLoading,
  }) {
    return SplashStates(
      userInitialStatus: userInitialStatus ?? this.userInitialStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [userInitialStatus, isLoading];
}
