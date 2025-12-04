import 'package:flutter/material.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_icons.dart';

enum PostTypesEnum {
  post(label: 'Postagem', icon: AppIcons.camera, color: AppColors.servicePost),
  adoption(
    label: 'Adoção',
    icon: AppIcons.petIcon,
    color: AppColors.serviceAdoption,
  ),
  breed(label: 'Cruzar', icon: AppIcons.breed, color: AppColors.serviceBreed),
  service(
    label: 'Serviços',
    icon: AppIcons.services,
    color: AppColors.serviceServices,
  ),
  event(
    label: 'Eventos',
    icon: AppIcons.events,
    color: AppColors.serviceEvents,
  ),
  lostPet(
    label: 'Pets Perdidos',
    icon: AppIcons.questionMark,
    color: AppColors.serviceLostPets,
  );

  final String label;
  final String icon;
  final Color color;

  const PostTypesEnum({
    required this.label,
    required this.icon,
    required this.color,
  });
}
