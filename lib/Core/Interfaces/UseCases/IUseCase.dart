
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:waiter/Core/Helper/Failure.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<Failure, Type>> handler({Params params});
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
