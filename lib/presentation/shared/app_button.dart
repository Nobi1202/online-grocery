import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_grocery/presentation/theme/color_schemes.dart';
import 'package:online_grocery/presentation/theme/typography.dart';

class AppButton extends StatelessWidget {
  final String content;
  final VoidCallback onTap;
  final double? width;

  const AppButton({
    super.key,
    required this.content,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColorSchemes.cGreen,
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 24.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(content, style: AppTypography.tWhite18W600)],
        ),
      ),
    );
  }
}
