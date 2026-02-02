import 'package:dartz/dartz.dart';
import 'package:travel_bagage_app/core/error/failures.dart';
import 'package:travel_bagage_app/domain/entities/user.dart';

/// Contrat abstrait pour les opérations d'authentification.
///
/// Cette interface définit CE QUE l'auth peut faire, pas COMMENT.
/// L'implémentation sera dans la couche data.
///
/// Utilise Either<Failure, T> pour gérer les erreurs de manière fonctionnelle :
/// - Left(Failure) = erreur
/// - Right(T) = succès
abstract class AuthRepository {
  /// Connexion avec email/mot de passe
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Inscription d'un nouvel utilisateur
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  });

  /// Connexion avec Google
  Future<Either<Failure, User>> signInWithGoogle();

  /// Connexion avec Apple (iOS)
  Future<Either<Failure, User>> signInWithApple();

  /// Envoi d'email de réinitialisation de mot de passe
  Future<Either<Failure, void>> forgotPassword(String email);

  /// Déconnexion
  Future<Either<Failure, void>> logout();

  /// Récupère l'utilisateur actuellement connecté (depuis le cache/token)
  Future<Either<Failure, User?>> getCurrentUser();

  /// Vérifie si un utilisateur est connecté
  Future<bool> isAuthenticated();
}
