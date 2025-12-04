import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/module/profile/widget/pet_chip_widget.dart';
import 'package:pet_affinity/module/profile/widget/post_widget.dart';
import 'package:pet_affinity/module/profile/widget/profile_photo_widget.dart';
import 'package:pet_affinity/module/profile/widget/vertical_counter_label_widget.dart';
import 'package:pet_affinity/shared/section_widget.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_images.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.225.sh + 0.12.sh,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 0.225.sh,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.banner),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0.225.sh,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 0.12.sh,
                    padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                    child: Row(
                      children: [
                        SizedBox(width: 0.3.sw, height: double.infinity),
                        SizedBox(
                          width: 0.6.sw,
                          height: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sarah Doe',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Amante de gatos e cachorros \n| Tutora de Luna e Max',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0.225.sh - (0.3.sw / 2),
                  left: 0.05.sw,
                  child: ProfilePhotoWidget(),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 0.1.sh,
            padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
            child: Row(
              children: [
                VerticalCounterLabelWidget(
                  counter: 350,
                  label: 'Seguidores',
                  counterFontSize: 22,
                ),
                VerticalCounterLabelWidget(
                  counter: 280,
                  label: 'Seguindo',
                  counterFontSize: 22,
                ),
                VerticalCounterLabelWidget(
                  counter: 45,
                  label: 'Posts',
                  counterFontSize: 22,
                ),
              ],
            ),
          ),
          SizedBox(height: 15.h),
          SectionWidget(
            title: 'Meus Pets',
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
          SizedBox(height: 15.h),
          SectionWidget(
            title: 'Atividades',
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => const PostWidget(),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
            ),
          ),
        ],
      ),
    );
  }
}
