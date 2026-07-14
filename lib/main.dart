import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'schedule_screen.dart';
import 'analytics_screen.dart';
import 'compose_screen.dart';
import 'settings_screen.dart';
import 'theme/theme_manager.dart';
import 'theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved theme preference (defaults to dark, matching the
  // original design, if nothing has been saved yet).
  await themeManager.load();

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  // Force portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Make status bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const SocialPulseApp());
}

class SocialPulseApp extends StatelessWidget {
  const SocialPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeManager,
      builder: (context, _) => _buildApp(context),
    );
  }

  Widget _buildApp(BuildContext context) {
    final isDark = themeManager.isDark;
    return MaterialApp(
      title: 'SocialPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: AppColors.brightness,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme(
          brightness: AppColors.brightness,
          primary: AppColors.accent,
          secondary: AppColors.accentPurple,
          surface: AppColors.surface,
          onPrimary: isDark ? Colors.black : Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.primaryText,
          error: AppColors.danger,
          onError: Colors.white,
        ),
      ),
      // Use a StreamBuilder to determine the initial route
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen(); // Or a simple loading indicator
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const SplashScreen(); // Show splash then login if no user
        },
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
        '/compose': (context) => const ComposeScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
