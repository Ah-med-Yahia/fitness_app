import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../domain/model/food_entity.dart';
import '../../domain/repository/food_repo_contract.dart';
import '../data_source/food_remote_data_source.dart';

@Injectable(as: FoodCategoriesRepoContract)
class FoodCategoriesRepositoryImpl extends FoodCategoriesRepoContract {
  final FoodRemoteDataSourceContract _categoriesRemoteDataSource;

  FoodCategoriesRepositoryImpl(this._categoriesRemoteDataSource);

  @override
  Future<BaseResponse<FoodCategoriesEntity>> getAllCategories() async {
    final response = await _categoriesRemoteDataSource.getAllMealsCategories();
    return response.when(
      success: (data) => BaseResponse.success(data.toFoodCategoriesEntity()),
      failure: (exception) => BaseResponse.failure(exception),
    );
  }
}
