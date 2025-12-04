import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const SectionWidget({
    super.key,
    required this.title,
    required this.child,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final sectionContent = Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 0.05.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10.h),
          if (height != null) Expanded(child: child) else child,
        ],
      ),
    );

    return height == null
        ? sectionContent
        : SizedBox(height: height, child: sectionContent);
  }
}
