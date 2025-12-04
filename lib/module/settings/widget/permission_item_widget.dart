import 'package:flutter/material.dart';
import 'package:pet_affinity/data/core/enum/permission_stats.dart';
import 'package:pet_affinity/module/settings/view_model/settings_view_model.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class PermissionItemWidget extends StatelessWidget {
  final PermissionState permissionState;
  final VoidCallback onRequestPermission;

  const PermissionItemWidget({
    Key? key,
    required this.permissionState,
    required this.onRequestPermission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          permissionState.icon,
          size: 32,
          color: _getIconColor(permissionState.status),
        ),
        title: Text(
          permissionState.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(permissionState.description),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    _getStatusIcon(permissionState.status),
                    size: 16,
                    color: _getIconColor(permissionState.status),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getStatusText(permissionState.status),
                    style: TextStyle(
                      color: _getIconColor(permissionState.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: _buildActionButton(permissionState.status),
      ),
    );
  }

  Widget _buildActionButton(PermissionStatus status) {
    if (status == PermissionStatus.granted) {
      return const SizedBox.shrink();
    }

    final String buttonText;
    final Color buttonColor;

    if (status == PermissionStatus.permanentlyDenied) {
      buttonText = 'Settings';
      buttonColor = Colors.orange;
    } else {
      buttonText = 'Allow';
      buttonColor = AppColors.primary;
    }

    return ElevatedButton(
      onPressed: onRequestPermission,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
      ),
      child: Text(buttonText),
    );
  }

  IconData _getStatusIcon(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return Icons.check_circle;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        return Icons.cancel;
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        return Icons.warning;
      case PermissionStatus.provisional:
        return Icons.info;
    }
  }

  String _getStatusText(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Allowed';
      case PermissionStatus.denied:
        return 'Denied';
      case PermissionStatus.permanentlyDenied:
        return 'Open Settings to Allow';
      case PermissionStatus.restricted:
        return 'Restricted';
      case PermissionStatus.limited:
        return 'Limited';
      case PermissionStatus.provisional:
        return 'Provisional';
    }
  }

  Color _getIconColor(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        return Colors.red;
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
        return Colors.orange;
      case PermissionStatus.provisional:
        return Colors.blue;
    }
  }
}
