import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserModel {
    @JsonKey(name: 'firstName')
    final String firstName;
    @JsonKey(name: 'lastName')
    final String lastName;
    @JsonKey(name: 'email')
    final String email;
    @JsonKey(name: 'gender')
    final String gender;
    @JsonKey(name: 'age')
    final int age;
    @JsonKey(name: 'weight')
    final int weight;
    @JsonKey(name: 'height')
    final int height;
    @JsonKey(name: 'activityLevel')
    final String activityLevel;
    @JsonKey(name: 'goal')
    final String goal;
    @JsonKey(name: 'photo')
    final String photo;
    @JsonKey(name: '_id')
    final String id;
    @JsonKey(name: 'createdAt')
    final DateTime createdAt;

    UserModel({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.gender,
        required this.age,
        required this.weight,
        required this.height,
        required this.activityLevel,
        required this.goal,
        required this.photo,
        required this.id,
        required this.createdAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

    Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
