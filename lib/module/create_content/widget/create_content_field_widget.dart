import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_icons.dart';

class CreateContentFieldWidget extends StatelessWidget {
  final Function()? onImagePressed;
  final Function()? onLocationPressed;
  final Function(String)? onTextChanged;

  const CreateContentFieldWidget({
    super.key,
    this.onImagePressed,
    this.onLocationPressed,
    this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      padding: EdgeInsets.all(6.sp),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.createContentBorderColor.withOpacity(0.5),
          width: 1.5.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              onChanged: (value) => onTextChanged?.call(value),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'O que você deseja compartilhar?',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onImagePressed,
                child: SvgPicture.asset(
                  AppIcons.imageIconOutline,
                  colorFilter: ColorFilter.mode(
                    AppColors.createContentBorderColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: onLocationPressed,
                child: SvgPicture.asset(
                  AppIcons.locationOutline,
                  colorFilter: ColorFilter.mode(
                    AppColors.createContentBorderColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
