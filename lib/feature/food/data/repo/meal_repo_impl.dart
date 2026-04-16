import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/feature/food/domain/request/query_meal_request.dart';
import 'package:injectable/injectable.dart';


import '../../domain/models/meals_entity.dart';
import '../../domain/repo/meal_repo_contract.dart';
import '../data_sources/meal_remote_data_source_contract.dart';

@Injectable(as:MealRepoContract)
class MealRepoImpl implements MealRepoContract {
  final MealRemoteDataSourceContract remoteDataSource;

  MealRepoImpl(this.remoteDataSource);

  // @override
  // Future<BaseResponse<ProductDetailsModel>> getProductDetails(String productId) async {
  //   final response = await remoteDataSource.getProductDetails(productId);
  //   switch (response) {
  //     case SuccessResponse<ProductDetailsDto>():
  //       return SuccessResponse<ProductDetailsModel>(data: response.data.toModel());
  //     case ErrorResponse<ProductDetailsDto>():
  //       return ErrorResponse<ProductDetailsModel>(error: response.error);
  //   }
  // }
  //
  // @override
  // Future<BaseResponse<UpdateCartModel>> addProductToCart({String? productId, int? quantity}) async {
  //   final response = await remoteDataSource.addProductToCart(productId: productId, quantity: quantity);
  //   switch (response) {
  //     case SuccessResponse<UpdateCartResponse>():
  //       return SuccessResponse<UpdateCartModel>(data: response.data.toModel());
  //     case ErrorResponse<UpdateCartResponse>():
  //       return ErrorResponse<UpdateCartModel>(error: response.error);
  //   }
  // }

  @override
  Future<BaseResponse<MealsEntity>> getMeals(QueryMealRequest queryMealRequest) async {
    final response = await remoteDataSource.getMeals(queryMealRequest);
    return response.when(
      success: (data) => BaseResponse.success( data.toEntity()),
      failure: (error) => BaseResponse.failure( error),
    );
    // switch (response) {
    //   case SuccessResponse<ProductsResponse>():
    //     return SuccessResponse<ProductsEntity>(data: response.data.toProductsEntity());
    //   case ErrorResponse<ProductsResponse>():
    //     return ErrorResponse<ProductsEntity>(error: response.error);
    // }
  }
}
