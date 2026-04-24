import 'package:fitness_app/core/shared/data/models/user_model.dart';
import 'package:fitness_app/core/shared/domain/user_entity.dart';

extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      photo: photo,
      id: id,
    );
  }
}
