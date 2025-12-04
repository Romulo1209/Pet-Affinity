import 'package:flutter/material.dart';
import 'package:pet_affinity/module/create_content/view/create_content_view.dart';
import 'package:pet_affinity/module/home/view/home_view_wrapper.dart';
import 'package:pet_affinity/module/settings/view/settings_view.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeViewWrapper());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case AppRoutes.createContent:
        return MaterialPageRoute(builder: (_) => const CreateContentView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Rota não encontrada')),
            body: Center(child: Text('Rota desconhecida: ${settings.name}')),
          ),
        );
    }
  }
}
