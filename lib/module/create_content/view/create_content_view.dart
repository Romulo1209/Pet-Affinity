import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/data/core/enum/post_types_enum.dart';
import 'package:pet_affinity/module/create_content/widget/create_content_field_widget.dart';
import 'package:pet_affinity/module/create_content/widget/profile_selector_widget.dart';
import 'package:pet_affinity/shared/horizontal_icon_button.dart';
import 'package:pet_affinity/shared/photo_name_widget.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_icons.dart';
import 'package:pet_affinity/utils/app_images.dart';

class CreateContentView extends StatefulWidget {
  const CreateContentView({super.key});

  @override
  State<CreateContentView> createState() => _CreateContentViewState();
}

class _CreateContentViewState extends State<CreateContentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Novo Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 24.sp),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.h,
              children: [
                PhotoNameWidget(
                  photo: AppImages.banner,
                  name: 'Sarah Doe',
                  height: 50,
                ),
                ProfileSelectorWidget(),
                CreateContentFieldWidget(),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3.5,
                  ),
                  itemCount: PostTypesEnum.values.length,
                  itemBuilder: (context, index) => HorizontalIconButton(
                    icon: PostTypesEnum.values[index].icon,
                    label: PostTypesEnum.values[index].label,
                    backgroundColor: PostTypesEnum.values[index].color,
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: HorizontalIconButton(
                      icon: AppIcons.home,
                      label: 'Enviar',
                      withIcon: false,
                      fontSize: 20,
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(AppImages.createIcon, width: 180.w),
            ),
          ],
        ),
      ),
    );
  }
}
