import 'package:flutter/material.dart';

/// SheShield Design System – Color Palette
/// 
/// A luxurious, feminine color system inspired by
/// lavender fields, blush roses, and rose gold jewelry.
/// Every color is crafted to feel empowering and elegant — like a diva 💅
class AppColors {
  AppColors._();

  // ──────────────────────────────────────────────
  // ✨ Primary Palette – Dark Burgundy & Rose
  // ──────────────────────────────────────────────
  static const Color primary = Color(0xFFB62B5A);
  static const Color primaryLight = Color(0xFFE75480);
  static const Color primaryDark = Color(0xFF7B1E3A);
  static const Color primarySurface = Color(0xFF4B0E1E);

  // ──────────────────────────────────────────────
  // 🌸 Secondary Palette – Blush Pink & Rose
  // ──────────────────────────────────────────────
  static const Color secondary = Color(0xFFE75480);
  static const Color secondaryLight = Color(0xFFFFC1D6);
  static const Color secondaryDark = Color(0xFFB62B5A);
  static const Color secondarySurface = Color(0xFF3B0D17);

  // ──────────────────────────────────────────────
  // ✦ Tertiary Palette – Rose Gold
  // ──────────────────────────────────────────────
  static const Color roseGold = Color(0xFFE5C396);
  static const Color roseGoldLight = Color(0xFFF9E9D2);
  static const Color roseGoldDark = Color(0xFFC49F6C);
  static const Color roseGoldShimmer = Color(0xFFFFF6E5);

  // ──────────────────────────────────────────────
  // 💜 Accent Palette – Hot Pink
  // ──────────────────────────────────────────────
  static const Color accent = Color(0xFFE75480);
  static const Color accentLight = Color(0xFFFFC1D6);
  static const Color accentSurface = Color(0xFF4A1521);

  // ──────────────────────────────────────────────
  // 🚨 Emergency / SOS
  // ──────────────────────────────────────────────
  static const Color emergency = Color(0xFFE75480);
  static const Color emergencyLight = Color(0xFFFFC1D6);
  static const Color emergencyDark = Color(0xFF7B1E3A);
  static const Color emergencyGlow = Color(0x40E75480);

  // ──────────────────────────────────────────────
  // 🟢 Status Colors
  // ──────────────────────────────────────────────
  static const Color success = Color(0xFF81C784);
  static const Color successLight = Color(0xFF1B3B22);
  static const Color warning = Color(0xFFFFB74D);
  static const Color warningLight = Color(0xFF3E2713);
  static const Color info = Color(0xFF64B5F6);
  static const Color infoLight = Color(0xFF152A3C);

  // ──────────────────────────────────────────────
  // 🎨 Surfaces & Backgrounds (Dark Burgundy)
  // ──────────────────────────────────────────────
  static const Color background = Color(0xFF12060A);
  static const Color surface = Color(0xFF1A0A10);
  static const Color surfaceVariant = Color(0xFF260E17);
  static const Color surfaceDim = Color(0xFF1A0A10);
  static const Color cardBackground = Color(0xFF1C0B12);

  // ──────────────────────────────────────────────
  // 📝 Text Colors
  // ──────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFFFC1D6);
  static const Color textTertiary = Color(0xFFE75480);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ──────────────────────────────────────────────
  // 🔲 Borders & Dividers
  // ──────────────────────────────────────────────
  static const Color border = Color(0xFF4D1C2A);
  static const Color borderLight = Color(0xFF3A141F);
  static const Color divider = Color(0xFF3A141F);

  // ──────────────────────────────────────────────
  // 🌊 Gradient Presets
  // ──────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7B1E3A), Color(0xFFE75480)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4B0E1E),
      Color(0xFF7B1E3A),
      Color(0xFFB62B5A),
    ],
  );

  static const LinearGradient roseGoldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE5C396), Color(0xFFF9E9D2)],
  );

  static const LinearGradient emergencyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7B1E3A), Color(0xFFE75480)],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4B0E1E),
      Color(0xFF7B1E3A),
      Color(0xFFB62B5A),
      Color(0xFFE75480),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x15FFFFFF),
      Color(0x05FFFFFF),
    ],
  );

  // ──────────────────────────────────────────────
  // 💎 Glassmorphism
  // ──────────────────────────────────────────────
  static const Color glassWhite = Color(0x15FFFFFF);
  static const Color glassBorder = Color(0x25FFFFFF);
  static const Color glassShadow = Color(0x11000000);

  // ──────────────────────────────────────────────
  // 🌙 Dark Mode (Compatibility/Future)
  // ──────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF12060A);
  static const Color darkSurface = Color(0xFF1A0A10);
  static const Color darkCard = Color(0xFF1C0B12);
}
