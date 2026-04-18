import 'package:fitness_app/app/features/auth/data/models/signup_request_model.dart';
import 'package:fitness_app/app/features/auth/data/models/signup_response_model.dart';
import 'package:injectable/injectable.dart';
import '../api/auth_api_service.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<SignUpResponseModel> signUp(SignUpRequestModel request);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;

  const AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) =>
      _apiService.login(request);
  @override
  Future<SignUpResponseModel> signUp(SignUpRequestModel request) =>
      _apiService.signUp(request);
}
