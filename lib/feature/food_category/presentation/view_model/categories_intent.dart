import 'package:fitness_app/core/request/query_request.dart';

sealed class CategoriesIntent {
  final DynamicQueries query;
  CategoriesIntent(this.query);
}

class CategoriesAction extends CategoriesIntent {
  CategoriesAction(super.query);
}

class GetCategoryIntent extends CategoriesIntent {
  final int index;

  GetCategoryIntent(super.query, {required this.index});
}

class GetProductsCategoryIntent extends CategoriesIntent {
  GetProductsCategoryIntent(super.query);
}
