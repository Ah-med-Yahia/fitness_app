import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/core/request/query_request.dart';
import 'package:fitness_app/feature/food/data/repo/meal_repo_impl.dart';
import 'package:fitness_app/feature/food/domain/models/meals_entity.dart';

import 'package:fitness_app/feature/food/domain/use_cases/get_meals_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_meals_use_case_test.mocks.dart';
@GenerateMocks([MealRepoImpl])
void main() {
  test('Test for get meals use case ', () {
   final MealRepoImpl repoImpl=MockMealRepoImpl();
   final GetMealsUseCase useCase=GetMealsUseCase(repoImpl);
   final MealsEntity entity=MealsEntity();
   const DynamicQueries request= DynamicQueries(queriesData:
   [QueryData(key: 'c',value: 'seafood')]
   );;
   provideDummy<BaseResponse<MealsEntity>>(Success(entity));
   when(repoImpl.getMeals(request)).thenAnswer((_) async => Success(entity));
   useCase.invoke(request);
   verify(repoImpl.getMeals(request));
  },);

}