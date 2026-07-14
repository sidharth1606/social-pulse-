import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_helper.dart';
import 'package:googleapis/calendar/v3.dart' as gCal;

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with TickerProviderStateMixin {
  int _selectedDay = 4; // Friday selected by default
  String _selectedView = 'Built-in';
  
  final CalendarHelper _calendarHelper = CalendarHelper();
  List<gCal.Event> _googleEvents = [];
  bool _isLoadingEvents = false;

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
      'color': const Color(0xFF6EE7B7),
    },
    {
      'time': '12:30 PM',
      'platform': 'Twitter/X',
      'icon': '🐦',
      'text': 'Thread about industry trends this week',
      'status': 'published',
      'color': const Color(0xFF818CF8),
    },
    {
      'time': '3:00 PM',
      'platform': 'LinkedIn',
      'icon': '💼',
      'text': 'Case study: How we grew 200% in Q1',
      'status': 'scheduled',
      'color': const Color(0xFFFCD34D),
    },
    {
      'time': '7:00 PM',
      'platform': 'Instagram',
      'icon': '📸',
      'text': 'Behind the scenes story reel',
      'status': 'draft',
      'color': const Color(0xFF64748B),
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

  Future<void> _fetchGoogleEvents() async {
    setState(() => _isLoadingEvents = true);
    final events = await _calendarHelper.getGoogleCalendarEvents();
    setState(() {
      _googleEvents = events;
      _isLoadingEvents = false;
    });
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
                      _selectedView == 'Built-in' 
                        ? '${_posts.length} posts'
                        : '${_googleEvents.length} events',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: const Color(0xFF6EE7B7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ── STATUS LEGEND (only for built-in) ──
              if (_selectedView == 'Built-in')
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

              // ── POSTS / EVENTS LIST ──
              Expanded(
                child: _isLoadingEvents 
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF6EE7B7)))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _selectedView == 'Built-in' ? _posts.length : _googleEvents.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if (_selectedView == 'Built-in') {
                          return _postItem(_posts[index]);
                        } else {
                          return _googleEventItem(_googleEvents[index]);
                        }
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
            _fetchGoogleEvents();
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

  // ── POST ITEM (BUILT-IN) ──
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
          Container(
            width: 1,
            height: 48,
            color: const Color(0xFF252B38),
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
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
          GestureDetector(
            onTap: () => _showPostOptions(context, post),
            child: const Icon(Icons.more_vert_rounded,
                color: Color(0xFF64748B), size: 20),
          ),
        ],
      ),
    );
  }

  // ── GOOGLE EVENT ITEM ──
  Widget _googleEventItem(gCal.Event event) {
    final startTime = event.start?.dateTime ?? event.start?.date;
    final timeStr = startTime != null ? "${startTime.hour}:${startTime.minute.toString().padLeft(2,'0')}" : "All Day";

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12151C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF252B38)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(
              timeStr,
              style: GoogleFonts.syne(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF818CF8),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 1,
            height: 48,
            color: const Color(0xFF252B38),
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF818CF8).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('📅', style: TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Google Calendar',
                  style: GoogleFonts.syne(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF818CF8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.summary ?? '(No Title)',
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
