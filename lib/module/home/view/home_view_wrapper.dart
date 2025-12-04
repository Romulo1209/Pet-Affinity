import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/module/chat/view/chat_view.dart';
import 'package:pet_affinity/module/home/view/home_content.dart';
import 'package:pet_affinity/module/home/widget/navigation_button_widget.dart';
import 'package:pet_affinity/module/home/widget/settings_button_widget.dart';
import 'package:pet_affinity/module/map/view/map_view.dart';
import 'package:pet_affinity/module/map/view/map_view1.dart';
import 'package:pet_affinity/module/profile/view/profile_content.dart';
import 'package:pet_affinity/shared/bottom_sheet_view.dart';
import 'package:pet_affinity/shared/tap_icon_button.dart';
import 'package:pet_affinity/utils/app_colors.dart';
import 'package:pet_affinity/data/core/enum/bottom_sheet_enum.dart';
import 'package:pet_affinity/utils/app_icons.dart';

class HomeViewWrapper extends StatefulWidget {
  const HomeViewWrapper({super.key});

  @override
  State<HomeViewWrapper> createState() => _HomeViewWrapperState();
}

class _HomeViewWrapperState extends State<HomeViewWrapper> {
  BottomSheetEnum _currentTab = BottomSheetEnum.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: NavigationButtonWidget(onPressed: () {}),
        title: Text(
          "Pet Affinity",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        actions: [
          if (_currentTab == BottomSheetEnum.profile)
            SettingsButtonWidget(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            )
          else
            TapIconButton(
              icon: AppIcons.bell,
              color: AppColors.white,
              onTap: () {},
            ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomSheetView(
        onTabChanged: (tab) {
          setState(() {
            _currentTab = tab;
          });
        },
        currentTab: _currentTab,
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentTab) {
      case BottomSheetEnum.home:
        return HomeContent();
      case BottomSheetEnum.map:
        return MapView1();
      case BottomSheetEnum.create:
        return Container();
      case BottomSheetEnum.chat:
        return ChatView();
      case BottomSheetEnum.profile:
        return ProfileContent();
    }
  }
}
