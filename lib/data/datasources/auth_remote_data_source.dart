import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_bagage_app/core/error/exceptions.dart';
import 'package:travel_bagage_app/data/models/user_model.dart';

/// Interface pour les appels API d'authentification
abstract class AuthRemoteDataSource {
  /// POST /api/auth/login
  Future<(UserModel, String)> login({
    required String email,
    required String password,
  });

  /// POST /api/auth/register
  Future<(UserModel, String)> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  });

  /// Google OAuth
  Future<(UserModel, String)> signInWithGoogle();

  /// Apple OAuth
  Future<(UserModel, String)> signInWithApple();

  /// POST /api/auth/forgot-password
  Future<void> forgotPassword(String email);

  /// POST /api/auth/logout
  Future<void> logout(String token);

  /// GET /api/users/me
  Future<UserModel> getCurrentUser(String token);
}

/// Implémentation des appels API
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  // TODO: Déplacer vers AppConfig ou .env
  static const String baseUrl = 'https://api.bagli.app/api';

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<(UserModel, String)> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = UserModel.fromJson(data['user']);
      final token = data['token'] as String;
      return (user, token);
    } else if (response.statusCode == 401) {
      throw const InvalidCredentialsException();
    } else {
      throw ServerException(
        message: 'Erreur serveur',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<(UserModel, String)> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        if (phone != null) 'phone': phone,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final user = UserModel.fromJson(data['user']);
      final token = data['token'] as String;
      return (user, token);
    } else if (response.statusCode == 409) {
      throw const EmailAlreadyExistsException();
    } else if (response.statusCode == 400) {
      throw const WeakPasswordException();
    } else {
      throw ServerException(
        message: 'Erreur serveur',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<(UserModel, String)> signInWithGoogle() async {
    // TODO: Implémenter avec google_sign_in package
    // 1. Obtenir le token Google
    // 2. L'envoyer au backend pour validation
    throw UnimplementedError('Google Sign-In pas encore implémenté');
  }

  @override
  Future<(UserModel, String)> signInWithApple() async {
    // TODO: Implémenter avec sign_in_with_apple package
    throw UnimplementedError('Apple Sign-In pas encore implémenté');
  }

  @override
  Future<void> forgotPassword(String email) async {
    final response = await client.post(
      Uri.parse('$baseUrl/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 404) {
      throw const UserNotFoundException();
    } else {
      throw ServerException(
        message: 'Erreur serveur',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<void> logout(String token) async {
    await client.post(
      Uri.parse('$baseUrl/auth/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  @override
  Future<UserModel> getCurrentUser(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else if (response.statusCode == 401) {
      throw const AuthException(message: 'Session expirée');
    } else {
      throw ServerException(
        message: 'Erreur serveur',
        statusCode: response.statusCode,
      );
    }
  }
}
