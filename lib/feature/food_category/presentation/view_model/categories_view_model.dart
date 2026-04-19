import 'dart:developer';

import 'package:fitness_app/feature/food/domain/use_cases/get_meals_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';

import '../../../../config/services/custom_cubit.dart';
import '../../../food/domain/request/query_meal_request.dart';
import '../../domain/use_case/get_all_food_use_case.dart';
import 'categories_event.dart';
import 'categories_intent.dart';
import 'categories_state.dart';
@injectable
class CategoriesViewModel
    extends CustomCubit<CategoriesEvent, CategoriesState> {
  final GetAllFoodCategoriesUseCase _categoriesUseCase;
  final GetMealsUseCase _mealsCategoryUseCase;
  CategoriesViewModel(this._categoriesUseCase,
      this._mealsCategoryUseCase
      )
    : super(
        const CategoriesState(
          categoriesState: CategoryBaseState(),
          mealsCategoryState: BaseState(),
        ),
      );
  late var baseState = state;

  Future<void> _getAllCategories() async {
    baseState = state.copyWith(
      categoriesState: const CategoryBaseState(isLoading: true),
    );
    emit(state.copyWith(
      categoriesState: const CategoryBaseState(isLoading: true),
    ));
    final response = await _categoriesUseCase.invoke();

    response.when(success: (data) {
      baseState = state.copyWith(
        categoriesState: CategoryBaseState(
          isLoading: false,
          data: data,
        ),
      );
      emit(state.copyWith(
        categoriesState: CategoryBaseState(
          isLoading: false,
          data: data,
        ),
      ));
      if (state.categoriesState.data?.categoriesEntity?.isNotEmpty ??
              false) {
            _getMealsCategory(
              '${state.categoriesState.data?.categoriesEntity?[0].title}',
          );
          }
    },
        failure: (exception) {
          baseState = state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              error: exception,
            ),
          );
          emit(state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              error: exception,
            ),
          ));
        },);

  }

  void _getCategory({int? index,}) {
    if (index != null) {
      baseState = state.copyWith(
        categoriesState: CategoryBaseState(index: index),
      );
      emit(baseState);

    }
    _getMealsCategory(
        '${baseState.categoriesState.data?.categoriesEntity?[baseState
            .categoriesState.index].title}',);
  }

  Future<void> _getMealsCategory(String categoryId) async {
    emit(
      state.copyWith(
        mealsCategoryState: const BaseState(isLoading: true),
        clearSuccess: true,
        clearError: true,
      ),
    );
    final response = await _mealsCategoryUseCase.invoke(
      QueryMealRequest(category: categoryId),
    );
    response.when(success: (data) {
      emit(
        state.copyWith(
          mealsCategoryState: BaseState(
            isLoading: false,
            data: data,
          ),
          clearError: true,
        ),
      );
    }, failure: (exception) {
      emit(
        state.copyWith(
          mealsCategoryState: BaseState(
            isLoading: false,
            error: exception,
          ),
          clearSuccess: true,
        ),
      );
    });

  }

  void doIntent(CategoriesIntent intent) {
    switch (intent) {
      case CategoriesAction():
        _getAllCategories();
        break;
      case GetCategoryIntent():
        _getCategory(index: intent.index);
        break;
      case GetProductsCategoryIntent():
        _getMealsCategory(intent.categoryId);
        break;

    }
  }
}
