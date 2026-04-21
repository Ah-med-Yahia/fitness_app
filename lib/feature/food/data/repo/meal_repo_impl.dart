import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';

import 'package:injectable/injectable.dart';


import '../../../../core/request/query_request.dart';
import '../../domain/models/meals_entity.dart';
import '../../domain/repo/meal_repo_contract.dart';
import '../data_sources/meal_remote_data_source_contract.dart';

@Injectable(as:MealRepoContract)
class MealRepoImpl implements MealRepoContract {
  final MealRemoteDataSourceContract remoteDataSource;

  MealRepoImpl(this.remoteDataSource);



  @override
  Future<BaseResponse<MealsEntity>> getMeals(DynamicQueries query) async {
    final response = await remoteDataSource.getMeals(query);
    return response.when(
      success: (data) => BaseResponse.success( data.toEntity()),
      failure: (error) => BaseResponse.failure( error),
    );

  }

  @override
  Future<BaseResponse<MealDetailsResponse>> getMealDetails(DynamicQueries query) {
   return remoteDataSource.getMealDetails(query);
  }
}
