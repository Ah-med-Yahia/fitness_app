import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:fitness_app/core/constants/api_constants.dart';

import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';


part 'auth_api_service.g.dart';

@injectable
@RestApi()
abstract class AuthApiService {
  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(ApiConstants.signIn)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);
}
