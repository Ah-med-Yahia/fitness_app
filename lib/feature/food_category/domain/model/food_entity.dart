import 'package:equatable/equatable.dart';

class FoodCategoriesEntity extends Equatable {
  final List<FoodCategoryEntity>? categoriesEntity;

  const FoodCategoriesEntity({this.categoriesEntity});

  @override
  List<Object?> get props => [categoriesEntity];
}

class FoodCategoryEntity extends Equatable {
  final String? id;
  final String? title;

  const FoodCategoryEntity({this.id, this.title});

  @override
  List<Object?> get props => [id, title];
}
