import '../../../../config/base_response/base_response.dart';
import '../model/food_entity.dart';

abstract class FoodCategoriesRepoContract {
  Future<BaseResponse<FoodCategoriesEntity>> getAllCategories();
}
