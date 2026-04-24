class MealsEntity {
  final List<Meal>? meals;

  MealsEntity({this.meals});
}

class Meal {
  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;
  Meal({this.strMeal, this.strMealThumb, this.idMeal});
}
