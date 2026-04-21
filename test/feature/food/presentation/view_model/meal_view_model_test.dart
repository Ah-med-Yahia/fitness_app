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
  late GetMealDetailsUseCase _useCase;
  late MealViewModel _viewModel;
  late MealDetailsResponse _response;
  late DynamicQueries _request;
  setUpAll(() {
    _useCase=MockGetMealDetailsUseCase();
    _response=MealDetailsResponse();
    _request=const DynamicQueries(queriesData: [
      QueryData(key: 'i',value: 'kofta')
    ]);
  },);
  setUp(() {
    _viewModel=MealViewModel(_useCase);
  },);
 blocTest('test for do intent get meal deatails intent with success',
   setUp: () {
     provideDummy<BaseResponse<MealDetailsResponse>>(Success(_response));
     when(_useCase.invoke(_request)).thenAnswer((_) => Future.value(Success(_response),));
   },
   build: () =>_viewModel ,
 act: (bloc) =>bloc.doIntent(GetMealDetailsIntent(_request)),
   expect: () {
     var state=const MealState(mealState: BaseState());
     return [
       state.copyWith(
         mealState: const BaseState(isLoading: true)
       ),
       state.copyWith(mealState: BaseState(
         isLoading: false,data: _response
       ))
     ];
   },
 );
  blocTest('test for do intent get meal details intent with failure',
    setUp: () {
      provideDummy<BaseResponse<MealDetailsResponse>>(Failure(ApiException('error')));
      when(_useCase.invoke(_request)).thenAnswer((_) => Future.value(Failure(ApiException('error'))));
    },
    build: () =>_viewModel ,
    act: (bloc) =>bloc.doIntent(GetMealDetailsIntent(_request)),
    expect: () {
      var state=const MealState(mealState: BaseState());
      return [
        state.copyWith(
            mealState: const BaseState(isLoading: true)
        ),
        state.copyWith(mealState: BaseState(
            isLoading: false,error: ApiException('error')
        ))
      ];
    },
  );
}