import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_affinity/data/core/enum/utils/content_position_enum.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class HorizontalIconButton extends StatelessWidget {
  final String icon;
  final String label;
  final bool withIcon;
  final Color backgroundColor;
  final Color contentColor;
  final double iconSize;
  final double fontSize;
  final ContentPositionEnum contentPosition;
  final Function() onTap;

  const HorizontalIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.withIcon = true,
    this.backgroundColor = AppColors.primary,
    this.contentColor = AppColors.white,
    this.contentPosition = ContentPositionEnum.center,
    this.iconSize = 24,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: contentPosition == ContentPositionEnum.left
            ? MainAxisAlignment.start
            : contentPosition == ContentPositionEnum.right
            ? MainAxisAlignment.end
            : MainAxisAlignment.center,
        children: [
          if (withIcon)
            SvgPicture.asset(
              icon,
              width: iconSize.w,
              height: iconSize.h,
              colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn),
            ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              color: contentColor,
              fontSize: fontSize.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
