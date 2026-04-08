import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_navigation_cubit.dart';
import '../cubit/home_navigation_state.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'workouts_screen.dart';
import 'tabs_demo_screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavigationCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
        builder: (context, state) {
          return Stack(
            children: [
              IndexedStack(
                index: state.selectedTab.index,
                children: const [
                  HomeTabScreen(),
                  SmartCoachScreen(),
                  WorkoutsScreen(),
                  ProfileScreen(),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CustomBottomNavBar(
                  selectedTab: state.selectedTab,
                  onTabSelected: (tab) {
                    context.read<HomeNavigationCubit>().changeTab(tab);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
