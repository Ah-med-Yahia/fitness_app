import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';


import '../../../../core/constants/api_constants.dart';
import '../../data/models/meal/meals_response.dart';

import '../../domain/request/query_meal_request.dart';

part 'api_client.g.dart';
@injectable
@RestApi()
abstract class FoodDetailsApiClient {
  @factoryMethod
  factory FoodDetailsApiClient(Dio dio) = _FoodDetailsApiClient;

  // @GET('${.products}/{productId}')
  // Future<ProductDetailsDto> getProductDetails(
  //     @Path("productId") String productId);

  
  @GET(ApiConstants.meals)
  Future<MealsResponse> getMeals(
      @Queries() QueryMealRequest queryMealRequest);
}