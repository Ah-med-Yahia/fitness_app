import 'package:dio/dio.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/config/errors/exceptions_handler.dart';
import '../../../../config/errors/app_exception.dart';
import '../../../../config/services/tokens/token_service_storage_contract.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenServiceStorageContract _tokenService;
  const AuthRepositoryImpl(this._remoteDataSource, this._tokenService);
  @override
  Future<BaseResponse<String>> login({
    required String email,
    required String password,
  }) async {

      final response = await _remoteDataSource.login(
        LoginRequestModel(email: email, password: password),
      );
      return response.when(success: (LoginResponseModel data) {
        _tokenService.saveToken(token: data.token ?? '');
        return Success(data.message??'');

      },
          failure: (AppException exception) {
        return Failure(exception);
          }

      );


  }
}
