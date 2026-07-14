import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'theme/theme_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  final User? _user = FirebaseAuth.instance.currentUser;
  
  bool _pushNotifications = true;
  bool _postReminders = true;
  bool _analyticsReports = false;
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
    themeManager.addListener(_onThemeChanged);
  }

  void _onThemeChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    themeManager.removeListener(_onThemeChanged);
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
            onPressed: () async {
              Navigator.pop(context);
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                // The StreamBuilder in main.dart will automatically take us to /login
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
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
    // Get user info or defaults
    final String displayName = _user?.displayName ?? 'Social User';
    final String email = _user?.email ?? 'user@socialpulse.app';
    final String initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';

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
                            initial,
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
                              displayName,
                              style: GoogleFonts.syne(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              email,
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
                        'Switch between dark and light theme',
                        themeManager.isDark,
                        (val) => themeManager.setDark(val),
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
