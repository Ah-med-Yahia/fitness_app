import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/network/safe_api_call.dart';
import '../../../../core/request/query_request.dart';
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
  @override
  Future<BaseResponse<MealsResponse>> getMeals(
      QueryRequest query) =>
      safeApiCall(() => apiClient.getMeals(query));

  @override
  Future<BaseResponse<MealDetailsResponse>> getMealDetails(QueryRequest query) =>
      safeApiCall(() => apiClient.getMealDetails(query));
}
