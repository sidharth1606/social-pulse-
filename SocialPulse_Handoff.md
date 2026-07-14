# ============================================================
# SOCIALPULSE — COMPLETE PROJECT HANDOFF
# ============================================================
# App: SocialPulse (Social Media Manager for Agencies)
# Developer: Sidharth Ganapathi
# Platform: Android (Flutter + Dart)
# Flutter Version: 3.41.4 stable
# Package: com.example.social_pulse
# Firebase Project ID: social-pulse-71362
# ============================================================

## CURRENT STATUS
- All 7 UI screens are 100% complete and tested on Android emulator
- Fresh Flutter project just created at:
  E:\IT Company\application development\social_pulse
- Next task: Add all screen files + Firebase setup

## YOUR FIRST JOB
The user has a brand new empty Flutter project. You need to:
1. Give them all the files listed below (one by one)
2. They will copy each file into the correct location
3. Run flutter pub get
4. Run flutter run on Android emulator
5. Then set up Firebase

## IMPORTANT RULES
- Always send COMPLETE files (never partial code)
- User is on Windows 11, VS Code + Android Studio
- Emulator: Medium Phone API 36.1 (Android 16.0 x86_64)
- Always use dark theme — NEVER light theme
- Font: GoogleFonts.syne() for headings, GoogleFonts.dmSans() for body

## DESIGN SYSTEM (use these EXACT colors always)
Background:    Color(0xFF0A0C10)
Surface:       Color(0xFF12151C)
Card:          Color(0xFF1A1F2B)
Border:        Color(0xFF252B38)
Accent Green:  Color(0xFF6EE7B7)  ← primary accent
Accent Purple: Color(0xFF818CF8)
Accent Pink:   Color(0xFFF472B6)
Yellow:        Color(0xFFFCD34D)
Muted text:    Color(0xFF64748B)
Primary text:  Color(0xFFE2E8F0)
Danger/Red:    Color(0xFFF87171)

## FILE LOCATIONS
All files go inside: social_pulse/
- pubspec.yaml           → social_pulse/pubspec.yaml
- main.dart              → social_pulse/lib/main.dart
- splash_screen.dart     → social_pulse/lib/splash_screen.dart
- login_screen.dart      → social_pulse/lib/login_screen.dart
- home_screen.dart       → social_pulse/lib/home_screen.dart
- schedule_screen.dart   → social_pulse/lib/schedule_screen.dart
- analytics_screen.dart  → social_pulse/lib/analytics_screen.dart
- compose_screen.dart    → social_pulse/lib/compose_screen.dart
- settings_screen.dart   → social_pulse/lib/settings_screen.dart

## NAVIGATION FLOW
Splash (3.5s) → Login → Home
Home FAB → Compose
Home bottom nav → Schedule / Analytics / Settings
Schedule FAB → platform picker sheet → Compose
Settings Log Out → Login

## ROUTES
'/'           → SplashScreen
'/login'      → LoginScreen
'/home'       → HomeScreen
'/schedule'   → ScheduleScreen
'/analytics'  → AnalyticsScreen
'/compose'    → ComposeScreen
'/settings'   → SettingsScreen

## PHASE 2 — FIREBASE (do this after all screens work)
Packages to add to pubspec.yaml:
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  google_sign_in: ^6.2.1

google-services.json is already downloaded and goes in:
  social_pulse/android/app/google-services.json

Firebase Console: https://console.firebase.google.com/project/social-pulse-71362/overview

android/build.gradle.kts (root) needs:
  id("com.google.gms.google-services") version "4.4.4" apply false

android/app/build.gradle.kts needs:
  id("com.google.gms.google-services") in plugins
  minSdk = 23
  dependencies block with firebase-bom:33.6.0

## PHASE 3 — GOOGLE CALENDAR
Package: googleapis: ^13.0.0
- Settings screen Google Calendar toggle already built (UI only)
- Schedule screen Built-in/Google Calendar toggle already built (UI only)
- Just needs OAuth + API connection

## SCREENS SUMMARY

### Screen 1: Splash (splash_screen.dart)
- Dark bg with radial glow effects (green top-right, purple bottom-left)
- Animated logo: gradient square with hub icon, bounces in with elasticOut
- App name "SocialPulse" fades + slides up
- Tagline "Manage. Schedule. Grow." fades in
- Auto-navigates to /login after 3.5 seconds

### Screen 2: Login (login_screen.dart)
- "Welcome back 👋" large heading
- Email + Password text fields (dark styled)
- Show/hide password toggle
- Gradient Sign In button (green→purple) with loading spinner
- Google Sign In button (placeholder, not connected)
- Forgot Password + Sign Up links
- Goes to /home on login

### Screen 3: Home Dashboard (home_screen.dart)
- "Good morning, Sidharth 👋" greeting + avatar + notification bell
- Client dropdown: Nike India
- 4 stat cards: Total Reach 48.2K, Engagement 6.8%, Posts Today 4, New Followers +234
- Platform chips: Instagram 22.1K, Twitter/X 15.3K, LinkedIn 10.8K
- Weekly bar chart (Thu highlighted green)
- Upcoming posts list (2 posts shown)
- Bottom nav: Home(active) | Schedule | [FAB] | Analytics | Settings
- FAB navigates to /compose

### Screen 4: Schedule (schedule_screen.dart)
- Toggle: Built-in | Google Calendar (Google Calendar shows "coming soon" snackbar)
- Week strip MON-SUN, tap to select (FRI highlighted green by default)
- "Friday, March 8 — 4 posts"
- Post list with time, platform icon, status badges
- Status colors: Published=green, Scheduled=yellow, Draft=gray
- 3-dot menu → Edit/Reschedule/Duplicate/Delete bottom sheet
- FAB + top ➕ → platform sheet: Instagram/Twitter/LinkedIn/All Platforms
- Platform sheet options ALL navigate to /compose

### Screen 5: Analytics (analytics_screen.dart)
- 7 Days / 30 Days / 90 Days range selector
- All / Instagram / Twitter / LinkedIn filter chips
- Hero card: 312,840 Impressions + sparkline line chart
- 6 metric chips: Likes 14.2K, Comments 3.8K, Shares 7.1K, Clicks 892, Profile 48K, Followers +234
- Platform breakdown LinearProgressIndicator bars
- Top 4 posts ranked
- Best time to post section

### Screen 6: Compose Post (compose_screen.dart)
- Platform toggles: Instagram / Twitter / LinkedIn (animated, multi-select)
- Caption text editor
- Toolbar: photo/video/hashtag/emoji/link icons
- Character counter: green→yellow→red (Twitter limit 280, others 2200)
- Media upload area (tap to add photo/video)
- Schedule for later toggle → date+time picker (dark themed)
- Best time suggestion shown
- Publish Now / Schedule Post gradient button + loading spinner
- Success bottom sheet after publish → goes to /home
- Save Draft top-right button

### Screen 7: Settings (settings_screen.dart)
- Profile card: "Sidharth Ganapathi" + avatar (S initial, gradient bg) + email + Free Plan badge + edit button
- Upgrade to Pro gradient banner
- Connected Accounts: Instagram (Connected green), Twitter (Connected green), LinkedIn (Connect), Google Calendar (Connect)
- Notifications toggles: Push Notifications ON, Post Reminders ON, Weekly Reports OFF
- Preferences toggles: Dark Mode ON, Google Calendar Sync OFF (shows "coming soon" when toggled)
- General section: Manage Clients, Privacy & Security, Help & Support, Rate the App, Terms & Privacy
- Log Out button (red) → confirmation dialog → goes to /login
- Bottom nav: Home | Schedule | [FAB] | Analytics | Settings(active)

## ============================================================
## ALL SOURCE CODE FILES
## ============================================================

### FILE: pubspec.yaml
```yaml
name: social_pulse
description: A social media manager app.
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '^3.11.0'

dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
```

### FILE: lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'schedule_screen.dart';
import 'analytics_screen.dart';
import 'compose_screen.dart';
import 'settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MaterialApp(
      title: 'SocialPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0C10),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6EE7B7),
          secondary: Color(0xFF818CF8),
          surface: Color(0xFF12151C),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
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

// Temporary placeholder — we will replace this with real Login screen next
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF6EE7B7),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
```

### FILE: lib/splash_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _taglineController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // Text animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );

    // Tagline animation
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeIn),
    );

    // Start animations in sequence
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 400));
    _taglineController.forward();

    // Navigate to Login after 3.5 seconds
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: Stack(
        children: [
          // Background gradient circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6EE7B7).withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF818CF8).withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo icon
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoOpacity.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF6EE7B7),
                          Color(0xFF818CF8),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6EE7B7).withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.hub_rounded,
                      color: Color(0xFF0A0C10),
                      size: 52,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // App name
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacity.value,
                      child: SlideTransition(
                        position: _textSlide,
                        child: child,
                      ),
                    );
                  },
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFE2E8F0), Color(0xFF6EE7B7)],
                    ).createShader(bounds),
                    child: Text(
                      'SocialPulse',
                      style: GoogleFonts.syne(
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Tagline
                AnimatedBuilder(
                  animation: _taglineController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _taglineOpacity.value,
                      child: child,
                    );
                  },
                  child: Text(
                    'Manage. Schedule. Grow.',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom version text
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _taglineController,
              builder: (context, child) {
                return Opacity(
                  opacity: _taglineOpacity.value,
                  child: child,
                );
              },
              child: Text(
                'v1.0.0',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: const Color(0xFF2D3748),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### FILE: lib/login_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields',
            style: GoogleFonts.dmSans(),
          ),
          backgroundColor: const Color(0xFF1A1F2B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate login
    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: Stack(
        children: [
          // Background glows
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6EE7B7).withOpacity(0.07),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF818CF8).withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),

                      // Logo + app name
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF6EE7B7),
                                  Color(0xFF818CF8),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.hub_rounded,
                              color: Color(0xFF0A0C10),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'SocialPulse',
                            style: GoogleFonts.syne(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFE2E8F0),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 48),

                      // Welcome text
                      Text(
                        'Welcome\nback 👋',
                        style: GoogleFonts.syne(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFE2E8F0),
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Sign in to manage your social media',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: const Color(0xFF64748B),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email field
                      _buildLabel('Email Address'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _emailController,
                        hint: 'you@example.com',
                        icon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 20),

                      // Password field
                      _buildLabel('Password'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _passwordController,
                        hint: '••••••••',
                        icon: Icons.lock_outline_rounded,
                        obscure: _obscurePassword,
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFF64748B),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(
                                () => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: const Color(0xFF6EE7B7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Login button
                      GestureDetector(
                        onTap: _isLoading ? null : _handleLogin,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6EE7B7),
                                Color(0xFF818CF8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6EE7B7).withOpacity(0.25),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: _isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF0A0C10),
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    'Sign In',
                                    style: GoogleFonts.syne(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0A0C10),
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                              child: Divider(color: const Color(0xFF252B38))),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'or continue with',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(color: const Color(0xFF252B38))),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Google sign in button
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xFF1A1F2B),
                            border: Border.all(
                              color: const Color(0xFF252B38),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('🔵', style: TextStyle(fontSize: 20)),
                              const SizedBox(width: 10),
                              Text(
                                'Continue with Google',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Sign up link
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: const Color(0xFF64748B),
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: const Color(0xFF6EE7B7),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.syne(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF94A3B8),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: GoogleFonts.dmSans(
          color: const Color(0xFFE2E8F0),
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.dmSans(
            color: const Color(0xFF3D4A5C),
            fontSize: 14,
          ),
          prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 20),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
```

### FILE: lib/home_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ── TOP BAR ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning,',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          'Sidharth 👋',
                          style: GoogleFonts.syne(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _iconBtn(Icons.notifications_outlined),
                        const SizedBox(width: 10),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'S',
                              style: GoogleFonts.syne(
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0A0C10),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── CLIENT SELECTOR ──
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12151C),
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: const Color(0xFF252B38)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6EE7B7).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.business_rounded,
                            color: Color(0xFF6EE7B7), size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Active Client',
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            Text(
                              'Nike India',
                              style: GoogleFonts.syne(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF64748B)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── STATS GRID ──
                Row(
                  children: [
                    Expanded(
                      child: _statCard(
                          'Total Reach', '48.2K', '↑ 12.4%',
                          const Color(0xFF6EE7B7)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                          'Engagement', '6.8%', '↑ 3.1%',
                          const Color(0xFF818CF8)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _statCard(
                          'Posts Today', '4', '2 scheduled',
                          const Color(0xFFF472B6)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(
                          'New Followers', '+234', '↑ 8.7%',
                          const Color(0xFFFCD34D)),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── PLATFORMS ──
                _sectionHeader('Connected Platforms', 'Manage'),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _platformChip('📸', 'Instagram', '22.1K'),
                      const SizedBox(width: 10),
                      _platformChip('🐦', 'Twitter/X', '15.3K'),
                      const SizedBox(width: 10),
                      _platformChip('💼', 'LinkedIn', '10.8K'),
                      const SizedBox(width: 10),
                      _addPlatformChip(),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ── WEEKLY ACTIVITY ──
                _sectionHeader('Weekly Activity', ''),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12151C),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF252B38)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _bar(0.6, const Color(0xFF818CF8)),
                          _bar(0.8, const Color(0xFF818CF8)),
                          _bar(0.45, const Color(0xFF818CF8)),
                          _bar(1.0, const Color(0xFF6EE7B7)),
                          _bar(0.7, const Color(0xFF818CF8)),
                          _bar(0.55, const Color(0xFF818CF8)),
                          _bar(0.4, const Color(0xFF818CF8)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                            .map((d) => Expanded(
                                  child: Center(
                                    child: Text(
                                      d,
                                      style: GoogleFonts.syne(
                                        fontSize: 10,
                                        color: const Color(0xFF64748B),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ── UPCOMING POSTS ──
                _sectionHeader('Upcoming Posts', 'See all'),
                const SizedBox(height: 12),
                _upcomingPost('📸', 'Instagram', '3:00 PM Today',
                    'New product launch reel 🚀', const Color(0xFFFCD34D)),
                const SizedBox(height: 10),
                _upcomingPost('💼', 'LinkedIn', '7:00 PM Today',
                    'Behind the scenes story...', const Color(0xFF818CF8)),
                const SizedBox(height: 10),
                _upcomingPost('🐦', 'Twitter/X', 'Tomorrow 9:00 AM',
                    'Industry trends thread 🧵', const Color(0xFF6EE7B7)),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),

      // ── BOTTOM NAV ──
      bottomNavigationBar: _buildBottomNav(),

      // ── FAB ──
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/compose'),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6EE7B7).withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded,
              color: Color(0xFF0A0C10), size: 28),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
    );
  }

  // ── WIDGETS ──

  Widget _iconBtn(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Icon(icon, color: const Color(0xFF64748B), size: 20),
    );
  }

  Widget _statCard(
      String label, String value, String change, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.syne(
              fontSize: 10,
              color: const Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.syne(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: GoogleFonts.dmSans(
              fontSize: 10,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _platformChip(String icon, String name, String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.syne(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              Text(
                count,
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  color: const Color(0xFF6EE7B7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addPlatformChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: const Color(0xFF6EE7B7).withOpacity(0.3),
            style: BorderStyle.solid),
      ),
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline_rounded,
              color: Color(0xFF6EE7B7), size: 18),
          const SizedBox(width: 6),
          Text(
            'Add',
            style: GoogleFonts.syne(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF6EE7B7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(double heightFactor, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          height: 60 * heightFactor,
          decoration: BoxDecoration(
            color: color.withOpacity(heightFactor == 1.0 ? 1.0 : 0.35),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.syne(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE2E8F0),
          ),
        ),
        if (action.isNotEmpty)
          Text(
            action,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: const Color(0xFF6EE7B7),
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _upcomingPost(String icon, String platform, String time,
      String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(icon,
                    style: const TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      platform,
                      style: GoogleFonts.syne(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  text,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: const Color(0xFFE2E8F0),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              color: Color(0xFF64748B), size: 20),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF12151C),
        border: Border(top: BorderSide(color: Color(0xFF252B38))),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', 0),
              _navItem(Icons.calendar_month_rounded, 'Schedule', 1),
              const SizedBox(width: 48),
              _navItem(Icons.bar_chart_rounded, 'Analytics', 3),
              _navItem(Icons.settings_rounded, 'Settings', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
        if (index == 1) {
          Navigator.pushNamed(context, '/schedule');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/analytics');
        } else if (index == 4) {
          Navigator.pushNamed(context, '/settings');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive
                ? const Color(0xFF6EE7B7)
                : const Color(0xFF64748B),
            size: 22,
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.syne(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isActive
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
```

### FILE: lib/schedule_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin {
  int _selectedDay = 4; // Friday selected by default
  String _selectedView = 'Built-in'; // Calendar mode toggle

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _days = [
    {'name': 'MON', 'num': 4},
    {'name': 'TUE', 'num': 5},
    {'name': 'WED', 'num': 6},
    {'name': 'THU', 'num': 7},
    {'name': 'FRI', 'num': 8},
    {'name': 'SAT', 'num': 9},
    {'name': 'SUN', 'num': 10},
  ];

  final List<Map<String, dynamic>> _posts = [
    {
      'time': '9:00 AM',
      'platform': 'Instagram',
      'icon': '📸',
      'text': 'New product launch post with visuals',
      'status': 'published',
      'color': Color(0xFF6EE7B7),
    },
    {
      'time': '12:30 PM',
      'platform': 'Twitter/X',
      'icon': '🐦',
      'text': 'Thread about industry trends this week',
      'status': 'published',
      'color': Color(0xFF818CF8),
    },
    {
      'time': '3:00 PM',
      'platform': 'LinkedIn',
      'icon': '💼',
      'text': 'Case study: How we grew 200% in Q1',
      'status': 'scheduled',
      'color': Color(0xFFFCD34D),
    },
    {
      'time': '7:00 PM',
      'platform': 'Instagram',
      'icon': '📸',
      'text': 'Behind the scenes story reel',
      'status': 'draft',
      'color': Color(0xFF64748B),
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'published':
        return const Color(0xFF6EE7B7);
      case 'scheduled':
        return const Color(0xFFFCD34D);
      default:
        return const Color(0xFF64748B);
    }
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'published':
        return 'Published';
      case 'scheduled':
        return 'Scheduled';
      default:
        return 'Draft';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── TOP BAR ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Schedule',
                      style: GoogleFonts.syne(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showAddPostSheet(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
                          ),
                        ),
                        child: const Icon(Icons.add_rounded,
                            color: Color(0xFF0A0C10), size: 22),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── CALENDAR MODE TOGGLE ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12151C),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF252B38)),
                  ),
                  child: Row(
                    children: [
                      _toggleBtn('Built-in'),
                      _toggleBtn('Google Calendar'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── WEEK STRIP ──
              SizedBox(
                height: 72,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _days.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final day = _days[index];
                    final isSelected = _selectedDay == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDay = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 46,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF6EE7B7)
                              : const Color(0xFF12151C),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6EE7B7)
                                : const Color(0xFF252B38),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day['name'],
                              style: GoogleFonts.syne(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? const Color(0xFF0A0C10)
                                    : const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${day['num']}',
                              style: GoogleFonts.syne(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: isSelected
                                    ? const Color(0xFF0A0C10)
                                    : const Color(0xFFE2E8F0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ── DATE HEADER ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Friday, March 8',
                      style: GoogleFonts.syne(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    Text(
                      '${_posts.length} posts',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: const Color(0xFF6EE7B7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ── STATUS LEGEND ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _legendDot(const Color(0xFF6EE7B7), 'Published'),
                    const SizedBox(width: 16),
                    _legendDot(const Color(0xFFFCD34D), 'Scheduled'),
                    const SizedBox(width: 16),
                    _legendDot(const Color(0xFF64748B), 'Draft'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── POSTS LIST ──
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _posts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return _postItem(post);
                  },
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // ── BOTTOM NAV ──
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: GestureDetector(
        onTap: () => _showAddPostSheet(context),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6EE7B7).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded,
              color: Color(0xFF0A0C10), size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // ── TOGGLE BUTTON ──
  Widget _toggleBtn(String label) {
    final isSelected = _selectedView == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedView = label);
          if (label == 'Google Calendar') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '📅 Google Calendar integration coming soon!',
                  style: GoogleFonts.dmSans(),
                ),
                backgroundColor: const Color(0xFF1A1F2B),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6EE7B7).withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: isSelected
                ? Border.all(color: const Color(0xFF6EE7B7).withOpacity(0.4))
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.syne(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? const Color(0xFF6EE7B7)
                    : const Color(0xFF64748B),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── POST ITEM ──
  Widget _postItem(Map<String, dynamic> post) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Row(
        children: [
          // Time column
          SizedBox(
            width: 52,
            child: Text(
              post['time'],
              style: GoogleFonts.syne(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Divider line
          Container(
            width: 1,
            height: 48,
            color: const Color(0xFF252B38),
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),

          // Platform icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (post['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(post['icon'],
                  style: const TextStyle(fontSize: 20)),
            ),
          ),

          const SizedBox(width: 10),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post['platform'],
                      style: GoogleFonts.syne(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: post['color'],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: _statusColor(post['status']).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _statusLabel(post['status']),
                        style: GoogleFonts.syne(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: _statusColor(post['status']),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  post['text'],
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: const Color(0xFFE2E8F0),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // More options
          GestureDetector(
            onTap: () => _showPostOptions(context, post),
            child: const Icon(Icons.more_vert_rounded,
                color: Color(0xFF64748B), size: 20),
          ),
        ],
      ),
    );
  }

  // ── LEGEND DOT ──
  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 10,
            color: const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  // ── ADD POST BOTTOM SHEET ──
  void _showAddPostSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12151C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF252B38),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Create New Post',
                style: GoogleFonts.syne(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              const SizedBox(height: 20),
              _sheetOption('📸', 'Instagram Post', 'Photo, Video, Reel',
                  const Color(0xFF6EE7B7)),
              const SizedBox(height: 10),
              _sheetOption('🐦', 'Twitter/X Post', 'Tweet or Thread',
                  const Color(0xFF818CF8)),
              const SizedBox(height: 10),
              _sheetOption('💼', 'LinkedIn Post', 'Article or Update',
                  const Color(0xFFFCD34D)),
              const SizedBox(height: 10),
              _sheetOption('📱', 'All Platforms', 'Post to all at once',
                  const Color(0xFFF472B6)),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _sheetOption(
      String icon, String title, String sub, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/compose');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F2B),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF252B38)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child:
                      Text(icon, style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.syne(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 14),
          ],
        ),
      ),
    );
  }

  // ── POST OPTIONS SHEET ──
  void _showPostOptions(
      BuildContext context, Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12151C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF252B38),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _optionTile(Icons.edit_outlined, 'Edit Post',
                  const Color(0xFF818CF8)),
              _optionTile(Icons.schedule_outlined, 'Reschedule',
                  const Color(0xFFFCD34D)),
              _optionTile(Icons.copy_outlined, 'Duplicate',
                  const Color(0xFF6EE7B7)),
              _optionTile(Icons.delete_outline_rounded, 'Delete',
                  const Color(0xFFF87171)),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _optionTile(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F2B),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF252B38)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 14),
            Text(
              label,
              style: GoogleFonts.syne(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFE2E8F0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── BOTTOM NAV ──
  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF12151C),
        border: Border(top: BorderSide(color: Color(0xFF252B38))),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', false),
              _navItem(Icons.calendar_month_rounded, 'Schedule', true),
              const SizedBox(width: 48),
              _navItem(Icons.bar_chart_rounded, 'Analytics', false),
              _navItem(Icons.settings_rounded, 'Settings', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (!isActive) Navigator.pushReplacementNamed(context, '/home');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isActive
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF64748B),
              size: 22),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.syne(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isActive
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
```

### FILE: lib/analytics_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with TickerProviderStateMixin {
  String _selectedRange = '7 Days';
  String _selectedPlatform = 'All';

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<String> _ranges = ['7 Days', '30 Days', '90 Days'];
  final List<String> _platforms = ['All', '📸 Instagram', '🐦 Twitter', '💼 LinkedIn'];

  final List<Map<String, dynamic>> _topPosts = [
    {
      'rank': '#1',
      'platform': '📸 Instagram',
      'text': 'Product launch reel',
      'likes': '4.2K',
      'color': Color(0xFF6EE7B7),
    },
    {
      'rank': '#2',
      'platform': '💼 LinkedIn',
      'text': 'Case study thread',
      'likes': '2.8K',
      'color': Color(0xFF818CF8),
    },
    {
      'rank': '#3',
      'platform': '🐦 Twitter/X',
      'text': 'Industry hot take',
      'likes': '1.9K',
      'color': Color(0xFFF472B6),
    },
    {
      'rank': '#4',
      'platform': '📸 Instagram',
      'text': 'Behind the scenes reel',
      'likes': '1.4K',
      'color': Color(0xFFFCD34D),
    },
  ];

  final List<double> _sparkData = [0.4, 0.55, 0.45, 0.7, 0.6, 0.85, 0.75, 1.0];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            children: [
              // ── TOP BAR ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Analytics',
                      style: GoogleFonts.syne(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF12151C),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF252B38)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              color: Color(0xFF6EE7B7), size: 14),
                          const SizedBox(width: 6),
                          Text(
                            _selectedRange,
                            style: GoogleFonts.syne(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF6EE7B7),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF6EE7B7), size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── DATE RANGE PILLS ──
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _ranges.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final range = _ranges[index];
                    final isSelected = _selectedRange == range;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedRange = range),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF6EE7B7).withOpacity(0.15)
                              : const Color(0xFF12151C),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6EE7B7)
                                : const Color(0xFF252B38),
                          ),
                        ),
                        child: Text(
                          range,
                          style: GoogleFonts.syne(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? const Color(0xFF6EE7B7)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ── PLATFORM FILTER ──
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _platforms.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final platform = _platforms[index];
                    final isSelected = _selectedPlatform == platform;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedPlatform = platform),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF818CF8).withOpacity(0.15)
                              : const Color(0xFF12151C),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF818CF8)
                                : const Color(0xFF252B38),
                          ),
                        ),
                        child: Text(
                          platform,
                          style: GoogleFonts.syne(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? const Color(0xFF818CF8)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // ── SCROLLABLE CONTENT ──
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // ── HERO IMPRESSIONS CARD ──
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF6EE7B7).withOpacity(0.08),
                              const Color(0xFF818CF8).withOpacity(0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF252B38)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOTAL IMPRESSIONS',
                              style: GoogleFonts.syne(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  const LinearGradient(
                                colors: [
                                  Color(0xFF6EE7B7),
                                  Color(0xFF818CF8)
                                ],
                              ).createShader(bounds),
                              child: Text(
                                '312,840',
                                style: GoogleFonts.syne(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6EE7B7)
                                        .withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    '↑ 24.6%',
                                    style: GoogleFonts.syne(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF6EE7B7),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'vs last period · All Platforms',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Sparkline chart
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: _sparkData.map((h) {
                                final isLast =
                                    _sparkData.indexOf(h) == _sparkData.length - 1;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: Container(
                                      height: 40 * h,
                                      decoration: BoxDecoration(
                                        color: isLast
                                            ? const Color(0xFF6EE7B7)
                                            : const Color(0xFF6EE7B7)
                                                .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── METRICS GRID ──
                      GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.0,
                        children: [
                          _metricChip('❤️', '14.2K', 'Likes',
                              const Color(0xFF6EE7B7)),
                          _metricChip('💬', '3.8K', 'Comments',
                              const Color(0xFF818CF8)),
                          _metricChip('🔁', '7.1K', 'Shares',
                              const Color(0xFFF472B6)),
                          _metricChip('🔗', '892', 'Link Clicks',
                              const Color(0xFFFCD34D)),
                          _metricChip('👁️', '48K', 'Profile Views',
                              const Color(0xFF6EE7B7)),
                          _metricChip('👥', '+234', 'Followers',
                              const Color(0xFF818CF8)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── PLATFORM BREAKDOWN ──
                      _sectionHeader('Platform Breakdown'),
                      const SizedBox(height: 12),
                      _platformBar('📸 Instagram', 0.72, '22.1K',
                          const Color(0xFF6EE7B7)),
                      const SizedBox(height: 8),
                      _platformBar('🐦 Twitter/X', 0.48, '15.3K',
                          const Color(0xFF818CF8)),
                      const SizedBox(height: 8),
                      _platformBar('💼 LinkedIn', 0.34, '10.8K',
                          const Color(0xFFF472B6)),

                      const SizedBox(height: 20),

                      // ── TOP POSTS ──
                      _sectionHeader('Top Performing Posts'),
                      const SizedBox(height: 12),
                      ..._topPosts.map((post) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _topPostItem(post),
                          )),

                      const SizedBox(height: 20),

                      // ── BEST TIME TO POST ──
                      _sectionHeader('Best Time to Post'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF12151C),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF252B38)),
                        ),
                        child: Column(
                          children: [
                            _bestTimeRow('📸 Instagram', 'Friday 7:00 PM',
                                const Color(0xFF6EE7B7)),
                            const Divider(color: Color(0xFF252B38), height: 20),
                            _bestTimeRow('🐦 Twitter/X', 'Wednesday 12:00 PM',
                                const Color(0xFF818CF8)),
                            const Divider(color: Color(0xFF252B38), height: 20),
                            _bestTimeRow('💼 LinkedIn', 'Tuesday 9:00 AM',
                                const Color(0xFFF472B6)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6EE7B7).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded,
              color: Color(0xFF0A0C10), size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // ── WIDGETS ──

  Widget _sectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.syne(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: const Color(0xFFE2E8F0),
        ),
      ),
    );
  }

  Widget _metricChip(
      String icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.syne(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 9,
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _platformBar(
      String name, double value, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.syne(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
              Text(
                count,
                style: GoogleFonts.syne(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: const Color(0xFF252B38),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _topPostItem(Map<String, dynamic> post) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Row(
        children: [
          Text(
            post['rank'],
            style: GoogleFonts.syne(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: post['color'],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['platform'],
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Text(
                  post['text'],
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Text('❤️', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(
                post['likes'],
                style: GoogleFonts.syne(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: post['color'],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bestTimeRow(String platform, String time, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          platform,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            color: const Color(0xFFE2E8F0),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            time,
            style: GoogleFonts.syne(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF12151C),
        border: Border(top: BorderSide(color: Color(0xFF252B38))),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', false),
              _navItem(Icons.calendar_month_rounded, 'Schedule', false),
              const SizedBox(width: 48),
              _navItem(Icons.bar_chart_rounded, 'Analytics', true),
              _navItem(Icons.settings_rounded, 'Settings', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (label == 'Schedule') {
          Navigator.pushReplacementNamed(context, '/schedule');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isActive
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF64748B),
              size: 22),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.syne(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isActive
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
```

### FILE: lib/compose_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen>
    with TickerProviderStateMixin {
  final _textController = TextEditingController();
  bool _instagramSelected = true;
  bool _twitterSelected = true;
  bool _linkedinSelected = false;
  bool _scheduleForLater = false;
  bool _isPublishing = false;

  DateTime _selectedDate = DateTime.now().add(const Duration(hours: 2));

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int get _charCount => _textController.text.length;
  int get _charLimit => _twitterSelected ? 280 : 2200;
  bool get _isOverLimit => _charCount > _charLimit;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.forward();
    _textController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handlePublish() async {
    if (_textController.text.isEmpty) {
      _showSnack('✏️ Please write something first!');
      return;
    }
    if (!_instagramSelected && !_twitterSelected && !_linkedinSelected) {
      _showSnack('📱 Please select at least one platform!');
      return;
    }
    setState(() => _isPublishing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isPublishing = false);
    if (mounted) {
      _showSuccessSheet();
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.dmSans()),
        backgroundColor: const Color(0xFF1A1F2B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccessSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12151C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
                ),
              ),
              child: const Icon(Icons.check_rounded,
                  color: Color(0xFF0A0C10), size: 36),
            ),
            const SizedBox(height: 16),
            Text(
              _scheduleForLater ? 'Post Scheduled!' : 'Post Published!',
              style: GoogleFonts.syne(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: const Color(0xFFE2E8F0),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _scheduleForLater
                  ? 'Your post has been scheduled successfully.'
                  : 'Your post is live on selected platforms.',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: const Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Back to Home',
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0A0C10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6EE7B7),
              surface: Color(0xFF1A1F2B),
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF6EE7B7),
                surface: Color(0xFF1A1F2B),
              ),
            ),
            child: child!,
          );
        },
      );
      if (time != null) {
        setState(() {
          _selectedDate = DateTime(
              date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '${months[dt.month - 1]} ${dt.day}, $hour:$min $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            children: [
              // ── TOP BAR ──
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF12151C),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF252B38)),
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Color(0xFF64748B), size: 20),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'New Post',
                      style: GoogleFonts.syne(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    const Spacer(),
                    // Draft save button
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF12151C),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF252B38)),
                      ),
                      child: Text(
                        'Save Draft',
                        style: GoogleFonts.syne(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── PLATFORM SELECTOR ──
                      Text(
                        'POST TO',
                        style: GoogleFonts.syne(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _platformToggle('📸', 'Instagram',
                              _instagramSelected, const Color(0xFF6EE7B7), () {
                            setState(() =>
                                _instagramSelected = !_instagramSelected);
                          }),
                          const SizedBox(width: 10),
                          _platformToggle('🐦', 'Twitter',
                              _twitterSelected, const Color(0xFF818CF8), () {
                            setState(
                                () => _twitterSelected = !_twitterSelected);
                          }),
                          const SizedBox(width: 10),
                          _platformToggle('💼', 'LinkedIn',
                              _linkedinSelected, const Color(0xFFF472B6), () {
                            setState(
                                () => _linkedinSelected = !_linkedinSelected);
                          }),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── TEXT EDITOR ──
                      Text(
                        'CAPTION',
                        style: GoogleFonts.syne(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF12151C),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _isOverLimit
                                ? const Color(0xFFF87171)
                                : const Color(0xFF252B38),
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _textController,
                              maxLines: 6,
                              style: GoogleFonts.dmSans(
                                color: const Color(0xFFE2E8F0),
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    'What do you want to share today? ✨',
                                hintStyle: GoogleFonts.dmSans(
                                  color: const Color(0xFF3D4A5C),
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                            // Toolbar
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Color(0xFF252B38)),
                                ),
                              ),
                              child: Row(
                                children: [
                                  _toolBtn('📷', () {}),
                                  _toolBtn('🎥', () {}),
                                  _toolBtn('#️⃣', () {
                                    _textController.text +=
                                        ' #socialmedia #marketing';
                                  }),
                                  _toolBtn('😊', () {}),
                                  _toolBtn('🔗', () {}),
                                  const Spacer(),
                                  Text(
                                    '$_charCount/$_charLimit',
                                    style: GoogleFonts.syne(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: _isOverLimit
                                          ? const Color(0xFFF87171)
                                          : _charCount > _charLimit * 0.8
                                              ? const Color(0xFFFCD34D)
                                              : const Color(0xFF6EE7B7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── MEDIA UPLOAD ──
                      Text(
                        'MEDIA',
                        style: GoogleFonts.syne(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => _showSnack('📷 Media picker coming soon!'),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF12151C),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF252B38),
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add_photo_alternate_outlined,
                                  color: Color(0xFF64748B), size: 28),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to add image or video',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── SCHEDULE TOGGLE ──
                      Text(
                        'PUBLISH TIME',
                        style: GoogleFonts.syne(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF12151C),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF252B38)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.schedule_outlined,
                                        color: Color(0xFF6EE7B7), size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Schedule for later',
                                      style: GoogleFonts.syne(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFE2E8F0),
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: _scheduleForLater,
                                  onChanged: (val) =>
                                      setState(() => _scheduleForLater = val),
                                  activeColor: const Color(0xFF6EE7B7),
                                  activeTrackColor: const Color(0xFF6EE7B7)
                                      .withOpacity(0.3),
                                ),
                              ],
                            ),
                            if (_scheduleForLater) ...[
                              const Divider(
                                  color: Color(0xFF252B38), height: 20),
                              GestureDetector(
                                onTap: _pickDateTime,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '📅 ${_formatDate(_selectedDate)}',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        color: const Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    Text(
                                      'Change →',
                                      style: GoogleFonts.syne(
                                        fontSize: 11,
                                        color: const Color(0xFF6EE7B7),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6EE7B7)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '💡 Best time for Instagram: Friday 7:00 PM',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 11,
                                    color: const Color(0xFF6EE7B7),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── PUBLISH BUTTON ──
                      GestureDetector(
                        onTap: _isPublishing ? null : _handlePublish,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF6EE7B7),
                                Color(0xFF818CF8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6EE7B7).withOpacity(0.25),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Center(
                            child: _isPublishing
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF0A0C10),
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _scheduleForLater
                                            ? Icons.schedule_rounded
                                            : Icons.send_rounded,
                                        color: const Color(0xFF0A0C10),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _scheduleForLater
                                            ? 'Schedule Post'
                                            : 'Publish Now',
                                        style: GoogleFonts.syne(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color: const Color(0xFF0A0C10),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── WIDGETS ──

  Widget _platformToggle(String icon, String name, bool isSelected,
      Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.12) : const Color(0xFF12151C),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? color : const Color(0xFF252B38),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 4),
              Text(
                name,
                style: GoogleFonts.syne(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? color : const Color(0xFF64748B),
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolBtn(String icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F2B),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(icon, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
```

### FILE: lib/settings_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  bool _pushNotifications = true;
  bool _postReminders = true;
  bool _analyticsReports = false;
  bool _darkMode = true;
  bool _googleCalendarSync = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.dmSans()),
        backgroundColor: const Color(0xFF1A1F2B),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F2B),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Log Out',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w800,
            color: const Color(0xFFE2E8F0),
          ),
        ),
        content: Text(
          'Are you sure you want to log out of SocialPulse?',
          style: GoogleFonts.dmSans(
            color: const Color(0xFF64748B),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.syne(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Log Out',
              style: GoogleFonts.syne(
                color: const Color(0xFFF87171),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ── TOP BAR ──
                Text(
                  'Settings',
                  style: GoogleFonts.syne(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),

                const SizedBox(height: 24),

                // ── PROFILE CARD ──
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6EE7B7).withOpacity(0.08),
                        const Color(0xFF818CF8).withOpacity(0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF252B38)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'S',
                            style: GoogleFonts.syne(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0A0C10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sidharth Ganapathi',
                              style: GoogleFonts.syne(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'sidharth@socialpulse.app',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6EE7B7).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Free Plan',
                                style: GoogleFonts.syne(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF6EE7B7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showSnack('✏️ Edit profile coming soon!'),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFF12151C),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: const Color(0xFF252B38)),
                          ),
                          child: const Icon(Icons.edit_outlined,
                              color: Color(0xFF64748B), size: 16),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── UPGRADE BANNER ──
                GestureDetector(
                  onTap: () => _showSnack('🚀 Pro plan coming soon!'),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF818CF8), Color(0xFF6EE7B7)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Text('⚡', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upgrade to Pro',
                                style: GoogleFonts.syne(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0A0C10),
                                ),
                              ),
                              Text(
                                'Unlimited posts · 10 clients · AI suggestions',
                                style: GoogleFonts.dmSans(
                                  fontSize: 11,
                                  color:
                                      const Color(0xFF0A0C10).withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0C10).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Upgrade →',
                            style: GoogleFonts.syne(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0A0C10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── CONNECTED ACCOUNTS ──
                _sectionTitle('Connected Accounts'),
                const SizedBox(height: 12),
                _accountTile('📸', 'Instagram', '@sidharth_social',
                    const Color(0xFF6EE7B7), true),
                const SizedBox(height: 8),
                _accountTile('🐦', 'Twitter/X', '@sidharth_x',
                    const Color(0xFF818CF8), true),
                const SizedBox(height: 8),
                _accountTile('💼', 'LinkedIn', 'Not connected',
                    const Color(0xFFF472B6), false),
                const SizedBox(height: 8),
                _accountTile('📅', 'Google Calendar', 'Not connected',
                    const Color(0xFFFCD34D), false),

                const SizedBox(height: 24),

                // ── NOTIFICATIONS ──
                _sectionTitle('Notifications'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF12151C),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF252B38)),
                  ),
                  child: Column(
                    children: [
                      _toggleTile(
                        '🔔',
                        'Push Notifications',
                        'Get notified about post activity',
                        _pushNotifications,
                        (val) =>
                            setState(() => _pushNotifications = val),
                      ),
                      _divider(),
                      _toggleTile(
                        '⏰',
                        'Post Reminders',
                        'Remind me before scheduled posts',
                        _postReminders,
                        (val) => setState(() => _postReminders = val),
                      ),
                      _divider(),
                      _toggleTile(
                        '📊',
                        'Weekly Reports',
                        'Receive analytics summary every week',
                        _analyticsReports,
                        (val) =>
                            setState(() => _analyticsReports = val),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── PREFERENCES ──
                _sectionTitle('Preferences'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF12151C),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF252B38)),
                  ),
                  child: Column(
                    children: [
                      _toggleTile(
                        '🌙',
                        'Dark Mode',
                        'Always use dark theme',
                        _darkMode,
                        (val) => setState(() => _darkMode = val),
                      ),
                      _divider(),
                      _toggleTile(
                        '📅',
                        'Google Calendar Sync',
                        'Sync scheduled posts to Google Calendar',
                        _googleCalendarSync,
                        (val) {
                          setState(() => _googleCalendarSync = val);
                          if (val) {
                            _showSnack(
                                '📅 Google Calendar integration coming soon!');
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── GENERAL ──
                _sectionTitle('General'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF12151C),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF252B38)),
                  ),
                  child: Column(
                    children: [
                      _arrowTile('🏢', 'Manage Clients', const Color(0xFF6EE7B7)),
                      _divider(),
                      _arrowTile('🔒', 'Privacy & Security', const Color(0xFF818CF8)),
                      _divider(),
                      _arrowTile('❓', 'Help & Support', const Color(0xFFFCD34D)),
                      _divider(),
                      _arrowTile('⭐', 'Rate the App', const Color(0xFFF472B6)),
                      _divider(),
                      _arrowTile('📄', 'Terms & Privacy Policy', const Color(0xFF64748B)),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── LOGOUT ──
                GestureDetector(
                  onTap: _showLogoutDialog,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF87171).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFF87171).withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded,
                            color: Color(0xFFF87171), size: 18),
                        const SizedBox(width: 10),
                        Text(
                          'Log Out',
                          style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF87171),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── VERSION ──
                Center(
                  child: Text(
                    'SocialPulse v1.0.0 · Made with ❤️',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      color: const Color(0xFF2D3748),
                    ),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/compose'),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF6EE7B7), Color(0xFF818CF8)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6EE7B7).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded,
              color: Color(0xFF0A0C10), size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // ── WIDGETS ──

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.syne(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF64748B),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _accountTile(String icon, String name, String sub,
      Color color, bool connected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(icon, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.syne(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: connected
                        ? color
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _showSnack(
                connected ? '🔌 Disconnect coming soon!' : '🔗 Connect coming soon!'),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: connected
                    ? const Color(0xFF6EE7B7).withOpacity(0.1)
                    : const Color(0xFF252B38),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: connected
                      ? const Color(0xFF6EE7B7).withOpacity(0.3)
                      : const Color(0xFF252B38),
                ),
              ),
              child: Text(
                connected ? 'Connected' : 'Connect',
                style: GoogleFonts.syne(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: connected
                      ? const Color(0xFF6EE7B7)
                      : const Color(0xFF64748B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleTile(String icon, String title, String sub,
      bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.syne(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFE2E8F0),
                  ),
                ),
                Text(
                  sub,
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6EE7B7),
            activeTrackColor: const Color(0xFF6EE7B7).withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _arrowTile(String icon, String title, Color color) {
    return GestureDetector(
      onTap: () => _showSnack('$title coming soon!'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.syne(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFE2E8F0),
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: color, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
        color: Color(0xFF252B38), height: 1, indent: 14, endIndent: 14);
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF12151C),
        border: Border(top: BorderSide(color: Color(0xFF252B38))),
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', false),
              _navItem(Icons.calendar_month_rounded, 'Schedule', false),
              const SizedBox(width: 48),
              _navItem(Icons.bar_chart_rounded, 'Analytics', false),
              _navItem(Icons.settings_rounded, 'Settings', true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (label == 'Schedule') {
          Navigator.pushReplacementNamed(context, '/schedule');
        } else if (label == 'Analytics') {
          Navigator.pushReplacementNamed(context, '/analytics');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isActive
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF64748B),
              size: 22),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.syne(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isActive
                  ? const Color(0xFF6EE7B7)
                  : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
```
