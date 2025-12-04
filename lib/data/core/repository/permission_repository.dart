import 'package:pet_affinity/data/core/enum/app_permission.dart';
import 'package:pet_affinity/data/core/enum/permission_stats.dart';

abstract class PermissionRepository {
  Future<PermissionStatus> requestPermission(AppPermission permission);
  Future<PermissionStatus> checkPermission(AppPermission permission);
  Future<bool> openAppSettings();
}
