import 'package:dio/dio.dart';
import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/request/query_request.dart';
import '../../data/models/meal/meals_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class FoodDetailsApiClient {
  factory FoodDetailsApiClient(Dio dio, {String baseUrl}) =
      _FoodDetailsApiClient;
  @GET(ApiConstants.meals)
  Future<MealsResponse> getMeals(@Queries() DynamicQueries query);
  @GET(ApiConstants.mealDetails)
  Future<MealDetailsResponse> getMealDetails(@Queries() DynamicQueries query);
}
