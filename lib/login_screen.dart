import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Scopes for Google Sign In
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar.readonly', // Read Calendar
      'https://www.googleapis.com/auth/calendar.events',   // Manage Events
    ],
  );
  
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isSignUp = false;

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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.dmSans()),
        backgroundColor: const Color(0xFFF87171),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _handleAuth() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_isSignUp) {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'An error occurred');
    } catch (e) {
      _showError('Something went wrong');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      _showError('Google Sign-In failed. Check console for details.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C10),
      body: Stack(
        children: [
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

                      Text(
                        _isSignUp ? 'Create\nAccount ✨' : 'Welcome\nback 👋',
                        style: GoogleFonts.syne(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFE2E8F0),
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _isSignUp ? 'Join SocialPulse to grow your brand' : 'Sign in to manage your social media',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: const Color(0xFF64748B),
                        ),
                      ),

                      const SizedBox(height: 40),

                      _buildLabel('Email Address'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _emailController,
                        hint: 'you@example.com',
                        icon: Icons.mail_outline_rounded,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 20),

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

                      if (!_isSignUp) ...[
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              if (_emailController.text.isNotEmpty) {
                                _auth.sendPasswordResetEmail(email: _emailController.text.trim());
                                _showError('Password reset link sent to your email');
                              } else {
                                _showError('Please enter your email first');
                              }
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                color: const Color(0xFF6EE7B7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 32),

                      GestureDetector(
                        onTap: _isLoading ? null : _handleAuth,
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
                                    _isSignUp ? 'Sign Up' : 'Sign In',
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

                      GestureDetector(
                        onTap: _isLoading ? null : _handleGoogleSignIn,
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

                      Center(
                        child: GestureDetector(
                          onTap: () => setState(() => _isSignUp = !_isSignUp),
                          child: RichText(
                            text: TextSpan(
                              text: _isSignUp ? "Already have an account? " : "Don't have an account? ",
                              style: GoogleFonts.dmSans(
                                fontSize: 13,
                                color: const Color(0xFF64748B),
                              ),
                              children: [
                                TextSpan(
                                  text: _isSignUp ? 'Sign In' : 'Sign Up',
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
