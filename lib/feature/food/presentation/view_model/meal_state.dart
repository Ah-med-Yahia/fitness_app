import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/base_state/base_state.dart';

import '../../data/models/meal/meal_details_response.dart';

class MealState extends Equatable  {
  final BaseState<MealDetailsResponse> mealState;
  const MealState({
    required this.mealState,
  });
  MealState copyWith({
    BaseState<MealDetailsResponse>? mealState,
  }) {
    return MealState(
      mealState: mealState ?? this.mealState,
    );
  }
  @override
  List<Object?> get props => [mealState];

  }
