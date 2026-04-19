import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/api_exception.dart';
import 'package:fitness_app/feature/food/api/api_client/api_client.dart';
import 'package:fitness_app/feature/food/api/data_source_impls/meal_remote_data_source_impl.dart';
import 'package:fitness_app/feature/food/data/models/meal/meals_response.dart';
import 'package:fitness_app/feature/food/domain/models/meals_entity.dart';
import 'package:fitness_app/feature/food/domain/request/query_meal_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([FoodDetailsApiClient])
void main() {
  late FoodDetailsApiClient apiClient;
  late MealRemoteDataSourceImpl remoteDataSourceImpl;
  late MealsResponse mealsResponse;
  late QueryMealRequest queryMealRequest;
setUpAll(() {
  apiClient=MockFoodDetailsApiClient();
  remoteDataSourceImpl=MealRemoteDataSourceImpl(apiClient);
  mealsResponse=MealsResponse(
    meals: [
      Meals(
        idMeal: '1',
        strMeal: 'seafood',
      ),
    ],
  );
  queryMealRequest=const QueryMealRequest(category: 'seafood');
},);
  test('test for meal data source with success response', ()async {
    when(apiClient.getMeals(queryMealRequest)).thenAnswer((_) async => mealsResponse);
    var result=await remoteDataSourceImpl.getMeals(queryMealRequest) as Success<MealsResponse>;
    expect(result, isA<Success<MealsResponse>>());
    expect(result.data, equals(mealsResponse));
  });
  test('test for meal data source with failure response', ()async {
    when(apiClient.getMeals(queryMealRequest)).thenThrow(IOException);
    var result=await remoteDataSourceImpl.getMeals(queryMealRequest) as Failure<MealsResponse>;
    expect(result, isA<Failure<MealsResponse>>());
    expect(result.exception, equals(isA<ApiException>()));
  });
}