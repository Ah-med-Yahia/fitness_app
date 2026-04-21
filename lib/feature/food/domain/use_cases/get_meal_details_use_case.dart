import 'package:fitness_app/feature/food/domain/repo/meal_repo_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/request/query_request.dart';
import '../../data/models/meal/meal_details_response.dart';
@injectable
class GetMealDetailsUseCase {
  final MealRepoContract _mealRepo;
  GetMealDetailsUseCase(this._mealRepo);
  Future<BaseResponse<MealDetailsResponse>> invoke(DynamicQueries query){
    return _mealRepo.getMealDetails(query);
  }
  }

