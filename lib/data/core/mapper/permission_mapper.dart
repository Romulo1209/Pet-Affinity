import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:pet_affinity/data/core/enum/app_permission.dart';
import 'package:pet_affinity/data/core/enum/permission_stats.dart';

class PermissionMapper {
  ph.Permission toExternal(AppPermission p) {
    switch (p) {
      case AppPermission.camera:
        return ph.Permission.camera;
      case AppPermission.photos:
        return ph.Permission.photos;
      case AppPermission.location:
        return ph.Permission.location;
      case AppPermission.notifications:
        return ph.Permission.notification;
      case AppPermission.storage:
        return ph.Permission.storage;
      case AppPermission.bluetooth:
        return ph.Permission.bluetooth;
      case AppPermission.locationAlways:
        return ph.Permission.locationAlways;
      case AppPermission.locationWhenInUse:
        return ph.Permission.locationWhenInUse;
      case AppPermission.internet:
        return ph.Permission.ignoreBatteryOptimizations;
      case AppPermission.mediaImages:
        return ph.Permission.mediaLibrary;
      case AppPermission.mediaVideo:
        return ph.Permission.videos;
      case AppPermission.bluetoothScan:
        return ph.Permission.bluetoothScan;
      case AppPermission.bluetoothConnect:
        return ph.Permission.bluetoothConnect;
    }
  }

  PermissionStatus toDomain(ph.PermissionStatus s) {
    switch (s) {
      case ph.PermissionStatus.granted:
        return PermissionStatus.granted;
      case ph.PermissionStatus.denied:
        return PermissionStatus.denied;
      case ph.PermissionStatus.permanentlyDenied:
        return PermissionStatus.permanentlyDenied;
      case ph.PermissionStatus.restricted:
        return PermissionStatus.restricted;
      case ph.PermissionStatus.limited:
        return PermissionStatus.limited;
      case ph.PermissionStatus.provisional:
        return PermissionStatus.provisional;
    }
  }
}
