import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/utils/app_icons.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final Function(String) onSearch;
  final TextEditingController controller;

  const SearchBarWidget({
    super.key,
    required this.hintText,
    required this.onSearch,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.searchBarBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppIcons.search,
            colorFilter: ColorFilter.mode(
              AppColors.searchBarItemsColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(color: AppColors.searchBarItemsColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
