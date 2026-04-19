

import '../../../../config/base_response/base_response.dart';

import '../../domain/request/query_meal_request.dart';
import '../models/meal/meals_response.dart';


abstract class MealRemoteDataSourceContract {
  Future<BaseResponse<MealsResponse>> getMeals(
      QueryMealRequest queryProductRequest);
}


