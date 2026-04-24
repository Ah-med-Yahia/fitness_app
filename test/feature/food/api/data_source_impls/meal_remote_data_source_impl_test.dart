import 'dart:io';

import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/api_exception.dart';
import 'package:fitness_app/core/request/query_request.dart';
import 'package:fitness_app/feature/food/api/api_client/api_client.dart';
import 'package:fitness_app/feature/food/api/data_source_impls/meal_remote_data_source_impl.dart';
import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';
import 'package:fitness_app/feature/food/data/models/meal/meals_response.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meal_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([FoodDetailsApiClient])
void main() {
  late FoodDetailsApiClient apiClient;
  late MealRemoteDataSourceImpl remoteDataSourceImpl;
  late MealsResponse mealsResponse;
  late MealDetailsResponse mealDetailsResponse;
  late DynamicQueries queryMealRequest;
  setUpAll(() {
    apiClient = MockFoodDetailsApiClient();
    remoteDataSourceImpl = MealRemoteDataSourceImpl(apiClient);
    mealsResponse = MealsResponse(
      meals: [Meals(idMeal: '1', strMeal: 'seafood')],
    );
    mealDetailsResponse = MealDetailsResponse(
      meals: [MealDto(strCategory: 'seafood')],
    );
    queryMealRequest = const DynamicQueries(
      queriesData: [QueryData(key: 'c', value: 'seafood')],
    );
  });
  group('meals by category', () {
    test('test for meal data source with success response', () async {
      when(
        apiClient.getMeals(queryMealRequest),
      ).thenAnswer((_) async => mealsResponse);
      final result =
          await remoteDataSourceImpl.getMeals(queryMealRequest)
              as Success<MealsResponse>;
      expect(result, isA<Success<MealsResponse>>());
      expect(result.data, equals(mealsResponse));
    });
    test('test for meal data source with failure response', () async {
      when(apiClient.getMeals(queryMealRequest)).thenThrow(IOException);
      final result =
          await remoteDataSourceImpl.getMeals(queryMealRequest)
              as Failure<MealsResponse>;
      expect(result, isA<Failure<MealsResponse>>());
      expect(result.exception, equals(isA<ApiException>()));
    });
  });
  group('meal details', () {
    test(
      'when call get meal details with success response it must get data ',
      () async {
        when(
          apiClient.getMealDetails(queryMealRequest),
        ).thenAnswer((_) async => mealDetailsResponse);
        final result =
            await remoteDataSourceImpl.getMealDetails(queryMealRequest)
                as Success<MealDetailsResponse>;
        expect(result, isA<Success<MealDetailsResponse>>());
        expect(result.data.meals?[0].strCategory, equals('seafood'));
      },
    );

    test(
      'when call get meal details with failure response it must get correct exception ',
      () async {
        when(apiClient.getMealDetails(queryMealRequest)).thenThrow(IOException);
        final result =
            await remoteDataSourceImpl.getMealDetails(queryMealRequest)
                as Failure<MealDetailsResponse>;
        expect(result, isA<Failure<MealDetailsResponse>>());
        expect(result.exception, equals(isA<ApiException>()));
      },
    );
  });
}
