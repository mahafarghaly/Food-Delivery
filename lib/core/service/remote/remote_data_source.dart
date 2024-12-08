import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/home/data/model/restaurant.dart';
import '../service_locator.dart';
abstract class BaseRemoteDataSource{
  Future<List<T>> fetchData<T>(String collectionName, T Function(Map<String, dynamic>) fromMap);
}
class RemoteDataSource extends BaseRemoteDataSource{
  final FirebaseFirestore firestore;

  RemoteDataSource(this.firestore);
  //final _firestore =sl<FirebaseFirestore>();
  @override
  Future<List<T>> fetchData<T>(String collectionName, T Function(Map<String, dynamic>) fromMap) async {
    try {
      final snapshot = await firestore.collection(collectionName).get();
      for (var doc in snapshot.docs) {
        print('Raw Data: ${doc.data()}');
      }
      return snapshot.docs.map((doc) => fromMap(doc.data())).toList();
    } catch (e) {
      print('Error fetching data from $collectionName: $e');
      throw Exception('Failed to fetch data from $collectionName: $e');
    }
  }
}
