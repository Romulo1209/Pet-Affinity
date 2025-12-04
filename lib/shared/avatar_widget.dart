import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  final String photo;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final double radius;

  const AvatarWidget({
    super.key,
    required this.photo,
    this.showBorder = false,
    this.borderColor = Colors.white,
    this.borderWidth = 4,
    this.radius = 40,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxW = constraints.maxWidth;
        final double maxH = constraints.maxHeight;
        double diameter = math.min(maxW, maxH);
        if (!diameter.isFinite || diameter <= 0) {
          diameter = radius;
        }

        final double innerSize = math.max(
          0,
          showBorder ? (diameter - (borderWidth * 2)) : diameter,
        );

        return Center(
          child: SizedBox(
            width: diameter,
            height: diameter,
            child: Container(
              alignment: Alignment.center,
              decoration: showBorder
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: borderColor,
                        width: borderWidth.r,
                      ),
                    )
                  : null,
              child: ClipOval(
                child: Image.asset(
                  photo,
                  width: innerSize.r,
                  height: innerSize.r,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
