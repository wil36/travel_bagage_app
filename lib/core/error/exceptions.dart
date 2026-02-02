/// Base class for all exceptions
class AppException implements Exception {
  final String message;
  final String? code;

  const AppException({required this.message, this.code});
}

/// Server-related exceptions (HTTP errors)
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    super.code,
    this.statusCode,
  });
}

/// Authentication-specific exceptions
class AuthException extends AppException {
  const AuthException({required super.message, super.code});
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException()
      : super(message: 'Email ou mot de passe incorrect', code: 'INVALID_CREDENTIALS');
}

class EmailAlreadyExistsException extends AuthException {
  const EmailAlreadyExistsException()
      : super(message: 'Cet email est déjà utilisé', code: 'EMAIL_EXISTS');
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException()
      : super(message: 'Le mot de passe est trop faible', code: 'WEAK_PASSWORD');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException()
      : super(message: 'Utilisateur non trouvé', code: 'USER_NOT_FOUND');
}

class NetworkException extends AppException {
  const NetworkException()
      : super(message: 'Pas de connexion internet', code: 'NO_NETWORK');
}

class CacheException extends AppException {
  const CacheException({super.message = 'Erreur de cache', super.code});
}
