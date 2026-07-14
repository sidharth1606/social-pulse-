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

  late DateTime _selectedDate;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int get _charCount => _textController.text.length;
  int get _charLimit => _twitterSelected ? 280 : 2200;
  bool get _isOverLimit => _charCount > _charLimit;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().add(const Duration(hours: 2));
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
      isDismissible: false,
      enableDrag: false,
      backgroundColor: const Color(0xFF12151C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
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
                  Navigator.pop(context); // Pop bottom sheet
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
      ),
    );
  }

  Future<void> _pickDateTime() async {
    DateTime now = DateTime.now();
    // Ensure initialDate is not before now (firstDate)
    DateTime initialDate = _selectedDate.isBefore(now) ? now : _selectedDate;

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now.subtract(const Duration(minutes: 5)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6EE7B7),
              surface: Color(0xFF1A1F2B),
              onSurface: Color(0xFFE2E8F0),
            ),
            dialogBackgroundColor: const Color(0xFF12151C),
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
                onSurface: Color(0xFFE2E8F0),
              ),
              dialogBackgroundColor: const Color(0xFF12151C),
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
                    GestureDetector(
                      onTap: () => _showSnack('💾 Draft saved successfully!'),
                      child: Container(
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
                                  _toolBtn('📷', () => _showSnack('📷 Media coming soon!')),
                                  _toolBtn('🎥', () => _showSnack('🎥 Video coming soon!')),
                                  _toolBtn('#️⃣', () {
                                    _textController.text +=
                                        ' #socialmedia #marketing';
                                  }),
                                  _toolBtn('😊', () => _showSnack('😊 Emoji coming soon!')),
                                  _toolBtn('🔗', () => _showSnack('🔗 Link coming soon!')),
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
