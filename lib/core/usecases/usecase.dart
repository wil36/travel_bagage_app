import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_bagage_app/core/error/failures.dart';

/// Base class for all use cases
/// [T] is the return type
/// [Params] is the parameters class
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use this when the use case doesn't need parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
