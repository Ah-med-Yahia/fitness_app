import '../../../../core/request/query_request.dart';

sealed class MealIntent {}
class GetMealDetailsIntent extends MealIntent{
  final DynamicQueries query;
   GetMealDetailsIntent(this.query);
}
