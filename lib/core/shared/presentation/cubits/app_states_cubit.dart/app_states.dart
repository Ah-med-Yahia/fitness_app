import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final OnboardingStatus? status;
  final bool isLoading;
  const AppState({this.status, this.isLoading = true});

  @override
  List<Object?> get props => [status, isLoading];
}

enum OnboardingStatus { newUser, returningNotLoggedIn, loggedIn }
