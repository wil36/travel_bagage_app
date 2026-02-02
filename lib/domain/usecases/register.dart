import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_bagage_app/core/error/failures.dart';
import 'package:travel_bagage_app/core/usecases/usecase.dart';
import 'package:travel_bagage_app/domain/entities/user.dart';
import 'package:travel_bagage_app/domain/irepositories/iauth_repository.dart';

/// Use case pour l'inscription d'un nouvel utilisateur
class Register implements UseCase<User, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
      phone: params.phone,
    );
  }
}

/// Paramètres requis pour l'inscription
class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final String? phone;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, name, phone];
}
