import 'package:flutter/material.dart';
import 'package:pet_affinity/data/core/di/service_locator.dart';
import 'package:pet_affinity/data/core/enum/app_permission.dart';
import 'package:pet_affinity/data/core/enum/permission_stats.dart';
import 'package:pet_affinity/data/core/service/permission_service.dart';

class PermissionState {
  final AppPermission permission;
  final PermissionStatus status;
  final String title;
  final String description;
  final IconData icon;

  PermissionState({
    required this.permission,
    required this.status,
    required this.title,
    required this.description,
    required this.icon,
  });

  PermissionState copyWith({
    AppPermission? permission,
    PermissionStatus? status,
    String? title,
    String? description,
    IconData? icon,
  }) {
    return PermissionState(
      permission: permission ?? this.permission,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }
}

class SettingsViewModel extends ChangeNotifier {
  final PermissionService _permissionService = getIt<PermissionService>();

  List<PermissionState> _permissions = [];
  bool _isLoading = false;

  List<PermissionState> get permissions => _permissions;
  bool get isLoading => _isLoading;

  SettingsViewModel() {
    _initPermissions();
  }

  Future<void> _initPermissions() async {
    _setLoading(true);

    _permissions = [
      PermissionState(
        permission: AppPermission.locationWhenInUse,
        status: PermissionStatus.denied,
        title: 'Location (When Using App)',
        description:
            'Allow access to your location to find nearby pets and services',
        icon: Icons.location_on,
      ),
      PermissionState(
        permission: AppPermission.locationAlways,
        status: PermissionStatus.denied,
        title: 'Background Location',
        description:
            'Allow access to your location even when the app is closed',
        icon: Icons.location_searching,
      ),

      PermissionState(
        permission: AppPermission.camera,
        status: PermissionStatus.denied,
        title: 'Camera',
        description: 'Allow access to your camera for taking photos of pets',
        icon: Icons.camera_alt,
      ),

      PermissionState(
        permission: AppPermission.storage,
        status: PermissionStatus.denied,
        title: 'Storage Access',
        description:
            'Allow access to your device storage for saving pet photos',
        icon: Icons.sd_storage,
      ),
      PermissionState(
        permission: AppPermission.mediaImages,
        status: PermissionStatus.denied,
        title: 'Photo Library',
        description: 'Allow access to your photo library to upload pet images',
        icon: Icons.photo_library,
      ),
      PermissionState(
        permission: AppPermission.mediaVideo,
        status: PermissionStatus.denied,
        title: 'Video Library',
        description: 'Allow access to your videos to upload pet videos',
        icon: Icons.video_library,
      ),

      PermissionState(
        permission: AppPermission.notifications,
        status: PermissionStatus.denied,
        title: 'Notifications',
        description: 'Allow notifications to stay updated with pet activities',
        icon: Icons.notifications,
      ),

      PermissionState(
        permission: AppPermission.bluetooth,
        status: PermissionStatus.denied,
        title: 'Bluetooth',
        description: 'Allow Bluetooth access for pet tracking devices',
        icon: Icons.bluetooth,
      ),
      PermissionState(
        permission: AppPermission.bluetoothScan,
        status: PermissionStatus.denied,
        title: 'Bluetooth Scanning',
        description: 'Allow scanning for nearby pet tracking devices',
        icon: Icons.bluetooth_searching,
      ),
      PermissionState(
        permission: AppPermission.bluetoothConnect,
        status: PermissionStatus.denied,
        title: 'Bluetooth Connection',
        description: 'Allow connecting to pet tracking devices',
        icon: Icons.bluetooth_connected,
      ),
    ];

    for (int i = 0; i < _permissions.length; i++) {
      final status = await _permissionService.checkPermission(
        _permissions[i].permission,
      );
      _updatePermissionStatus(i, status);
    }

    _setLoading(false);
  }

  Future<void> requestPermission(int index) async {
    if (index < 0 || index >= _permissions.length) return;

    final permission = _permissions[index].permission;
    final currentStatus = _permissions[index].status;

    if (currentStatus == PermissionStatus.permanentlyDenied) {
      await _permissionService.openAppSettings();
      final newStatus = await _permissionService.checkPermission(permission);
      _updatePermissionStatus(index, newStatus);
      return;
    }

    final status = await _permissionService.requestPermission(permission);
    _updatePermissionStatus(index, status);
  }

  void _updatePermissionStatus(int index, PermissionStatus status) {
    if (index < 0 || index >= _permissions.length) return;

    _permissions[index] = _permissions[index].copyWith(status: status);
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
