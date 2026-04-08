import 'package:dio/dio.dart';
import 'package:fitness_app/app/features/auth/data/models/signup_request_model.dart';
import 'package:fitness_app/app/features/auth/data/models/signup_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:fitness_app/app/core/constants/api_constants.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

part 'auth_api_service.g.dart';

@injectable
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiService {
  @factoryMethod
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST(ApiConstants.signIn)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

  @POST(ApiConstants.signUp)
  Future<SignUpResponseModel> signUp(@Body() SignUpRequestModel request);
}
