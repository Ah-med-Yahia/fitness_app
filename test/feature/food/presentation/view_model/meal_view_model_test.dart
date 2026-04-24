import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/base_state/base_state.dart';
import 'package:fitness_app/config/errors/api_exception.dart';
import 'package:fitness_app/core/request/query_request.dart';
import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';
import 'package:fitness_app/feature/food/domain/use_cases/get_meal_details_use_case.dart';
import 'package:fitness_app/feature/food/presentation/view_model/meal_intent.dart';
import 'package:fitness_app/feature/food/presentation/view_model/meal_state.dart';
import 'package:fitness_app/feature/food/presentation/view_model/meal_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'meal_view_model_test.mocks.dart';

@GenerateMocks([GetMealDetailsUseCase])
void main() {
  late GetMealDetailsUseCase useCase;
  late MealViewModel viewModel;
  late MealDetailsResponse response;
  late DynamicQueries request;
  setUpAll(() {
    useCase = MockGetMealDetailsUseCase();
    response = MealDetailsResponse();
    request = const DynamicQueries(
      queriesData: [QueryData(key: 'i', value: 'kofta')],
    );
  });
  setUp(() {
    viewModel = MealViewModel(useCase);
  });
  blocTest(
    'test for do intent get meal deatails intent with success',
    setUp: () {
      provideDummy<BaseResponse<MealDetailsResponse>>(Success(response));
      when(
        useCase.invoke(request),
      ).thenAnswer((_) => Future.value(Success(response)));
    },
    build: () => viewModel,
    act: (bloc) => bloc.doIntent(GetMealDetailsIntent(request)),
    expect: () {
      const state = MealState(mealState: BaseState());
      return [
        state.copyWith(mealState: const BaseState(isLoading: true)),
        state.copyWith(mealState: BaseState(isLoading: false, data: response)),
      ];
    },
  );
  blocTest(
    'test for do intent get meal details intent with failure',
    setUp: () {
      provideDummy<BaseResponse<MealDetailsResponse>>(
        Failure(ApiException('error')),
      );
      when(
        useCase.invoke(request),
      ).thenAnswer((_) => Future.value(Failure(ApiException('error'))));
    },
    build: () => viewModel,
    act: (bloc) => bloc.doIntent(GetMealDetailsIntent(request)),
    expect: () {
      const state = MealState(mealState: BaseState());
      return [
        state.copyWith(mealState: const BaseState(isLoading: true)),
        state.copyWith(
          mealState: BaseState(isLoading: false, error: ApiException('error')),
        ),
      ];
    },
  );
}
