import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_affinity/utils/app_colors.dart';

class ProfileSelectorWidget extends StatefulWidget {
  final List<String> profiles;
  final String? value;
  final ValueChanged<String>? onChanged;
  final String prefixText;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;

  const ProfileSelectorWidget({
    super.key,
    this.profiles = const ['Sarah', 'Rex', 'Luna'],
    this.value,
    this.onChanged,
    this.prefixText = 'Postar como',
    this.borderRadius = 8,
    this.borderColor = AppColors.createContentBorderColor,
    this.backgroundColor = AppColors.white,
    this.padding,
  });

  @override
  State<ProfileSelectorWidget> createState() => _ProfileSelectorWidgetState();
}

class _ProfileSelectorWidgetState extends State<ProfileSelectorWidget> {
  late String _selected;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _selected =
        widget.value ??
        (widget.profiles.isNotEmpty ? widget.profiles.first : '');
  }

  @override
  void didUpdateWidget(ProfileSelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && widget.value != _selected) {
      _selected = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry contentPadding =
        widget.padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h);

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _toggle,
        child: Container(
          padding: contentPadding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
            border: Border.all(
              color: widget.borderColor.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.prefixText} $_selected',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.createContentTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Transform.rotate(
                angle: _isOpen ? math.pi : 0,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 18.sp,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    if (_isOpen) {
      _closeOverlay();
    } else {
      _openOverlay();
    }
  }

  void _openOverlay() {
    if (_overlayEntry != null) return;

    final RenderBox box = context.findRenderObject() as RenderBox;
    final Size targetSize = box.size;

    // Mantido para possíveis ajustes futuros de altura de item

    // Calcular a largura necessária baseada no maior texto
    final TextStyle itemStyle = TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    );
    double maxTextWidth = 0;
    for (final name in widget.profiles) {
      final painter = TextPainter(
        text: TextSpan(text: '${widget.prefixText} $name', style: itemStyle),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      maxTextWidth = math.max(maxTextWidth, painter.width);
    }
    final double horizontalPadding = (widget.padding is EdgeInsets)
        ? ((widget.padding as EdgeInsets).horizontal)
        : (12.w * 2);
    final double desiredMenuWidth = maxTextWidth + horizontalPadding;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final RenderBox overlayBox =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final Size screenSize = overlayBox.size;
        final Offset targetTopLeft = box.localToGlobal(
          Offset.zero,
          ancestor: overlayBox,
        );

        // Espaço disponível abaixo e à direita do alvo
        final double availableBelow =
            screenSize.height - (targetTopLeft.dy + targetSize.height) - 8.h;
        final double maxWidthRight = screenSize.width - targetTopLeft.dx - 8;

        // Largura do menu respeitando as bordas
        double width = math.min(desiredMenuWidth, screenSize.width - 16);
        double horizontalShift = 0;
        if (width > maxWidthRight) {
          horizontalShift = -(width - maxWidthRight);
        }
        if (targetTopLeft.dx + horizontalShift < 8) {
          horizontalShift = 8 - targetTopLeft.dx;
        }

        // Altura para caber todos os itens ou o espaço disponível
        final double itemHeight = 40.h;
        final double desiredHeight =
            (widget.profiles.length * itemHeight) + 8.h;
        final double menuHeight = math.max(
          0,
          math.min(desiredHeight, availableBelow),
        );

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeOverlay,
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(horizontalShift, targetSize.height),
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: width + 16.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius.r,
                      ),
                      border: Border.all(color: widget.borderColor, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: menuHeight),
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        shrinkWrap: true,
                        physics: menuHeight < desiredHeight
                            ? const BouncingScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        children: widget.profiles.map((name) {
                          final bool isSelected = name == _selected;
                          return InkWell(
                            onTap: () {
                              setState(() => _selected = name);
                              widget.onChanged?.call(name);
                              _closeOverlay();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${widget.prefixText} $name',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  @override
  void dispose() {
    _closeOverlay();
    super.dispose();
  }
}
