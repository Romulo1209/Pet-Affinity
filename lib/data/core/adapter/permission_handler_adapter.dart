import 'package:permission_handler/permission_handler.dart' as ph;

class PermissionHandlerAdapter {
  Future<ph.PermissionStatus> check(ph.Permission p) => p.status;
  Future<ph.PermissionStatus> request(ph.Permission p) => p.request();
  Future<bool> openAppSettings() => ph.openAppSettings();
}
