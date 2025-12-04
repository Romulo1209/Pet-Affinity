import 'package:pet_affinity/data/core/enum/app_permission.dart';
import 'package:pet_affinity/data/core/enum/permission_stats.dart';
import 'package:pet_affinity/data/core/repository/permission_repository.dart';

class PermissionService {
  final PermissionRepository _permissionRepository;

  PermissionService(this._permissionRepository);

  Future<PermissionStatus> requestPermission(AppPermission permission) async {
    return await _permissionRepository.requestPermission(permission);
  }

  Future<PermissionStatus> checkPermission(AppPermission permission) async {
    return await _permissionRepository.checkPermission(permission);
  }

  Future<bool> openAppSettings() async {
    return await _permissionRepository.openAppSettings();
  }
}
