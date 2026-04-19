import 'package:json_annotation/json_annotation.dart';

import '../../../domain/models/meals_entity.dart';

part 'meals_response.g.dart';

@JsonSerializable()
class MealsResponse {
  @JsonKey(name: "meals")
  final List<Meals>? meals;

  MealsResponse ({
    this.meals,
  });

  factory MealsResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsResponseToJson(this);
  }
  MealsEntity toEntity
  () {
    return MealsEntity(
      meals: meals?.map((e) => e.toEntity()).toList(),
    );
  }
}


@JsonSerializable()
class Meals {
  @JsonKey(name: "strMeal")
  final String? strMeal;
  @JsonKey(name: "strMealThumb")
  final String? strMealThumb;
  @JsonKey(name: "idMeal")
  final String? idMeal;

  Meals ({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });
Meal toEntity() {
  return Meal(
    strMeal: strMeal,
    strMealThumb: strMealThumb,
    idMeal: idMeal,
  );
}
  factory Meals.fromJson(Map<String, dynamic> json) {
    return _$MealsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsToJson(this);
  }
}


