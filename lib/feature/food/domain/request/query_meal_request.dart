import 'package:equatable/equatable.dart';

class QueryMealRequest extends Equatable {
  final String? category;
  // final String? occasion;
  // final Sort? sort;

  const QueryMealRequest({this.category});

  Map<String, dynamic> toJson() {
    return {'c': category,}
      ..removeWhere((key, value) => value == null);
  }

  @override
  List<Object?> get props => [];
}
// enum Sort {
//   priceAsc('price'),
//   priceDesc('-price'),
//   newSort('new'),
//   old('old'),
//   discount('discount');
//   final String value;
//
//   const Sort(this.value,);
// }