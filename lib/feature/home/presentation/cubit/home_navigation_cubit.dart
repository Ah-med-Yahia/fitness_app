import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_navigation_state.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {
  HomeNavigationCubit() : super(const HomeNavigationState());

  void changeTab(HomeTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}
