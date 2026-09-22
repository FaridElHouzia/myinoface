import 'package:myinoface/features/all_classes/data/database/classes_local_data_source.dart';
import 'package:myinoface/features/all_classes/data/database/classes_remote_data_source.dart';
import 'package:myinoface/features/all_classes/data/repositories/classes_repository_impl.dart';
import 'package:myinoface/features/all_classes/domain/repositories/classes_repository.dart';
import 'package:myinoface/features/all_classes/domain/usecases/get_classes.dart';
import 'package:myinoface/features/all_classes/presentation/bloc/classes_bloc.dart';
import 'package:myinoface/features/demande_recuperation/data/repositories/demande_recuperation_repository_impl.dart';
import 'package:myinoface/features/demande_recuperation/data/database/demande_recuperation_remote_data_source.dart';
import 'package:myinoface/features/demande_recuperation/data/database/demande_recuperation_local_data_source.dart';
import 'package:myinoface/features/demande_recuperation/domain/repositories/demande_recuperation_repository.dart';
import 'package:myinoface/features/demande_recuperation/presentation/bloc/demande_recuperation_bloc.dart';
import 'package:myinoface/features/demande_recuperation/domain/usecases/get_demande_recuperation.dart';
import 'package:myinoface/features/gardes/data/database/personne_garde_local_data_source.dart';
import 'package:myinoface/features/gardes/data/database/personne_garde_remote_data_source.dart';
import 'package:myinoface/features/gardes/data/repositories/classes_repository_impl.dart';
import 'package:myinoface/features/gardes/domain/repositories/personne_garde_repository.dart';
import 'package:myinoface/features/gardes/domain/usecases/get_classes.dart';
import 'package:myinoface/features/gardes/presentation/bloc/garde_bloc.dart';
import 'package:myinoface/features/login/domain/usecases/get_login_with_email_and_pass.dart';
import 'package:myinoface/features/login/data/repositories/login_repository_impl.dart';
import 'package:myinoface/features/login/data/database/login_remote_data_source.dart';
import 'package:myinoface/features/login/data/database/login_local_data_source.dart';
import 'package:myinoface/features/login/domain/usecases/get_login_with_qrcode.dart';
import 'package:myinoface/features/login/domain/repositories/login_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:myinoface/features/login/presentation/bloc/login_bloc.dart';
import 'package:myinoface/core/usecases/preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myinoface/core/database/app_database.dart';
import 'package:myinoface/core/util/app_utils_impl.dart';
import 'package:myinoface/core/usecases/constants.dart';
import 'package:myinoface/core/util/app_utils.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import '../../features/forgot_pass/data/database/forgot_pass_remote_data_source.dart';
import '../../features/forgot_pass/data/repositories/forgot_pass_repository_impl.dart';
import '../../features/forgot_pass/domain/repositories/forgot_pass_repository.dart';
import '../../features/forgot_pass/domain/usecases/get_forgot_pass.dart';
import '../../features/forgot_pass/presentation/bloc/forgot_pass_bloc.dart';


final GetIt sl = GetIt.instance;

Future<void> setup() async {
  try {
    await init();
    await initUtilsImpl();
    await initLogin();
    await initDemandeRecuperation();
    await initAllClasses();
    await initPersonneGarde();
    await initForgotPassPage();
  } catch(e) {
    logger.e('error, setup: $e');
  }
}

///!  init
Future<void> init() async {
  //! Firebase
  try {
    //! Network
    // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    //! External
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //! TODO: By Mazen
    sl.registerLazySingleton(() => InternetConnectionChecker.instance);
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());

    //! Database
    final db = AppDatabase.instance;
    sl.registerLazySingleton(() => db);

    //! Preference
    PreferenceUtils instance = await PreferenceUtils.init();
    sl.registerSingleton<PreferenceUtils>(instance);

  } catch(e) {
    logger.e('error, init: $e');
  }
}

///!  initUtilsImpl
Future<void> initUtilsImpl() async {
  // sl.registerLazySingleton<AppUtils>(() => AppUtilsImpl(preferences: sl()));
  sl.registerSingleton<AppUtils>(AppUtilsImpl(preferences: sl(),
      client: sl(), database: sl()), signalsReady: true);
}

///! Login
Future<void> initLogin() async {

  //! Bloc
  sl.registerFactory(() => LoginBloc(
    getLoginWithEmailAndPass: sl(),
    getLoginWithQrcode: sl()
  ));

  //! Use cases
  sl.registerLazySingleton(() => GetLoginWithEmailAndPass(repository: sl()));
  sl.registerLazySingleton(() => GetLoginWithQrcode(repository: sl()));

  //! Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
    ),
  );

  //! Remote Data
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(
        // client: sl(),
        preferences: sl(),
        localDataSource: sl(),
      ),
  );

  //! Data sources
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(preferences: sl(), db: sl()),
  );
}

///! DemandeRecuperation
Future<void> initDemandeRecuperation() async {

  //! Bloc
  sl.registerFactory(() => DemandeRecuperationBloc(getDemande: sl()));

  //! Use cases
  sl.registerLazySingleton(() => GetDemandeRecuperation(repository: sl()));

  //! Repository
  sl.registerLazySingleton<DemandeRecuperationRepository>(
      () => DemandeRecuperationRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
    ),
  );

  //! Remote Data
  sl.registerLazySingleton<DemandeRecuperationRemoteDataSource>(
      () => DemandeRecuperationRemoteDataSourceImpl(
        client: sl(),
        preferences: sl(),
        localDataSource: sl(),
      ),
  );

  //! Data sources
  sl.registerLazySingleton<DemandeRecuperationLocalDataSource>(
      () => DemandeRecuperationLocalDataSourceImpl(preferences: sl(), db: sl()),
  );
}

///! All Classes
Future<void> initAllClasses() async {

  //! Bloc
  sl.registerFactory(() => ClassesBloc(getClasses: sl()));

  //! Use cases
  sl.registerLazySingleton(() => GetClasses(repository: sl()));

  //! Repository
  sl.registerLazySingleton<ClassesRepository>(
        () => ClassesRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  //! Remote Data
  sl.registerLazySingleton<ClassesRemoteDataSource>(
        () => ClassesRemoteDataSourceImpl(
      client: sl(),
      preferences: sl(),
      localDataSource: sl(),
    ),
  );

  //! Data sources
  sl.registerLazySingleton<ClassesLocalDataSource>(
        () => ClassesLocalDataSourceImpl(preferences: sl(), db: sl()),
  );
}

///! Personne Gardes
Future<void> initPersonneGarde() async {

  //! Bloc
  sl.registerFactory(() => GardeBloc(getPersonne: sl()));

  //! Use cases
  sl.registerLazySingleton(() => GetPersonneGarde(repository: sl()));

  //! Repository
  sl.registerLazySingleton<PersonneGardeRepository>(
        () => PersonneGardeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  //! Remote Data
  sl.registerLazySingleton<PersonneGardeRemoteDataSource>(
        () => PersonneGardeRemoteDataSourceImpl(
      client: sl(),
      preferences: sl(),
      localDataSource: sl(),
    ),
  );

  //! Data sources
  sl.registerLazySingleton<PersonneGardeLocalDataSource>(
        () => PersonneGardeLocalDataSourceImpl(preferences: sl(), db: sl()),
  );
}


///! ForgotPass
Future<void> initForgotPassPage() async {

  //! Bloc
  sl.registerFactory(() => ForgotPassBloc(getForgotPass: sl()));

  //! Use cases
  sl.registerLazySingleton(() => GetForgotPass(repository: sl()));

  //! Repository
  sl.registerLazySingleton<ForgotPassRepository>(
        () => ForgotPassRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  //! Remote Data
  sl.registerLazySingleton<ForgotPassRemoteDataSource>(
        () => ForgotPassRemoteDataSourceImpl(
      client: sl(),
      preferences: sl(),
    ),
  );
}