import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const _base = TextStyle(
    fontFamily: 'Cairo',
    color: AppColors.darkText,
    height: 1.5,
  );

  static final display = _base.copyWith(fontSize: 32, fontWeight: FontWeight.w800);
  static final h1 = _base.copyWith(fontSize: 26, fontWeight: FontWeight.w700);
  static final h2 = _base.copyWith(fontSize: 22, fontWeight: FontWeight.w700);
  static final h3 = _base.copyWith(fontSize: 18, fontWeight: FontWeight.w600);
  static final bodyLarge = _base.copyWith(fontSize: 16, fontWeight: FontWeight.w400);
  static final body = _base.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
  static final caption = _base.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.subText);
  static final label = _base.copyWith(fontSize: 16, fontWeight: FontWeight.w600);
  static final button = _base.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.white);
  static final link = _base.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary);
}
