import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:travel_bagage_app/core/network/network_info.dart';

// Data
import 'package:travel_bagage_app/data/datasources/auth_remote_data_source.dart';
import 'package:travel_bagage_app/data/datasources/auth_local_data_source.dart';
import 'package:travel_bagage_app/data/repositories/auth_repository_impl.dart';

// Domain
import 'package:travel_bagage_app/domain/irepositories/iauth_repository.dart';
import 'package:travel_bagage_app/domain/usecases/login.dart';
import 'package:travel_bagage_app/domain/usecases/register.dart';
import 'package:travel_bagage_app/domain/usecases/logout.dart';
import 'package:travel_bagage_app/domain/usecases/forgot_password.dart';
import 'package:travel_bagage_app/domain/usecases/get_current_user.dart';
import 'package:travel_bagage_app/domain/usecases/sign_in_with_google.dart';

// Presentation
import 'package:travel_bagage_app/presentation/blocs/auth_bloc.dart';

/// Instance globale du service locator
final sl = GetIt.instance;

/// Initialise toutes les dépendances de l'application.
/// Doit être appelé au démarrage de l'app (dans main()).
Future<void> init() async {
  //! Presentation - Blocs
  // ---------------------

  // Bloc (factory = nouvelle instance à chaque fois)
  sl.registerFactory(
    () => AuthBloc(
      login: sl(),
      register: sl(),
      logout: sl(),
      forgotPassword: sl(),
      getCurrentUser: sl(),
      signInWithGoogle: sl(),
    ),
  );

  //! Domain - Use Cases
  // -------------------
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));

  //! Domain - Repositories
  // ----------------------
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! Data - Data Sources
  // --------------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  // -----
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //! External (packages externes)
  // -----------------------------
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}
