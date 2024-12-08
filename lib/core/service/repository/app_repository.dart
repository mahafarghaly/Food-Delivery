import 'package:food_app/core/service/remote/remote_data_source.dart';

import '../../../features/home/data/model/restaurant.dart';

abstract class BaseAppRepository{
  Future<List<Restaurant>> getRestaurants();
}
class AppRepository extends BaseAppRepository{
  final BaseRemoteDataSource remoteDataSource;
  AppRepository(this.remoteDataSource);
  @override
  Future<List<Restaurant>> getRestaurants() async {
    return await remoteDataSource.fetchData(
      'restaurant',
          (data) => Restaurant.fromFirestore(data),
    );
  }
}