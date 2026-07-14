import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  final User? _user = FirebaseAuth.instance.currentUser;

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
    // Get user first name or default
    final String fullName = _user?.displayName ?? 'Social User';
    final String firstName = fullName.split(' ')[0];
    final String initial = firstName.isNotEmpty ? firstName[0].toUpperCase() : 'U';

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
                          '$firstName 👋',
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
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/settings'),
                          child: Container(
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
                                initial,
                                style: GoogleFonts.syne(
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0A0C10),
                                  fontSize: 16,
                                ),
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
