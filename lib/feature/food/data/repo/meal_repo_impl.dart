import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/feature/food/domain/request/query_meal_request.dart';
import 'package:injectable/injectable.dart';


import '../../domain/models/meals_entity.dart';
import '../../domain/repo/meal_repo_contract.dart';
import '../data_sources/meal_remote_data_source_contract.dart';

@Injectable(as:MealRepoContract)
class MealRepoImpl implements MealRepoContract {
  final MealRemoteDataSourceContract remoteDataSource;
  MealRepoImpl(this.remoteDataSource);
  @override
  Future<BaseResponse<MealsEntity>> getMeals(QueryMealRequest queryMealRequest) async {
    final response = await remoteDataSource.getMeals(queryMealRequest);
    return response.when(
      success: (data) => BaseResponse.success( data.toEntity()),
      failure: (error) => BaseResponse.failure( error),
    );
  }
}
