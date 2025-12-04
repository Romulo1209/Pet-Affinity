import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/shared/horizontal_item_selector_widget.dart';
import 'package:pet_affinity/shared/search_bar_widget.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class MapView1 extends StatelessWidget {
  const MapView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.sp,
            right: 16.sp,
            top: 16.sp,
            bottom: 8.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              SearchBarWidget(
                hintText: 'Buscar petshops, clínicas, eventos ...',
                onSearch: (value) {},
                controller: TextEditingController(),
              ),
              HorizontalItemSelectorWidget(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: AppColors.cardHomeBackground),
          ),
        ),
      ],
    );
  }
}
