import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/food_entity.dart';

part 'meals_category_response.g.dart';

@JsonSerializable()
class MealsCategoryResponse {
  @JsonKey(name: "categories")
  final List<Categories>? categories;

  MealsCategoryResponse ({
    this.categories,
  });

  factory MealsCategoryResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsCategoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MealsCategoryResponseToJson(this);
  }
  FoodCategoriesEntity toFoodCategoriesEntity() {
    return FoodCategoriesEntity(
      categoriesEntity: categories?.map((e) => e.toFoodCategoryEntity()).toList(),
    );
  }
}

@JsonSerializable()
class Categories {
  @JsonKey(name: "idCategory")
  final String? idCategory;
  @JsonKey(name: "strCategory")
  final String? strCategory;
  @JsonKey(name: "strCategoryThumb")
  final String? strCategoryThumb;
  @JsonKey(name: "strCategoryDescription")
  final String? strCategoryDescription;

  Categories ({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return _$CategoriesFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesToJson(this);
  }
  FoodCategoryEntity toFoodCategoryEntity() {
    return FoodCategoryEntity(
      id: idCategory,
      title: strCategory,
    );
  }
}


