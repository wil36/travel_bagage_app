import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_bagage_app/core/error/exceptions.dart';
import 'package:travel_bagage_app/data/models/user_model.dart';

/// Interface pour le stockage local d'authentification
abstract class AuthLocalDataSource {
  /// Récupère l'utilisateur en cache
  Future<UserModel> getCachedUser();

  /// Sauvegarde l'utilisateur en cache
  Future<void> cacheUser(UserModel user);

  /// Récupère le token d'authentification
  Future<String?> getToken();

  /// Sauvegarde le token d'authentification
  Future<void> cacheToken(String token);

  /// Supprime toutes les données d'auth (logout)
  Future<void> clearAuthData();

  /// Vérifie si l'utilisateur est connecté
  Future<bool> hasAuthData();
}

const String _cachedUserKey = 'CACHED_USER';
const String _cachedTokenKey = 'CACHED_TOKEN';

/// Implémentation avec SharedPreferences
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getCachedUser() async {
    final jsonString = sharedPreferences.getString(_cachedUserKey);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    } else {
      throw const CacheException(message: 'Aucun utilisateur en cache');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(
      _cachedUserKey,
      jsonEncode(user.toJson()),
    );
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_cachedTokenKey);
  }

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString(_cachedTokenKey, token);
  }

  @override
  Future<void> clearAuthData() async {
    await sharedPreferences.remove(_cachedUserKey);
    await sharedPreferences.remove(_cachedTokenKey);
  }

  @override
  Future<bool> hasAuthData() async {
    return sharedPreferences.containsKey(_cachedTokenKey);
  }
}
