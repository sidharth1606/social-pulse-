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
