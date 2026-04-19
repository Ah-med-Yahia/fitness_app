import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../food/domain/models/meals_entity.dart';
import '../../domain/model/food_entity.dart';
class CategoriesState extends Equatable {
  final CategoryBaseState categoriesState;
  final BaseState<MealsEntity> mealsCategoryState;
  const CategoriesState({
    required this.categoriesState,
    required this.mealsCategoryState,
  });
  CategoriesState copyWith({
    CategoryBaseState? categoriesState,
    BaseState<MealsEntity>? mealsCategoryState,
    bool clearSuccess = false,
    bool clearError = false,
  }) {
    return CategoriesState(
      categoriesState: CategoryBaseState(
        isLoading: categoriesState?.isLoading ?? this.categoriesState.isLoading,
        data: categoriesState?.data ?? this.categoriesState.data,
        error: categoriesState?.error ?? this.categoriesState.error,
        index: categoriesState?.index ?? this.categoriesState.index,
      ),
      mealsCategoryState: BaseState(
        isLoading:
            mealsCategoryState?.isLoading ??
            this.mealsCategoryState.isLoading,
        data: clearSuccess
            ? null
            : (mealsCategoryState?.data ??
                  this.mealsCategoryState.data),
        error: clearError
            ? null
            : (mealsCategoryState?.error ??
                  this.mealsCategoryState.error),
      ),
    );
  }

  @override
  List<Object?> get props => [categoriesState,mealsCategoryState];


}

class CategoryBaseState extends BaseState<FoodCategoriesEntity> with EquatableMixin {
  const CategoryBaseState({
    this.index = 0,
    super.isLoading,
    super.data,
    super.error,
  });

  final int index;
  @override
  List<Object?> get props => [index, isLoading, data, error];
}
