import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class TapIconButton extends StatelessWidget {
  final String icon;
  final Color color;
  final Function() onTap;
  const TapIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = AppColors.primaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        width: 24.w,
        height: 24.h,
      ),
      onPressed: onTap,
    );
  }
}
