import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/data/core/enum/services_enum.dart';
import 'package:pet_affinity/module/profile/widget/pet_chip_widget.dart';
import 'package:pet_affinity/module/profile/widget/post_widget.dart';
import 'package:pet_affinity/shared/section_widget.dart';
import 'package:pet_affinity/shared/square_icon_button_widget.dart';
import 'package:pet_affinity/shared/text_background_button_widget.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_images.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 16.h),
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.cardHomeBackground,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Encontre seu novo amigo pet aqui.',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 20.h),
              TextBackgroundButtonWidget(
                text: 'Adote seu Pet',
                backgroundColor: AppColors.primary,
                onTap: () {},
              ),
            ],
          ),
        ),
        Container(
          height: 80.w,
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ServicesEnum.values.length,
            separatorBuilder: (context, index) => SizedBox(width: 5.w),
            itemBuilder: (context, index) {
              final service = ServicesEnum.values[index];
              return SquareIconButtonWidget(
                icon: service.icon,
                label: service.label,
                backgroundColor: service.color,
                textColor: AppColors.white,
              );
            },
          ),
        ),
        SectionWidget(
          title: 'Pets em Destaque',
          height: 0.25.sh,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            children: [
              PetChipWidget(
                name: 'Luna',
                age: '2 anos',
                image: AppImages.petImage,
              ),
              SizedBox(width: 10.w),
              PetChipWidget(
                name: 'Max',
                age: '3 anos',
                image: AppImages.petImage2,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SectionWidget(
          title: 'Postagens',
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => const PostWidget(),
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
          ),
        ),
      ],
    );
  }
}
