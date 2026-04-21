

import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';

import '../model/food_entity.dart';
import '../repository/food_repo_contract.dart';

@injectable
class GetAllFoodCategoriesUseCase {
  final FoodCategoriesRepoContract _categoriesRepoContract;

  GetAllFoodCategoriesUseCase(this._categoriesRepoContract);

  Future<BaseResponse<FoodCategoriesEntity>> invoke() {
    return _categoriesRepoContract.getAllCategories();
  }
}
