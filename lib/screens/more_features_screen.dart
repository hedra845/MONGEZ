import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/common_widgets.dart';
import 'virtual_study_rooms_screen.dart';
import 'gpa_calculator_screen.dart';
import 'ai_audio_notes_screen.dart';
import 'habits_tracker_screen.dart';
import 'ai_tutor_chat_screen.dart';
import 'smart_flashcards_screen.dart';
import 'ambient_sounds_screen.dart';
import 'student_wellness_screen.dart';
import 'quick_notes_screen.dart';
import 'deadlines_screen.dart';
import 'distraction_lock_screen.dart';
import 'reports_progress_screen.dart';
import 'ai_quiz_generation_screen.dart';
import 'gamification_rewards_screen.dart';
import 'subscription_plans_screen.dart';

class MoreFeaturesScreen extends StatelessWidget {
  const MoreFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B1324) : const Color(0xFFF6F8FC),
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "جميع مزايا مُنجز الذكية",
              onBack: null,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                              : [const Color(0xFF2563EB), const Color(0xFF0284C7)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.25),
                            blurRadius: 14,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 26),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "منظومة تفوق دراسي متكاملة",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "أكثر من 12 أداة ذكية للمذاكرة الفردية والجماعية والتنظيم النفسي",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontSize: 11,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Section 1: Study & AI Tools
                    _buildSectionHeader("أدوات المذاكرة والذكاء الاصطناعي", Icons.school_rounded, isDark),
                    const SizedBox(height: 10),
                    _buildGrid([
                      _FeatureItem(
                        title: "غرف المذاكرة",
                        subtitle: "مذاكرة جماعية حية",
                        icon: Icons.groups_rounded,
                        color: const Color(0xFF2563EB),
                        screen: const VirtualStudyRoomsScreen(),
                      ),
                      _FeatureItem(
                        title: "حاسبة المعدل",
                        subtitle: "توقع درجة الفاينل",
                        icon: Icons.calculate_rounded,
                        color: const Color(0xFF10B981),
                        screen: const GpaCalculatorScreen(),
                      ),
                      _FeatureItem(
                        title: "ملخصات صوتية",
                        subtitle: "تفريغ وتلخيص AI",
                        icon: Icons.mic_external_on_rounded,
                        color: const Color(0xFF0EA5E9),
                        screen: const AiAudioNotesScreen(),
                      ),
                      _FeatureItem(
                        title: "المعلم الذكي",
                        subtitle: "شرح فوري وتوجيه",
                        icon: Icons.smart_toy_rounded,
                        color: const Color(0xFF8B5CF6),
                        screen: const AiTutorChatScreen(),
                      ),
                      _FeatureItem(
                        title: "البطاقات الذكية",
                        subtitle: "تكرار متباعد للحفظ",
                        icon: Icons.style_rounded,
                        color: const Color(0xFFF59E0B),
                        screen: const SmartFlashcardsScreen(),
                      ),
                      _FeatureItem(
                        title: "بنك الاختبارات",
                        subtitle: "توليد كويزات ذكية",
                        icon: Icons.assignment_outlined,
                        color: const Color(0xFFEC4899),
                        screen: const AiQuizGenerationScreen(),
                      ),
                    ], isDark, context),

                    const SizedBox(height: 20),

                    // Section 2: Discipline & Habits
                    _buildSectionHeader("الانضباط والعادات والتحفيز", Icons.shield_rounded, isDark),
                    const SizedBox(height: 10),
                    _buildGrid([
                      _FeatureItem(
                        title: "تتبع العادات",
                        subtitle: "شعلات التزام يومي",
                        icon: Icons.checklist_rtl_rounded,
                        color: const Color(0xFF6366F1),
                        screen: const HabitsTrackerScreen(),
                      ),
                      _FeatureItem(
                        title: "قفل المشتتات",
                        subtitle: "حظر تطبيقات الهاتف",
                        icon: Icons.lock_outline_rounded,
                        color: const Color(0xFFEF4444),
                        screen: const DistractionLockScreen(),
                      ),
                      _FeatureItem(
                        title: "صحة الطالب",
                        subtitle: "ماء وتنفس وتمارين",
                        icon: Icons.spa_rounded,
                        color: const Color(0xFF14B8A6),
                        screen: const StudentWellnessScreen(),
                      ),
                      _FeatureItem(
                        title: "صوتيات التركيز",
                        subtitle: "مطر ومكتبة وهدوء",
                        icon: Icons.headphones_rounded,
                        color: const Color(0xFF0284C7),
                        screen: const AmbientSoundsScreen(),
                      ),
                      _FeatureItem(
                        title: "الملاحظات السريعة",
                        subtitle: "تدوين أفكار المذاكرة",
                        icon: Icons.edit_note_rounded,
                        color: const Color(0xFFF97316),
                        screen: const QuickNotesScreen(),
                      ),
                      _FeatureItem(
                        title: "المواعيد المهمة",
                        subtitle: "الامتحانات والتسليمات",
                        icon: Icons.notifications_none_rounded,
                        color: const Color(0xFF06B6D4),
                        screen: const DeadlinesScreen(),
                      ),
                      _FeatureItem(
                        title: "نظام الجوائز",
                        subtitle: "أوسمة ونقاط إنجاز",
                        icon: Icons.star_rounded,
                        color: const Color(0xFFEAB308),
                        screen: const GamificationRewardsScreen(),
                      ),
                      _FeatureItem(
                        title: "تقارير الأداء",
                        subtitle: "إحصائيات ورسوم بيانية",
                        icon: Icons.bar_chart_rounded,
                        color: const Color(0xFF3B82F6),
                        screen: const ReportsProgressScreen(),
                      ),
                      _FeatureItem(
                        title: "الاشتراك الرمزي",
                        subtitle: "باقات الطالب والامتيازات",
                        icon: Icons.workspace_premium_rounded,
                        color: const Color(0xFF7C3AED),
                        screen: const SubscriptionPlansScreen(),
                      ),
                    ], isDark, context),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(width: 6),
        Icon(icon, size: 18, color: const Color(0xFF2563EB)),
      ],
    );
  }

  Widget _buildGrid(List<_FeatureItem> items, bool isDark, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, idx) {
        final item = items[idx];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => item.screen),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF131D33) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.015),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, color: item.color, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                          height: 1.2,
                        ),
                      ),
                      Text(
                        item.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: isDark ? Colors.white24 : Colors.black26,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FeatureItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;

  const _FeatureItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.screen,
  });
}
