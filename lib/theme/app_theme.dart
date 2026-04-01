import 'package:flutter/material.dart';

/// Couleurs alignées sur les maquettes Budiz.
abstract final class AppColors {
  static const Color coral = Color(0xFFEF7171);
  static const Color coralDark = Color(0xFFF06A6A);
  static const Color teal = Color(0xFF4DB6AC);
  static const Color tealDark = Color(0xFF26A69A);
  static const Color scaffoldBg = Color(0xFFFFFFFF);
  static const Color fieldBorder = Color(0xFFE0E0E0);
  static const Color textSecondary = Color(0xFF757575);
  static const Color searchFill = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
}

InputDecoration budizInputDecoration({
  required String label,
  String? hint,
  Widget? suffix,
}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    suffixIcon: suffix,
    filled: true,
    fillColor: AppColors.scaffoldBg,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.fieldBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.fieldBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.coral, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    labelStyle: const TextStyle(
      color: AppColors.textSecondary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  );
}

ButtonStyle budizPrimaryButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: AppColors.coral,
    foregroundColor: Colors.white,
    disabledBackgroundColor: AppColors.coral.withValues(alpha: 0.5),
    minimumSize: const Size(double.infinity, 54),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
}
