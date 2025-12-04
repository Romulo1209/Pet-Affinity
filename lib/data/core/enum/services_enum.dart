import 'package:flutter/material.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_icons.dart';

enum ServicesEnum {
  adoption(
    label: 'Adoption',
    icon: AppIcons.petIcon,
    color: AppColors.serviceAdoption,
  ),
  petShop(
    label: 'Pet Shop',
    icon: AppIcons.shop,
    color: AppColors.servicePetShop,
  ),
  services(
    label: 'Serviços',
    icon: AppIcons.services,
    color: AppColors.serviceServices,
  ),
  events(
    label: 'Eventos',
    icon: AppIcons.events,
    color: AppColors.serviceEvents,
  ),
  lostPets(
    label: 'Pets \nPerdidos',
    icon: AppIcons.questionMark,
    color: AppColors.serviceLostPets,
  );

  final String label;
  final String icon;
  final Color color;

  const ServicesEnum({
    required this.label,
    required this.icon,
    required this.color,
  });
}
