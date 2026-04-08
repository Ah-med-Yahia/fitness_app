import 'package:dio/dio.dart';
import 'package:fitness_app/app/features/auth/data/models/signup_request_model.dart';
import 'package:fitness_app/app/features/auth/domain/entities/signup_entity.dart';
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

  @override
  Future<SignUpEntity> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required int height,
    required int weight,
    required int age,
    required String goal,
    required String activityLevel,
  }) async {
    try {
      final response = await _remoteDataSource.signUp(
        SignUpRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          gender: gender,
          height: height,
          weight: weight,
          age: age,
          goal: goal,
          activityLevel: activityLevel,
        ),
      );
      return SignUpEntity(token: response.token ?? '');
    } on DioException catch (e) {
      throw ExceptionsHandler.handle(e);
    } catch (e) {
      throw ExceptionsHandler.handle(e);
    }
  }
}
