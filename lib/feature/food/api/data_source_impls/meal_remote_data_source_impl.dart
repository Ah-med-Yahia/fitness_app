import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/network/safe_api_call.dart';
import '../../../food_category/data/data_source/food_remote_data_source.dart';
import '../../data/data_sources/meal_remote_data_source_contract.dart';
import '../../data/models/meal/meals_response.dart';
import '../../domain/request/query_meal_request.dart';
import '../api_client/api_client.dart';

@Injectable(as: MealRemoteDataSourceContract)
class MealRemoteDataSourceImpl
    implements MealRemoteDataSourceContract {
  FoodDetailsApiClient apiClient;
  MealRemoteDataSourceImpl(this.apiClient);
  // @override
  // Future<BaseResponse<ProductDetailsDto>> getProductDetails(
  //     String productId) async =>
  //     executeApi(() => apiClient.getProductDetails(productId));
  //
  // @override
  // Future<BaseResponse<UpdateCartResponse>> addProductToCart(
  //     {String? productId, int? quantity}) async {
  //   return await executeApi(() =>
  //       apiClient.addProductToCart({
  //         "product": productId,
  //         "quantity": quantity
  //       }));
  // }
  @override
  Future<BaseResponse<MealsResponse>> getMeals(
      QueryMealRequest queryMealRequest) =>
      safeApiCall(() => apiClient.getMeals(queryMealRequest));
}
