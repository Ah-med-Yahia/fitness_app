import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/api_constants.dart';
import '../../data/models/meal/meals_response.dart';

import '../../domain/request/query_meal_request.dart';

part 'api_client.g.dart';

@RestApi()
abstract class FoodDetailsApiClient {

  factory FoodDetailsApiClient(Dio dio, {String baseUrl}) = _FoodDetailsApiClient;
  @GET(ApiConstants.meals)
  Future<MealsResponse> getMeals(
      @Queries() QueryMealRequest queryMealRequest);
}