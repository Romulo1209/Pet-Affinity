import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/app/app_routes.dart';
import 'package:pet_affinity/data/core/enum/bottom_sheet_enum.dart';
import 'package:pet_affinity/shared/bottom_bigger_icon_button.dart';
import 'package:pet_affinity/shared/toggle_icon_button.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class BottomSheetView extends StatefulWidget {
  final Function(BottomSheetEnum)? onTabChanged;
  final BottomSheetEnum? currentTab;

  const BottomSheetView({super.key, this.onTabChanged, this.currentTab});

  @override
  State<BottomSheetView> createState() => _BottomSheetViewState();
}

class _BottomSheetViewState extends State<BottomSheetView> {
  late BottomSheetEnum _current;

  @override
  void initState() {
    super.initState();
    _current = widget.currentTab ?? BottomSheetEnum.home;
  }

  @override
  void didUpdateWidget(BottomSheetView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentTab != null && widget.currentTab != _current) {
      _current = widget.currentTab!;
    }
  }

  void _onTabChanged(BottomSheetEnum tab) {
    if (tab == BottomSheetEnum.create) {
      Navigator.of(context).pushNamed(AppRoutes.createContent);
      return;
    }

    setState(() {
      _current = tab;
    });
    widget.onTabChanged?.call(tab);
  }

  @override
  Widget build(BuildContext context) {
    final items = BottomSheetEnum.values;
    final centerIndex = items.length ~/ 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppColors.greyDark, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = _current == item;

              if (index == centerIndex) {
                return SizedBox(width: 72.w, height: 42.h);
              }

              return ToggleIconButton.svg(
                svgPath: item.svgPath,
                normalColor: AppColors.unselectButton,
                selectedColor: AppColors.selectButton,
                isSelected: isSelected,
                onTap: () => _onTabChanged(item),
                size: 34,
              );
            }),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: BottomBiggerIconButton.svg(
              svgPath: items[centerIndex].svgPath!,
              normalColor: AppColors.white,
              selectedColor: AppColors.primaryDark,
              isSelected: _current == items[centerIndex],
              onTap: () => _onTabChanged(items[centerIndex]),
              verticalOffset: -8.h,
              backgroundSize: 68,
              iconSize: 48,
            ),
          ),
        ),
      ],
    );
  }
}
