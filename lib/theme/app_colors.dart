import 'package:flutter/material.dart';
import 'theme_manager.dart';

/// Semantic color palette for SocialPulse.
///
/// Every screen should read colors from here (e.g. `AppColors.background`)
/// instead of writing `Color(0xFF0A0C10)` directly. That's what makes the
/// dark/light toggle actually work everywhere at once.
class AppColors {
  AppColors._();

  static bool get _dark => themeManager.isDark;

  // Original dark-mode palette (unchanged from the original design system)
  static const _darkBackground = Color(0xFF0A0C10);
  static const _darkSurface = Color(0xFF12151C);
  static const _darkCard = Color(0xFF1A1F2B);
  static const _darkBorder = Color(0xFF252B38);
  static const _darkMutedText = Color(0xFF64748B);
  static const _darkPrimaryText = Color(0xFFE2E8F0);

  // New light-mode counterparts
  static const _lightBackground = Color(0xFFF7F8FA);
  static const _lightSurface = Color(0xFFFFFFFF);
  static const _lightCard = Color(0xFFFFFFFF);
  static const _lightBorder = Color(0xFFE2E5EA);
  static const _lightMutedText = Color(0xFF64748B);
  static const _lightPrimaryText = Color(0xFF0F1115);

  // Accent colors stay identical in both modes — they're the brand,
  // and were already tuned to work on dark; they read fine on light too.
  static const accentGreen = Color(0xFF10B981); // slightly deeper for light bg contrast
  static const accentGreenDark = Color(0xFF6EE7B7); // original, used on dark
  static const accentPurple = Color(0xFF818CF8);
  static const accentPink = Color(0xFFF472B6);
  static const yellow = Color(0xFFFCD34D);
  static const danger = Color(0xFFF87171);

  static Color get background => _dark ? _darkBackground : _lightBackground;
  static Color get surface => _dark ? _darkSurface : _lightSurface;
  static Color get card => _dark ? _darkCard : _lightCard;
  static Color get border => _dark ? _darkBorder : _lightBorder;
  static Color get mutedText => _dark ? _darkMutedText : _lightMutedText;
  static Color get primaryText => _dark ? _darkPrimaryText : _lightPrimaryText;

  /// The main green accent — swaps to a slightly deeper shade in light
  /// mode so it stays readable on a white card.
  static Color get accent => _dark ? accentGreenDark : accentGreen;

  static Brightness get brightness =>
      _dark ? Brightness.dark : Brightness.light;
}
