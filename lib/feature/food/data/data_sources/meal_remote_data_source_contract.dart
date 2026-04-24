import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';

import '../../../../config/base_response/base_response.dart';

import '../../../../core/request/query_request.dart';

import '../models/meal/meals_response.dart';

abstract class MealRemoteDataSourceContract {
  Future<BaseResponse<MealDetailsResponse>> getMealDetails(
    DynamicQueries query,
  );

  Future<BaseResponse<MealsResponse>> getMeals(DynamicQueries query);
}
