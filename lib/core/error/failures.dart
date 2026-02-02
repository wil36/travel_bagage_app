import 'package:equatable/equatable.dart';

/// Base class for all failures (used in Either Left)
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Server failures
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Une erreur serveur est survenue',
    super.code,
  });
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
      : super(message: 'Email ou mot de passe incorrect', code: 'INVALID_CREDENTIALS');
}

class EmailAlreadyExistsFailure extends AuthFailure {
  const EmailAlreadyExistsFailure()
      : super(message: 'Cet email est déjà utilisé', code: 'EMAIL_EXISTS');
}

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure()
      : super(message: 'Le mot de passe est trop faible', code: 'WEAK_PASSWORD');
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure()
      : super(message: 'Utilisateur non trouvé', code: 'USER_NOT_FOUND');
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super(message: 'Pas de connexion internet', code: 'NO_NETWORK');
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Erreur de cache', super.code});
}
