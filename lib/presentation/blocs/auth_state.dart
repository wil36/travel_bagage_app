import 'package:equatable/equatable.dart';
import 'package:travel_bagage_app/domain/entities/user.dart';

/// États possibles de l'authentification
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// État initial - vérification en cours
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Chargement en cours (connexion, inscription, etc.)
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Utilisateur connecté
class AuthAuthenticated extends AuthState {
  final User user;
  final bool isNewUser; // true si vient de s'inscrire

  const AuthAuthenticated({
    required this.user,
    this.isNewUser = false,
  });

  @override
  List<Object?> get props => [user, isNewUser];
}

/// Utilisateur non connecté
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Erreur d'authentification
class AuthError extends AuthState {
  final String message;
  final String? code;

  const AuthError({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Email de réinitialisation envoyé avec succès
class AuthPasswordResetSent extends AuthState {
  final String email;

  const AuthPasswordResetSent({required this.email});

  @override
  List<Object> get props => [email];
}
