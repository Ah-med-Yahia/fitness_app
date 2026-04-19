import 'package:equatable/equatable.dart';

class QueryRequest extends Equatable{
  final String queryKey;
  final String? queryValue;
  const QueryRequest({required this.queryKey,this.queryValue});
  Map<String, dynamic> toJson() {
    return {queryKey: queryValue,}
      ..removeWhere((key, value) => value == null);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];

}


class DynamicQueries extends Equatable {
  final List<QueryData> queriesData;

  const DynamicQueries({required this.queriesData});

  Map<String, dynamic> toJson() {
    // استخدام Entries بيخلي الكود أنظف وبيجمع البيانات في خطوة واحدة
    return {
      for (var item in queriesData)
        if (item.value != null) item.key: item.value
    };
  }

  @override
  // ضروري جداً علشان الـ UI يحس بالتغيير لو البيانات اتغيرت
  List<Object?> get props => [queriesData];
}

class QueryData extends Equatable {
  final String key;
  final dynamic value;

  const QueryData({required this.key, this.value});

  @override
  List<Object?> get props => [key, value];
}