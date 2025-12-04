import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/shared/avatar_widget.dart';

class PhotoNameWidget extends StatelessWidget {
  final String photo;
  final String name;
  final double height;
  final Color textColor;
  final double fontSize;
  const PhotoNameWidget({
    super.key,
    required this.photo,
    required this.name,
    this.height = 60,
    this.textColor = Colors.black,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Row(
        children: [
          AvatarWidget(photo: photo),
          SizedBox(width: 8.w),
          Text(
            name,
            style: TextStyle(
              fontSize: fontSize.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
