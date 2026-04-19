import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:fitness_app/app/config/errors/exceptions_handler.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<LoginEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        LoginRequestModel(email: email, password: password),
      );
      return LoginEntity(token: response.token ?? '');
    } on DioException catch (e) {
      throw ExceptionsHandler.handle(e);
    } catch (e) {
      throw ExceptionsHandler.handle(e);
    }
  }
}
