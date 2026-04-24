import '../../../../config/base_response/base_response.dart';
import '../model/meals_category_response.dart';

abstract class FoodRemoteDataSourceContract {
  Future<BaseResponse<MealsCategoryResponse>> getAllMealsCategories();
}
