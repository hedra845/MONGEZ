import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';
import 'target_goal_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _nameController = TextEditingController(text: "أحمد محمد");
  final _emailController = TextEditingController(text: "ahmed@example.com");
  final _passwordController = TextEditingController(text: "••••••••");
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderNavBar(
                title: "",
                onBack: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 10),

              // Small Mongez Logo at top
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0F2547).withValues(alpha: isDark ? 0.3 : 0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: Column(
                  children: [
                    Text(
                      "مرحباً بك في مُنجز",
                      style: GoogleFonts.cairo(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : const Color(0xFF0F2547),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ابدأ رحلتك نحو التميز والمذاكرة الفعالة",
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF5A6E8C),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Full Name Field
              Text(
                "الاسم الكامل",
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "أحمد محمد",
                  prefixIcon: const Icon(Icons.person_outline_rounded, color: Color(0xFF1E5BB8)),
                ),
              ),
              const SizedBox(height: 16),

              // Email Field
              Text(
                "البريد الإلكتروني",
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "ahmed@example.com",
                  prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1E5BB8)),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              Text(
                "كلمة المرور",
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "••••••••",
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF1E5BB8)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xFF8F9FB5),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 26),

              // Create Account Button
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<AppProvider>(context, listen: false).updateUserProfile(
                      name: _nameController.text.trim(),
                      email: _emailController.text.trim(),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const TargetGoalScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5BB8),
                    elevation: 4,
                    shadowColor: const Color(0xFF1E5BB8).withValues(alpha: 0.4),
                  ),
                  child: Text(
                    "إنشاء حساب",
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(child: Divider(color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      "أو المتابعة باستخدام",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF8F9FB5),
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0))),
                ],
              ),
              const SizedBox(height: 18),

              // Social logins (Google & Apple)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialBtn(
                    icon: Icons.g_mobiledata_rounded,
                    label: "Google",
                    color: Colors.red,
                    isDark: isDark,
                  ),
                  const SizedBox(width: 16),
                  _buildSocialBtn(
                    icon: Icons.apple_rounded,
                    label: "Apple",
                    color: isDark ? Colors.white : Colors.black,
                    isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "لديك حساب بالفعل؟ تسجيل الدخول",
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E5BB8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtn({
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      width: 64,
      height: 52,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16223B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
