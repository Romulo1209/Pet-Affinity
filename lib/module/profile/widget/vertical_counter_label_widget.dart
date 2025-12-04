import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class VerticalCounterLabelWidget extends StatelessWidget {
  final int counter;
  final int counterFontSize;
  final int labelFontSize;
  final String label;
  final Function()? onTap;

  const VerticalCounterLabelWidget({
    super.key,
    required this.counter,
    this.counterFontSize = 24,
    this.labelFontSize = 14,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 0.3.sw,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              NumberFormat.compact().format(counter),
              style: TextStyle(
                fontSize: counterFontSize.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: labelFontSize.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
