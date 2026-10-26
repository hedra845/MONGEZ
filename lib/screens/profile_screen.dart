import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';
import 'ai_tutor_chat_screen.dart';
import 'student_wellness_screen.dart';
import 'quick_notes_screen.dart';
import 'virtual_study_rooms_screen.dart';
import 'gpa_calculator_screen.dart';
import 'ai_audio_notes_screen.dart';
import 'deadlines_screen.dart';
import 'target_goal_screen.dart';
import 'habits_tracker_screen.dart';
import 'subscription_plans_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderNavBar(
                title: "الملف الشخصي",
                onBack: null,
              ),

              const SizedBox(height: 12),

              // User Info Card with Official Logo Badge
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF16223B), const Color(0xFF111A2D)]
                        : [Colors.white, const Color(0xFFF0F5FD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F2547).withValues(alpha: isDark ? 0.3 : 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF1E5BB8), width: 2.5),
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF10B981),
                            ),
                            child: const Icon(Icons.check, size: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      app.userName,
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : const Color(0xFF0F2547),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      app.userEmail,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF5A6E8C),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E5BB8), Color(0xFF0EA5E9)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${app.targetFaculty} • الهدف: ${app.targetPercentage.toInt()}%",
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Subscription Status Banner
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SubscriptionPlansScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF312E81), Color(0xFF4F46E5), Color(0xFF7C3AED)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4F46E5).withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.workspace_premium_rounded,
                          color: Color(0xFFFFD700),
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "نشط",
                                    style: GoogleFonts.cairo(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    app.subscriptionPlan,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "وصول كامل لكافة أدوات الذكاء الاصطناعي وبنك الأسئلة",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "ترقية / إدارة",
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4338CA),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Settings Items List
              _buildSettingGroup(
                isDark: isDark,
                items: [
                  _buildSettingTile(
                    title: "باقات الاشتراك والدفع الرمزي 💎",
                    icon: Icons.card_membership_rounded,
                    color: const Color(0xFF7C3AED),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SubscriptionPlansScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "حسابي والهدف الأكاديمي",
                    icon: Icons.person_outline_rounded,
                    color: const Color(0xFF1E5BB8),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const TargetGoalScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "غرف المذاكرة الجماعية (Study Rooms)",
                    icon: Icons.groups_rounded,
                    color: const Color(0xFF1E5BB8),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const VirtualStudyRoomsScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "حاسبة المعدل وتوقع النتيجة (GPA)",
                    icon: Icons.calculate_rounded,
                    color: const Color(0xFF10B981),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const GpaCalculatorScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "الملاحظات الصوتية والملخصات الذكية",
                    icon: Icons.mic_external_on_rounded,
                    color: const Color(0xFF0EA5E9),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AiAudioNotesScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "تتبع العادات والدعم النفسي",
                    icon: Icons.checklist_rtl_rounded,
                    color: const Color(0xFF6366F1),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HabitsTrackerScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "المعلم الذكي الفوري (AI Tutor)",
                    icon: Icons.smart_toy_rounded,
                    color: const Color(0xFF8B5CF6),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AiTutorChatScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "صحة ورفاهية الطالب",
                    icon: Icons.spa_rounded,
                    color: const Color(0xFF10B981),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const StudentWellnessScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "الملاحظات الدراسية السريعة",
                    icon: Icons.edit_note_rounded,
                    color: const Color(0xFFF59E0B),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const QuickNotesScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "التنبيهات والمواعيد المهمة",
                    icon: Icons.notifications_none_rounded,
                    color: const Color(0xFF0EA5E9),
                    isDark: isDark,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DeadlinesScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "صندوق الإشعارات والتنبيهات",
                    icon: Icons.notifications_active_rounded,
                    color: const Color(0xFF2563EB),
                    isDark: isDark,
                    trailing: app.unreadNotificationsCount > 0
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${app.unreadNotificationsCount}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                      );
                    },
                  ),
                  _buildSettingTile(
                    title: "الوضع الداكن (Dark Mode)",
                    icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: const Color(0xFF8B5CF6),
                    isDark: isDark,
                    trailing: Switch.adaptive(
                      value: isDark,
                      activeColor: const Color(0xFF1E5BB8),
                      onChanged: (val) {
                        app.toggleTheme();
                      },
                    ),
                    onTap: () {
                      app.toggleTheme();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Logout Button
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "تم تسجيل الخروج بنجاح",
                        style: GoogleFonts.cairo(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout_rounded, color: Color(0xFFEF4444), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "تسجيل الخروج",
                        style: GoogleFonts.cairo(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFEF4444),
                        ),
                      ),
                    ],
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

  static Widget _buildSettingGroup({required List<Widget> items, required bool isDark}) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111A2D) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }

  static Widget _buildSettingTile({
    required String title,
    required IconData icon,
    required Color color,
    required bool isDark,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      trailing: trailing ??
          Icon(
            Icons.chevron_right_rounded,
            color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
          ),
      title: Text(
        title,
        style: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF0F2547),
        ),
      ),
    );
  }
}
