import 'package:fitness_app/config/di/di.dart';
import 'package:fitness_app/core/request/query_request.dart';
import 'package:fitness_app/core/reusable_widgets/custom_error_widget.dart';
import 'package:fitness_app/core/reusable_widgets/loading_widget.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/feature/food/presentation/view/widget/meal_details_widget.dart';
import 'package:fitness_app/feature/food/presentation/view_model/meal_intent.dart';
import 'package:fitness_app/feature/food/presentation/view_model/meal_state.dart';
import 'package:fitness_app/feature/food/presentation/view_model/meal_view_model.dart';
import 'package:fitness_app/features/auth/presentation/view/widgets/login_background_layers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealDetailsScreen extends StatelessWidget {
  MealDetailsScreen({super.key, required this.mealId});
  final String mealId;
  final MealViewModel mealViewModel = getIt<MealViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealViewModel, MealState>(
      bloc: mealViewModel
        ..doIntent(
          GetMealDetailsIntent(
            DynamicQueries(
              queriesData: [QueryData(key: 'i', value: mealId)],
            ),
            // QueryRequest(queryKey: 'i',queryValue: mealId)
          ),
        ),
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            const LoginBackgroundLayers(),
            SafeArea(
              child: SingleChildScrollView(
                child: state.mealState.isLoading
                    ? const LoadingWidget()
                    : state.mealState.data != null
                    ? MealDetailsWidget(meal: state.mealState.data!)
                    : state.mealState.error != null
                    ? CustomErrorWidget(
                        errorMessage: state.mealState.error?.message ?? '',
                        onRetry: () {
                          mealViewModel.doIntent(
                            GetMealDetailsIntent(
                              DynamicQueries(
                                queriesData: [
                                  QueryData(key: 'i', value: mealId),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
