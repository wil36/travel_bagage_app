import 'package:equatable/equatable.dart';

/// Événements envoyés au AuthBloc
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Vérifie si l'utilisateur est déjà connecté (au démarrage de l'app)
class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

/// Connexion avec email/mot de passe
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

/// Inscription d'un nouvel utilisateur
class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String? phone;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, name, phone];
}

/// Connexion avec Google
class AuthGoogleSignInRequested extends AuthEvent {
  const AuthGoogleSignInRequested();
}

/// Connexion avec Apple
class AuthAppleSignInRequested extends AuthEvent {
  const AuthAppleSignInRequested();
}

/// Demande de réinitialisation de mot de passe
class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

/// Déconnexion
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
