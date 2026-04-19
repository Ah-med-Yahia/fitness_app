import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../core/request/query_request.dart';
import '../models/meals_entity.dart';
import '../repo/meal_repo_contract.dart';
import '../request/query_meal_request.dart';

@injectable
class GetMealsUseCase {
  final MealRepoContract _mealRepo;

  GetMealsUseCase(this._mealRepo);

  Future<BaseResponse<MealsEntity>> invoke(
    QueryRequest query,
  ) {
    return _mealRepo.getMeals(query);
  }
}
