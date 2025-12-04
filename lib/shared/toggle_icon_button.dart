import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ToggleIconButton extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final Color normalColor;
  final Color selectedColor;
  final double size;
  final bool isSelected;
  final Function()? onTap;

  const ToggleIconButton({
    required this.icon,
    required this.normalColor,
    required this.selectedColor,
    this.size = 42,
    this.isSelected = false,
    this.onTap,
    super.key,
  }) : svgPath = null;

  const ToggleIconButton.svg({
    required this.svgPath,
    required this.normalColor,
    required this.selectedColor,
    this.size = 42,
    this.isSelected = false,
    this.onTap,
    super.key,
  }) : icon = null;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: icon != null
          ? Icon(
              icon,
              size: size.sp,
              color: isSelected ? selectedColor : normalColor,
            )
          : SvgPicture.asset(
              svgPath!,
              width: size.sp,
              height: size.sp,
              colorFilter: ColorFilter.mode(
                isSelected ? selectedColor : normalColor,
                BlendMode.srcIn,
              ),
            ),
    );
  }
}
