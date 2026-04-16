import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../models/meals_entity.dart';
import '../repo/meal_repo_contract.dart';
import '../request/query_meal_request.dart';

@injectable
class GetMealsUseCase {
  final MealRepoContract _mealRepo;

  GetMealsUseCase(this._mealRepo);

  Future<BaseResponse<MealsEntity>> invoke(
    QueryMealRequest queryMealRequest,
  ) {
    return _mealRepo.getMeals(queryMealRequest);
  }
}
