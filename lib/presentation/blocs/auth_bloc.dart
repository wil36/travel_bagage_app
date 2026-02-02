import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_bagage_app/core/usecases/usecase.dart';
import 'package:travel_bagage_app/domain/usecases/forgot_password.dart';
import 'package:travel_bagage_app/domain/usecases/get_current_user.dart';
import 'package:travel_bagage_app/domain/usecases/login.dart';
import 'package:travel_bagage_app/domain/usecases/logout.dart';
import 'package:travel_bagage_app/domain/usecases/register.dart';
import 'package:travel_bagage_app/domain/usecases/sign_in_with_google.dart';

import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC gérant l'authentification.
///
/// Reçoit des AuthEvent et émet des AuthState.
/// Utilise les use cases pour exécuter la logique métier.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final Logout logout;
  final ForgotPassword forgotPassword;
  final GetCurrentUser getCurrentUser;
  final SignInWithGoogle signInWithGoogle;

  AuthBloc({
    required this.login,
    required this.register,
    required this.logout,
    required this.forgotPassword,
    required this.getCurrentUser,
    required this.signInWithGoogle,
  }) : super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthForgotPasswordRequested>(_onForgotPasswordRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  /// Vérifie si l'utilisateur est déjà connecté
  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await getCurrentUser(const NoParams());

    result.fold(
      (failure) => emit(const AuthUnauthenticated()),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  /// Connexion avec email/mot de passe
  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await login(LoginParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  /// Inscription
  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await register(RegisterParams(
      email: event.email,
      password: event.password,
      name: event.name,
      phone: event.phone,
    ));

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (user) => emit(AuthAuthenticated(user: user, isNewUser: true)),
    );
  }

  /// Connexion Google
  Future<void> _onGoogleSignInRequested(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await signInWithGoogle(const NoParams());

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  /// Mot de passe oublié
  Future<void> _onForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await forgotPassword(ForgotPasswordParams(email: event.email));

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (_) => emit(AuthPasswordResetSent(email: event.email)),
    );
  }

  /// Déconnexion
  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await logout(const NoParams());

    result.fold(
      (failure) => emit(AuthError(message: failure.message, code: failure.code)),
      (_) => emit(const AuthUnauthenticated()),
    );
  }
}
