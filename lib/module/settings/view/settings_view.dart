import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_affinity/module/settings/view_model/settings_view_model.dart';
import 'package:pet_affinity/module/settings/widget/permission_item_widget.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      child: const SettingsContent(),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionHeader(title: 'Permissions'),
                _buildPermissionsList(viewModel),
                const SizedBox(height: 24),
                // Other settings sections can be added here
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPermissionsList(SettingsViewModel viewModel) {
    if (viewModel.permissions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No permissions to display'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.permissions.length,
      itemBuilder: (context, index) {
        return PermissionItemWidget(
          permissionState: viewModel.permissions[index],
          onRequestPermission: () => viewModel.requestPermission(index),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
