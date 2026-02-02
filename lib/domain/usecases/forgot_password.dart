import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_bagage_app/core/error/failures.dart';
import 'package:travel_bagage_app/core/usecases/usecase.dart';
import 'package:travel_bagage_app/domain/irepositories/iauth_repository.dart';

/// Use case pour envoyer un email de réinitialisation de mot de passe
class ForgotPassword implements UseCase<void, ForgotPasswordParams> {
  final AuthRepository repository;

  ForgotPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) async {
    return await repository.forgotPassword(params.email);
  }
}

/// Paramètres pour la réinitialisation de mot de passe
class ForgotPasswordParams extends Equatable {
  final String email;

  const ForgotPasswordParams({required this.email});

  @override
  List<Object> get props => [email];
}
