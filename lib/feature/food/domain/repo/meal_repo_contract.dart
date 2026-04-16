
import '../../../../config/base_response/base_response.dart';
import '../models/meals_entity.dart';
import '../request/query_meal_request.dart';

abstract class MealRepoContract {
  // Future<BaseResponse<P>> getProductDetails(String productId);
  //
  // Future<BaseResponse<UpdateCartModel>> addProductToCart(
  //     {String? productId, int? quantity});
  Future<BaseResponse<MealsEntity>> getMeals(
    QueryMealRequest queryMealRequest,
  );
}
