import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/constants/app_colors.dart';

/// SheShield – Shimmer Loading Widget
///
/// Premium shimmer skeleton for loading states.
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 60,
    this.borderRadius = 16,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariant,
      highlightColor: AppColors.surface,
      child: Container(
        width: width,
        height: height,
        margin: margin ?? const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  /// Create a list shimmer loading effect
  static Widget list({int count = 3, double height = 72}) {
    return Column(
      children: List.generate(
        count,
        (index) => ShimmerLoading(height: height),
      ),
    );
  }

  /// Create a card shimmer
  static Widget card({double height = 120}) {
    return ShimmerLoading(height: height, borderRadius: 20);
  }
}
