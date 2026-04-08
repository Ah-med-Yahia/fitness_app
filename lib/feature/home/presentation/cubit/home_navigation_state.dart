import 'package:equatable/equatable.dart';

enum HomeTab { home, smartCoach, workouts, profile }

class HomeNavigationState extends Equatable {
  final HomeTab selectedTab;

  const HomeNavigationState({this.selectedTab = HomeTab.workouts});

  @override
  List<Object> get props => [selectedTab];

  HomeNavigationState copyWith({HomeTab? selectedTab}) {
    return HomeNavigationState(selectedTab: selectedTab ?? this.selectedTab);
  }
}
