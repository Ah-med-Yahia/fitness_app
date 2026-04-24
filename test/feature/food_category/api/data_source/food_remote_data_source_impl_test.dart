import 'dart:io';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/errors/api_exception.dart';
import 'package:fitness_app/feature/food_category/api/data_source/food_remote_data_source_impl.dart';
import 'package:fitness_app/feature/food_category/api/food_api_client/food_api_clients.dart';
import 'package:fitness_app/feature/food_category/data/model/meals_category_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'food_remote_data_source_impl_test.mocks.dart';
@GenerateMocks([FoodApiClient])
void main() {
  late FoodApiClient apiClient;
  late FoodCategoriesRemoteDataSourceImpl remoteDataSourceImpl;
  late MealsCategoryResponse mealsResponse;
  setUpAll(() {
    apiClient = MockFoodApiClient();
    remoteDataSourceImpl = FoodCategoriesRemoteDataSourceImpl(apiClient);
    mealsResponse = MealsCategoryResponse(
      categories: [
        Categories(
          idCategory: '1',
          strCategory: 'seafood',
        ),
      ],
    );
  });


  test(
    'when calling get all categories and api return success it should return data',
        () async {
      when(
        apiClient.getAllCategories(),
      ).thenAnswer((_) async => mealsResponse);
      var result =
      await remoteDataSourceImpl.getAllMealsCategories() as Success<MealsCategoryResponse>;
      expect(result, isA<Success<MealsCategoryResponse>>());
      expect(result.data, equals(mealsResponse));
      expect(result.data.categories?[0].strCategory, equals('seafood'));
    },
  );
  test(
    'when calling get all categories and api return error it should return correct error',
        () async {
      when(apiClient.getAllCategories()).thenThrow(IOException);
      var result =
      await remoteDataSourceImpl.getAllMealsCategories()
      as Failure<MealsCategoryResponse>;
      expect(result, isA<Failure<MealsCategoryResponse>>());
      expect(result.exception, equals(isA<ApiException>()));
    },
  );
}
