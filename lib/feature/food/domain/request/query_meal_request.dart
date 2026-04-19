import 'package:equatable/equatable.dart';

class QueryMealRequest extends Equatable {
  final String? category;


  const QueryMealRequest({this.category});

  Map<String, dynamic> toJson() {
    return {'c': category,}
      ..removeWhere((key, value) => value == null);
  }

  @override
  List<Object?> get props => [];
}
