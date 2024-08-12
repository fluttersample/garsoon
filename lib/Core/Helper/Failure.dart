
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final DioException? error;
  const Failure({this.message,this.error});
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.message,super.error});

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  List<Object?> get props => [];
}
class CancelTokenFailure extends Failure {
  const CancelTokenFailure({super.message});

  @override
  List<Object?> get props => [];
}

