import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/core/service/remote/remote_data_source.dart';
import 'package:food_app/core/service/repository/app_repository.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/base/presentation/bloc/app_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {

    ///firestore
    sl.registerLazySingleton(() => FirebaseFirestore.instance);
   // sl.registerFactory(() =>  FirebaseFirestore.instance);
    /// Repository
    sl.registerLazySingleton<BaseAppRepository>(
            () => AppRepository(sl()));
    /// DATA SOURCE
    sl.registerLazySingleton<BaseRemoteDataSource>(
            () => RemoteDataSource(sl()));
    /// Bloc
    sl.registerFactory(() => AppBloc());
    sl.registerFactory(() => SearchBloc(sl()));
    sl.registerFactory(() => RestaurantsBloc(sl()));
    sl.registerFactory(() => RestaurantDetailsBloc());


  }
}