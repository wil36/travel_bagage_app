import 'package:dartz/dartz.dart';
import 'package:travel_bagage_app/core/error/exceptions.dart';
import 'package:travel_bagage_app/core/error/failures.dart';
import 'package:travel_bagage_app/core/network/network_info.dart';
import 'package:travel_bagage_app/data/datasources/auth_local_data_source.dart';
import 'package:travel_bagage_app/data/datasources/auth_remote_data_source.dart';
import 'package:travel_bagage_app/domain/entities/user.dart';
import 'package:travel_bagage_app/domain/irepositories/iauth_repository.dart';

/// Implémentation du repository d'authentification.
///
/// Combine :
/// - RemoteDataSource : appels API
/// - LocalDataSource : cache local (SharedPreferences)
/// - NetworkInfo : vérification de connexion
///
/// Gère la logique de cache et les erreurs réseau.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final (user, token) = await remoteDataSource.login(
          email: email,
          password: password,
        );
        await localDataSource.cacheUser(user);
        await localDataSource.cacheToken(token);
        return Right(user);
      } on InvalidCredentialsException {
        return const Left(InvalidCredentialsFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final (user, token) = await remoteDataSource.register(
          email: email,
          password: password,
          name: name,
          phone: phone,
        );
        await localDataSource.cacheUser(user);
        await localDataSource.cacheToken(token);
        return Right(user);
      } on EmailAlreadyExistsException {
        return const Left(EmailAlreadyExistsFailure());
      } on WeakPasswordException {
        return const Left(WeakPasswordFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    if (await networkInfo.isConnected) {
      try {
        final (user, token) = await remoteDataSource.signInWithGoogle();
        await localDataSource.cacheUser(user);
        await localDataSource.cacheToken(token);
        return Right(user);
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signInWithApple() async {
    if (await networkInfo.isConnected) {
      try {
        final (user, token) = await remoteDataSource.signInWithApple();
        await localDataSource.cacheUser(user);
        await localDataSource.cacheToken(token);
        return Right(user);
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.forgotPassword(email);
        return const Right(null);
      } on UserNotFoundException {
        return const Left(UserNotFoundFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final token = await localDataSource.getToken();
      if (token != null && await networkInfo.isConnected) {
        await remoteDataSource.logout(token);
      }
      await localDataSource.clearAuthData();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final cachedUser = await localDataSource.getCachedUser();
      return Right(cachedUser);
    } on CacheException {
      return const Right(null);
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return await localDataSource.hasAuthData();
  }
}
