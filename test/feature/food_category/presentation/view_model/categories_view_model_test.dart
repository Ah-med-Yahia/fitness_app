import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/errors/api_exception.dart';

import 'package:fitness_app/feature/food/domain/models/meals_entity.dart';
import 'package:fitness_app/feature/food/domain/request/query_meal_request.dart';
import 'package:fitness_app/feature/food/domain/use_cases/get_meals_use_case.dart';
import 'package:fitness_app/feature/food_category/domain/model/food_entity.dart';
import 'package:fitness_app/feature/food_category/domain/use_case/get_all_food_use_case.dart';
import 'package:fitness_app/feature/food_category/presentation/view_model/categories_intent.dart';
import 'package:fitness_app/feature/food_category/presentation/view_model/categories_state.dart';
import 'package:fitness_app/feature/food_category/presentation/view_model/categories_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_view_model_test.mocks.dart';



@GenerateMocks([GetAllFoodCategoriesUseCase, GetMealsUseCase])
void main() {
  late GetAllFoodCategoriesUseCase allCategoriesUseCase;
  late GetMealsUseCase mealsUseCase;
  late CategoriesViewModel categoriesViewModel;
  late FoodCategoriesEntity categoriesEntity;
  late MealsEntity mealsEntity;
  late QueryMealRequest querymealRequest;
  setUpAll(() {
    allCategoriesUseCase = MockGetAllFoodCategoriesUseCase();
    mealsUseCase = MockGetMealsUseCase();
    categoriesEntity = const FoodCategoriesEntity(
      categoriesEntity: [
        FoodCategoryEntity(
          id: '1',
          title: 'seafood',
        ),
      ],
    );
    mealsEntity = MealsEntity(
      meals: [
        Meal(
          idMeal: '1',
          strMeal: 'seafood',
        ),
      ],
    );
    querymealRequest = const QueryMealRequest(category: 'seafood');
  });
  setUp(() {
    categoriesViewModel = CategoriesViewModel(
      allCategoriesUseCase,
      mealsUseCase,
    );
  });
  group('get all categories intent', () {
    blocTest(
      'when calling dointent with categories action with success it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<FoodCategoriesEntity>>(
          Success(categoriesEntity),
        );
        provideDummy<BaseResponse<MealsEntity>>(
          Success(mealsEntity),
        );
        when(allCategoriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(Success(categoriesEntity));
        });
        when(mealsUseCase.invoke(querymealRequest)).thenAnswer(
              (realInvocation) {
            return Future.value(Success( mealsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(CategoriesAction());
      },
      expect: () {
        var state = const CategoriesState(
          categoriesState: CategoryBaseState(),
          mealsCategoryState: BaseState(),
        );
        return [
          state.copyWith(categoriesState: const CategoryBaseState(isLoading: true)),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              data: categoriesEntity,
            ),
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              data: categoriesEntity,
            ),
            mealsCategoryState: const BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              data: categoriesEntity,
            ),
            mealsCategoryState: BaseState(
              isLoading: false,
              data: mealsEntity,
            ),
            clearError: true,
          ),
        ];
      },
    );

    blocTest(
      'when calling dointent with categories action with error it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<FoodCategoriesEntity>>(
          Failure(ApiException('error')),
        );

        when(allCategoriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(Failure(ApiException('error')));
        });
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(CategoriesAction());
      },
      expect: () {
        var state = const CategoriesState(
          categoriesState: CategoryBaseState(),
          mealsCategoryState: BaseState(),
        );
        return [
          state.copyWith(categoriesState: const CategoryBaseState(isLoading: true)),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              error: ApiException('error'),
            ),
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with categories action with success and error in get products it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<FoodCategoriesEntity>>(
          Success( categoriesEntity),
        );
        provideDummy<BaseResponse<MealsEntity>>(
            Failure(ApiException('error'))
        );
        when(allCategoriesUseCase.invoke()).thenAnswer((realInvocation) {
          return Future.value(Success(categoriesEntity));
        });
        when(mealsUseCase.invoke(querymealRequest)).thenAnswer(
              (realInvocation) {
            return Future.value(Failure(ApiException('error')));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(CategoriesAction());
      },
      expect: () {
        var state = const CategoriesState(
          categoriesState: CategoryBaseState(), mealsCategoryState: BaseState(),
        );
        return [
          state.copyWith(categoriesState: const CategoryBaseState(isLoading: true)),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              data: categoriesEntity,
            ),
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              data: categoriesEntity,
            ),
            mealsCategoryState: const BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            categoriesState: CategoryBaseState(
              isLoading: false,
              data: categoriesEntity,
            ),
            mealsCategoryState: BaseState(
              isLoading: false,
              error: ApiException('error'),
            ),
            clearSuccess: true,
          ),
        ];
      },
    );
  });
  group('get category intent', () {
    blocTest(
      'when calling dointent with get category with success in get products intent it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<MealsEntity>>(
          Success(mealsEntity),
        );

        when(mealsUseCase.invoke(querymealRequest)).thenAnswer(
              (realInvocation) {
            return Future.value(Success( mealsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(GetCategoryIntent(index: 0));
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(categoriesState: const CategoryBaseState(index: 0)),
          state.copyWith(
            mealsCategoryState: const BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            mealsCategoryState: BaseState(
              isLoading: false,
              data: mealsEntity,
            ),
            clearError: true,
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with get category with error in get products intent it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<MealsEntity>>(
            Failure(ApiException('error')),
        );

        when(mealsUseCase.invoke(querymealRequest)).thenAnswer(
              (realInvocation) {
            return Future.value(Failure(ApiException('error')));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(GetCategoryIntent(index: 0));
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(categoriesState: const CategoryBaseState(index: 0)),
          state.copyWith(
          mealsCategoryState: const BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            mealsCategoryState: BaseState(
              isLoading: false,
              error: ApiException('error'),
            ),
            clearSuccess: true,
          ),
        ];
      },
    );
  });
  group('get products category intent', () {
    blocTest(
      'when calling dointent with get products category with success  it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<MealsEntity>>(
          Success( mealsEntity),
        );
        when(mealsUseCase.invoke(querymealRequest)).thenAnswer(
              (realInvocation) {
            return Future.value(Success( mealsEntity));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(
          GetProductsCategoryIntent(categoryId: '1'),
        );
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(
            mealsCategoryState: const BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            mealsCategoryState: BaseState(
              isLoading: false,
              data: mealsEntity,
            ),
            clearError: true,
          ),
        ];
      },
    );
    blocTest(
      'when calling dointent with get products category with error  it should emit correct state',
      setUp: () {
        provideDummy<BaseResponse<MealsEntity>>(
          Failure(ApiException('error')),
        );
        when(mealsUseCase.invoke(querymealRequest)).thenAnswer(
              (realInvocation) {
            return Future.value(Failure(ApiException('error')));
          },
        );
      },
      build: () => categoriesViewModel,
      act: (bloc) {
        categoriesViewModel.doIntent(
          GetProductsCategoryIntent(categoryId: '1'),
        );
      },
      expect: () {
        var state = categoriesViewModel.baseState;
        return [
          state.copyWith(
            mealsCategoryState: const BaseState(isLoading: true),
            clearSuccess: true,
            clearError: true,
          ),
          state.copyWith(
            mealsCategoryState: BaseState(
              isLoading: false,
              error: ApiException('error'),
            ),
            clearSuccess: true,
          ),
        ];
      },
    );
  });

}
