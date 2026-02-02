import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_bagage_app/core/error/failures.dart';
import 'package:travel_bagage_app/core/usecases/usecase.dart';
import 'package:travel_bagage_app/domain/entities/user.dart';
import 'package:travel_bagage_app/domain/irepositories/iauth_repository.dart';

/// Use case pour la connexion avec email/mot de passe.
///
/// Exemple d'utilisation :
/// ```dart
/// final result = await login(LoginParams(email: 'test@test.com', password: '123456'));
/// result.fold(
///   (failure) => print('Erreur: ${failure.message}'),
///   (user) => print('Connecté: ${user.name}'),
/// );
/// ```
class Login implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

/// Paramètres requis pour la connexion
class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
