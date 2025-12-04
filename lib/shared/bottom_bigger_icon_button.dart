import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class BottomBiggerIconButton extends StatelessWidget {
  final IconData? icon;
  final String? svgPath;
  final Color normalColor;
  final Color selectedColor;
  final Color backgroundColor;
  final double iconSize;
  final double backgroundSize;
  final bool isSelected;
  final VoidCallback? onTap;
  final double verticalOffset;

  const BottomBiggerIconButton({
    super.key,
    required this.icon,
    required this.normalColor,
    required this.selectedColor,
    this.backgroundColor = AppColors.primary,
    this.iconSize = 28,
    this.backgroundSize = 56,
    this.isSelected = false,
    this.onTap,
    this.verticalOffset = 0,
  }) : svgPath = null;

  const BottomBiggerIconButton.svg({
    super.key,
    required this.svgPath,
    required this.normalColor,
    required this.selectedColor,
    this.backgroundColor = AppColors.primary,
    this.iconSize = 28,
    this.backgroundSize = 56,
    this.isSelected = false,
    this.onTap,
    this.verticalOffset = 0,
  }) : icon = null;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, verticalOffset),
      child: InkWell(
        borderRadius: BorderRadius.circular(backgroundSize.r / 2),
        onTap: onTap,
        child: Container(
          width: backgroundSize.r,
          height: backgroundSize.r,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: icon != null
              ? Icon(
                  icon!,
                  size: iconSize.r,
                  color: isSelected ? selectedColor : normalColor,
                )
              : Center(
                  child: SizedBox(
                    width: iconSize.r,
                    height: iconSize.r,
                    child: SvgPicture.asset(
                      svgPath!,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        isSelected ? selectedColor : normalColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
