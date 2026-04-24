import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/feature/food_category/data/repository/food_repository_impl.dart';
import 'package:fitness_app/feature/food_category/domain/model/food_entity.dart';
import 'package:fitness_app/feature/food_category/domain/use_case/get_all_food_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_food_use_case_test.mocks.dart';



@GenerateMocks([FoodCategoriesRepositoryImpl])
void main() {
  test('when calling get all categories it call data source', () async {
    final FoodCategoriesRepositoryImpl categoriesRepoImpl =
    MockFoodCategoriesRepositoryImpl();
    final GetAllFoodCategoriesUseCase getAllCategoriesUseCase = GetAllFoodCategoriesUseCase(categoriesRepoImpl);
const FoodCategoriesEntity entity=FoodCategoriesEntity();
    provideDummy<BaseResponse<FoodCategoriesEntity>>(
      const Success(entity),
    );
    when(
      categoriesRepoImpl.getAllCategories(),
    ).thenAnswer((_) async => const Success(entity));
    var result = await getAllCategoriesUseCase.invoke();
    expect(result, isA<Success<FoodCategoriesEntity>>());
    verify(categoriesRepoImpl.getAllCategories());
  });
}
