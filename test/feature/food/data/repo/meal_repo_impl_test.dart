import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/feature/food/api/data_source_impls/meal_remote_data_source_impl.dart';
import 'package:fitness_app/feature/food/data/models/meal/meals_response.dart';
import 'package:fitness_app/feature/food/data/repo/meal_repo_impl.dart';
import 'package:fitness_app/feature/food/domain/models/meals_entity.dart';
import 'package:fitness_app/feature/food/domain/request/query_meal_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'meal_repo_impl_test.mocks.dart';
@GenerateMocks([MealRemoteDataSourceImpl])
void main() {
  late MealRemoteDataSourceImpl remoteDataSourceImpl;
  late MealRepoImpl repoImpl;
  late MealsEntity mealsEntity;
  late QueryMealRequest queryMealRequest;
  setUpAll(() {
    remoteDataSourceImpl=MockMealRemoteDataSourceImpl();
    repoImpl=MealRepoImpl(remoteDataSourceImpl);
    mealsEntity=MealsEntity();
    queryMealRequest=const QueryMealRequest(category: 'seafood');
  },);
  test('test for meal repo ', () {
    provideDummy<BaseResponse<MealsResponse>>(Success(MealsResponse()));
    when(remoteDataSourceImpl.getMeals(queryMealRequest)).thenAnswer((_) async => Success(MealsResponse()));
    repoImpl.getMeals(queryMealRequest);
    verify(remoteDataSourceImpl.getMeals(queryMealRequest));
  },);

}