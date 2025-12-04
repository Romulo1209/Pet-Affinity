import 'package:get_it/get_it.dart';
import 'package:pet_affinity/data/core/service/permission_service.dart';
import 'package:pet_affinity/data/core/repository/permission_repository.dart';
import 'package:pet_affinity/data/core/repository/permission_repository_impl.dart';
import 'package:pet_affinity/module/map/view_model/map_view_model.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDI() async {
  // DATA
  getIt.registerLazySingleton<PermissionRepository>(
    () => PermissionRepositoryImpl(),
  );

  // SERVICES
  getIt.registerLazySingleton<PermissionService>(
    () => PermissionService(getIt()),
  );

  // VIEW MODELS / STORES
  getIt.registerLazySingleton<MapViewModel>(() => MapViewModel());
}
