import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class SettingsButtonWidget extends StatelessWidget {
  final Function() onPressed;
  const SettingsButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/settings.svg',
        colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        width: 24.w,
        height: 24.h,
      ),
      onPressed: onPressed,
    );
  }
}
