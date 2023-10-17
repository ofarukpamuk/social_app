import 'package:get_it/get_it.dart';
import 'package:kursgirissayfasifirebase/services/firebase_auth_service.dart';
import 'package:kursgirissayfasifirebase/services/firebase_storage_Service.dart';
import 'package:kursgirissayfasifirebase/services/firestore_db_service.dart';

import 'app/data/repository/user_repository.dart';
import 'services/fake_auth_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Dependency Injection yapısını burada oluşturabilirsiniz
  GetIt.instance.registerLazySingleton(() => FirebaseAuthService());
  GetIt.instance.registerLazySingleton(() => FakeAuthService());
  GetIt.instance.registerLazySingleton(() => FireStoreDbService());
  GetIt.instance.registerLazySingleton(() => FirebaseStorageService());
  GetIt.instance.registerLazySingleton(() => UserRepository());
}
