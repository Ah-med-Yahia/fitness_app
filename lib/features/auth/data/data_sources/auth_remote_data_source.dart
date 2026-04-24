import '../../../../config/base_response/base_response.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<BaseResponse<LoginResponseModel>> login(LoginRequestModel request);
}
