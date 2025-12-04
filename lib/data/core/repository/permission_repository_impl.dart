import 'package:pet_affinity/data/core/adapter/permission_handler_adapter.dart';
import 'package:pet_affinity/data/core/enum/app_permission.dart';
import 'package:pet_affinity/data/core/enum/permission_stats.dart';
import 'package:pet_affinity/data/core/mapper/permission_mapper.dart';
import 'package:pet_affinity/data/core/repository/permission_repository.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  @override
  Future<PermissionStatus> requestPermission(AppPermission permission) async {
    return PermissionMapper().toDomain(
      await PermissionHandlerAdapter().request(
        PermissionMapper().toExternal(permission),
      ),
    );
  }

  @override
  Future<PermissionStatus> checkPermission(AppPermission permission) async {
    return PermissionMapper().toDomain(
      await PermissionHandlerAdapter().check(
        PermissionMapper().toExternal(permission),
      ),
    );
  }

  @override
  Future<bool> openAppSettings() async {
    return await PermissionHandlerAdapter().openAppSettings();
  }
}
