import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/network/safe_api_call.dart';

import '../../data/data_source/food_remote_data_source.dart';
import '../../data/model/meals_category_response.dart';
import '../food_api_client/food_api_clients.dart';

@Injectable(as: FoodRemoteDataSourceContract)
class FoodCategoriesRemoteDataSourceImpl extends FoodRemoteDataSourceContract {
  final FoodApiClient _foodApiClient;

  FoodCategoriesRemoteDataSourceImpl(this._foodApiClient);

  @override
  Future<BaseResponse<MealsCategoryResponse>> getAllMealsCategories() {
    return safeApiCall(() => _foodApiClient.getAllCategories());
  }
}
