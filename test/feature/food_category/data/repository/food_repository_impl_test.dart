import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/feature/food_category/data/data_source/food_remote_data_source.dart';
import 'package:fitness_app/feature/food_category/data/model/meals_category_response.dart';
import 'package:fitness_app/feature/food_category/data/repository/food_repository_impl.dart';
import 'package:fitness_app/feature/food_category/domain/model/food_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_repository_impl_test.mocks.dart';

@GenerateMocks([FoodRemoteDataSourceContract])
void main() {
  test('when calling get all categories it call data source', () async {
    final FoodRemoteDataSourceContract remoteDataSourceContract =
        MockFoodRemoteDataSourceContract();
    final FoodCategoriesRepositoryImpl categoriesRepoImpl =
        FoodCategoriesRepositoryImpl(remoteDataSourceContract);
    final MealsCategoryResponse mealsResponse = MealsCategoryResponse(
      categories: [Categories(idCategory: '1', strCategory: 'seafood')],
    );
    provideDummy<BaseResponse<MealsCategoryResponse>>(Success(mealsResponse));
    when(
      remoteDataSourceContract.getAllMealsCategories(),
    ).thenAnswer((_) async => Success(mealsResponse));
    final result = await categoriesRepoImpl.getAllCategories();
    expect(result, isA<Success<FoodCategoriesEntity>>());
    verify(remoteDataSourceContract.getAllMealsCategories());
  });
}
