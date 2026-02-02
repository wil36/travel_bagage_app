import 'package:dartz/dartz.dart';
import 'package:travel_bagage_app/core/error/failures.dart';
import 'package:travel_bagage_app/core/usecases/usecase.dart';
import 'package:travel_bagage_app/domain/entities/user.dart';
import 'package:travel_bagage_app/domain/irepositories/iauth_repository.dart';

/// Use case pour récupérer l'utilisateur actuellement connecté
/// Retourne null si aucun utilisateur n'est connecté
class GetCurrentUser implements UseCase<User?, NoParams> {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
