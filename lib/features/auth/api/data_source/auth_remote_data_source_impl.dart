import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/config/network/safe_api_call.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/auth_remote_data_source.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../client/auth_api_service.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _apiService;

  const AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponse<LoginResponseModel>> login(LoginRequestModel request) =>
      safeApiCall(() => _apiService.login(request));
}
