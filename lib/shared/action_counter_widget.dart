import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class ActionCounterWidget extends StatelessWidget {
  final String icon;
  final int counter;
  final Function()? onTap;
  final bool showCounter;
  const ActionCounterWidget({
    super.key,
    required this.icon,
    required this.counter,
    this.onTap,
    this.showCounter = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 20.w,
            colorFilter: const ColorFilter.mode(
              AppColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          if (showCounter) ...[
            SizedBox(width: 5.w),
            Text(
              NumberFormat.compact().format(counter),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
