
import '../../../../config/base_response/base_response.dart';
import '../../../../core/request/query_request.dart';
import '../../data/models/meal/meal_details_response.dart';
import '../models/meals_entity.dart';
import '../request/query_meal_request.dart';

abstract class MealRepoContract {
  Future<BaseResponse<MealDetailsResponse>> getMealDetails(QueryRequest query);

  Future<BaseResponse<MealsEntity>> getMeals(
    QueryRequest query,
  );
}
