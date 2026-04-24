import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../core/request/query_request.dart';
import '../models/meals_entity.dart';
import '../repo/meal_repo_contract.dart';

@injectable
class GetMealsUseCase {
  final MealRepoContract _mealRepo;

  GetMealsUseCase(this._mealRepo);

  Future<BaseResponse<MealsEntity>> invoke(DynamicQueries query) {
    return _mealRepo.getMeals(query);
  }
}
