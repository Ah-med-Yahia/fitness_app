import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_constants.dart';
import '../../data/model/meals_category_response.dart';
part 'food_api_clients.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl1)
abstract class FoodApiClient {
  factory FoodApiClient(Dio dio, {String baseUrl}) = _FoodApiClient;

  @GET(ApiConstants.foodCategories)
  Future<MealsCategoryResponse> getAllCategories();
}
