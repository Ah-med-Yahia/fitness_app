import 'package:fitness_app/config/services/custom_cubit.dart';
import 'package:fitness_app/feature/food/domain/use_cases/get_meal_details_use_case.dart';
import 'package:fitness_app/feature/food/domain/use_cases/get_meals_use_case.dart';
import 'package:fitness_app/feature/food/presentation/view_model/meal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../core/request/query_request.dart';
import 'meal_intent.dart';
@injectable
class MealViewModel  extends Cubit<MealState>{
  final GetMealDetailsUseCase _getMealUseCase;
  MealViewModel(this._getMealUseCase):super(const MealState(mealState: BaseState()));
  Future<void> _getMealDetails(QueryRequest query)async
  {
    emit(state.copyWith(mealState: const BaseState(isLoading: true)));
   final response=await _getMealUseCase.invoke(query);
   emit(state.copyWith(mealState: response.toBaseState()));
  }
  void doIntent(MealIntent intent){
    switch(intent){
      case GetMealDetailsIntent():
        _getMealDetails(intent.query);
        break;
}
  }
}