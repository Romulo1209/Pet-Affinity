import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_affinity/shared/action_counter_widget.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_icons.dart';
import 'package:pet_affinity/utils/app_images.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.chipBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppImages.banner),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sarah Doe',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        'Amante de gatos e cachorros | Tutora de Luna e Max',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.flag_outlined, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200.h,
            width: double.infinity,
            child: Image.asset(AppImages.petImage, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  spacing: 10.w,
                  children: [
                    ActionCounterWidget(
                      icon: AppIcons.heartOutline,
                      counter: 10340,
                    ),
                    ActionCounterWidget(icon: AppIcons.comment, counter: 376),
                    ActionCounterWidget(
                      icon: AppIcons.repost,
                      counter: 100,
                      showCounter: false,
                    ),
                    ActionCounterWidget(
                      icon: AppIcons.share,
                      counter: 100,
                      showCounter: false,
                    ),
                    Spacer(),
                    Text(
                      '${NumberFormat.compact().format(137270)} visualizações',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
