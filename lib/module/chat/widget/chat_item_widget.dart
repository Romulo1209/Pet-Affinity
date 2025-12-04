import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/shared/avatar_widget.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class ChatItemWidget extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  final bool isRead;
  final Function()? onTap;

  const ChatItemWidget({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    required this.isRead,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarWidget(photo: image, radius: 80),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (isRead) ...[
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textPrimary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
