import 'package:equatable/equatable.dart';
import 'package:fitness_app/config/errors/app_exception.dart';

class BaseState<T> extends Equatable {
  final bool isEmpty;
  final bool isError;
  final bool isLoading;
  final T? data;
  final AppException? error;

  const BaseState({
    this.isEmpty = false,
    this.isError = false,
    this.isLoading = false,
    this.data,
    this.error,
  });

  BaseState<T> copyWith({
    bool? isError,
    bool? isLoading,
    T? data,
    AppException? error,
  }) {
    return BaseState<T>(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isEmpty, isError, isLoading, data];
}
