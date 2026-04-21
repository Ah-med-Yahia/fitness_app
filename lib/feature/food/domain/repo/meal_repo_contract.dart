
import '../../../../config/base_response/base_response.dart';
import '../../../../core/request/query_request.dart';
import '../../data/models/meal/meal_details_response.dart';
import '../models/meals_entity.dart';


abstract class MealRepoContract {
  Future<BaseResponse<MealDetailsResponse>> getMealDetails(DynamicQueries query);

  Future<BaseResponse<MealsEntity>> getMeals(
    DynamicQueries query,
  );
}
