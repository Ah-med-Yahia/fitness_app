import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:fitness_app/features/auth/forget_password/data/models/response/verify_code_response_model.dart';

abstract interface class ForgetPasswordDataSource {
  Future<BaseResponse<ForgetPasswordResponseModel>> forgetPassword(
    ForgetPasswordRequestModel request,
  );

  Future<BaseResponse<VerifyCodeResponseModel>> verifyCode(
    VerifyCodeRequestModel request,
  );

  Future<BaseResponse<ResetPasswordResponseModel>> resetPassword(
    ResetPasswordRequestModel request,
  );
}
