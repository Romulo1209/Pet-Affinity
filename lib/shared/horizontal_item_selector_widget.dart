import 'package:flutter/material.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalItemSelectorWidget extends StatelessWidget {
  const HorizontalItemSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) => selectedItem(index == 0)).expand(
          (w) sync* {
            yield w;
            yield SizedBox(width: 10.w);
          },
        ).toList()..removeLast(),
      ),
    );
  }

  Widget selectedItem(bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.transparent,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Text(
        "Jorgin",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? AppColors.white : AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
